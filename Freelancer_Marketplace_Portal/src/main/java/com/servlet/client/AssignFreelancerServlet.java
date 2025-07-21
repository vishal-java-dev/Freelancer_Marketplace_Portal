package com.servlet.client;

import com.dao.ProjectDao;
import com.db.DBConnect;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AssignFreelancerServlet")
public class AssignFreelancerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int projectId = Integer.parseInt(request.getParameter("projectId"));
        int freelancerId = Integer.parseInt(request.getParameter("freelancerId"));

        ProjectDao dao = new ProjectDao(DBConnect.getConn());
        boolean assigned = dao.assignFreelancerToProject(projectId, freelancerId);

        HttpSession session = request.getSession();
        if (assigned) {
            session.setAttribute("succMsg", "Freelancer assigned successfully.");
        } else {
            session.setAttribute("errorMsg", "Failed to assign freelancer.");
        }

        response.sendRedirect("client/manage_status.jsp");
    }
}
