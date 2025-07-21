package com.servlet.admin;

import java.io.IOException;
import java.util.List;

import com.dao.ProjectDao;
import com.db.DBConnect;
import com.entity.Project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminCompletedProjectsServlet")
public class AdminCompletedProjectsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Project> completedProjects = new ProjectDao(DBConnect.getConn())
                .getAllCompletedProjectsWithRatings();

        request.setAttribute("completedProjects", completedProjects);
        request.getRequestDispatcher("/admin/completed_projects.jsp").forward(request, response);
    }
}

