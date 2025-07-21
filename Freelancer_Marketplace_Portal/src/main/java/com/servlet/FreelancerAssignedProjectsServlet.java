package com.servlet;

import com.dao.ProjectDao;
import com.db.DBConnect;
import com.entity.Freelancer;
import com.entity.Project;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/FreelancerAssignedProjectsServlet")
public class FreelancerAssignedProjectsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Freelancer freelancer = (Freelancer) session.getAttribute("freelancerObj");

        if (freelancer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ProjectDao dao = new ProjectDao(DBConnect.getConn());
        List<Project> assignedProjects = dao.getAssignedProjects(freelancer.getId());

        request.setAttribute("assignedProjects", assignedProjects);
        RequestDispatcher rd = request.getRequestDispatcher("/freelancer/assigned_projects.jsp");
        rd.forward(request, response);
    }
}
