package com.servlet.admin;

import com.dao.ProjectDao;
import com.db.DBConnect;
import com.entity.Project;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/AdminPaymentTrackingServlet")
public class AdminPaymentTrackingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath(); // Get dynamic context path

        try {
            ProjectDao dao = new ProjectDao(DBConnect.getConn());
            
            // ✅ Use only completed + paid projects with rating
            List<Project> projects = dao.getAllCompletedProjectsWithRatings();

            request.setAttribute("projects", projects);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/payment_tracking.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/admin/dashboard.jsp?msg=error");
        }
    }
}
