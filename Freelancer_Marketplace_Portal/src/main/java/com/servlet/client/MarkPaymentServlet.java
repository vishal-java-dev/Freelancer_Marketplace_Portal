package com.servlet.client;

import com.dao.ProjectDao;
import com.db.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/MarkPaymentServlet")
public class MarkPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            Date paymentDate = new Date(System.currentTimeMillis());

            ProjectDao dao = new ProjectDao(DBConnect.getConn());

            boolean success = dao.markPaymentTransferred(projectId, paymentDate);

            HttpSession session = request.getSession();
            if (success) {
                // Optional logging
                dao.logPayment(projectId, "client", "manual", null, "Client marked payment.");
                session.setAttribute("succMsg", "Payment marked as transferred.");
            } else {
                session.setAttribute("errorMsg", "Failed to update payment status.");
            }

            response.sendRedirect("client/view_projects.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("client/view_projects.jsp?msg=error");
        }
    }
}
