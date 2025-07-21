package com.servlet.client;

import com.dao.PaymentLogDao;
import com.dao.ProjectDao;
import com.db.DBConnect;
import com.entity.PaymentLog;
import com.entity.Project;
import com.entity.Client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;

@WebServlet("/CompleteProjectServlet")
public class CompleteProjectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            String paymentMode = request.getParameter("paymentMode");
            String transactionId = request.getParameter("transactionId");
            String notes = request.getParameter("notes");

            HttpSession session = request.getSession();
            Client client = (Client) session.getAttribute("clientObj");

            if (client == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Connection conn = DBConnect.getConn();
            ProjectDao projectDao = new ProjectDao(conn);
            PaymentLogDao logDao = new PaymentLogDao(conn);

            // Step 1: Fetch project to get freelancer ID and amount
            Project project = projectDao.getProjectById(projectId);
            if (project == null) {
                session.setAttribute("errorMsg", "Project not found.");
                response.sendRedirect("client/view_projects.jsp");
                return;
            }

            int freelancerId = project.getAssignedTo();
            double amount = project.getBudget();

            Date currentDate = new Date(System.currentTimeMillis());

            // Step 2: Update project status
            boolean projectUpdated = projectDao.markProjectAsCompleted(projectId, currentDate);

            // Step 3: Insert payment log
            boolean logInserted = false;
            if (projectUpdated) {
                PaymentLog log = new PaymentLog();
                log.setProjectId(projectId);
                log.setMarkedBy("client");
                log.setPaymentMode(paymentMode);
                log.setTransactionId(transactionId);
                log.setNotes(notes);
                log.setClientId(client.getId());
                log.setFreelancerId(freelancerId);
                log.setAmount(amount);

                logInserted = logDao.insertPaymentLog(log);
            }

            if (projectUpdated && logInserted) {
                session.setAttribute("succMsg", "Project marked as completed & payment logged successfully.");
            } else if (projectUpdated) {
                session.setAttribute("errorMsg", "Project updated but payment log failed.");
            } else {
                session.setAttribute("errorMsg", "Failed to mark project as completed.");
            }

            response.sendRedirect("client/view_projects.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("client/view_projects.jsp?msg=error");
        }
    }
}
