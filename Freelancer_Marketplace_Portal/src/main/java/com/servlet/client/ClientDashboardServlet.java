package com.servlet.client;

import com.dao.ProjectDao;
import com.dao.ReviewDao;
import com.db.DBConnect;
import com.entity.Client;
import com.entity.Project;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ClientDashboardServlet")
public class ClientDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("clientObj");

        // Get dynamic context path
        String contextPath = request.getContextPath();

        // Redirect to login if session is missing
        if (client == null) {
            response.sendRedirect(contextPath + "/client/login.jsp?msg=unauthorized");
            return;
        }

        try {
            int clientId = client.getId();

            // Initialize DAOs
            ProjectDao projectDao = new ProjectDao(DBConnect.getConn());
            ReviewDao reviewDao = new ReviewDao(DBConnect.getConn());

            // Get all projects posted by the client
            List<Project> allProjects = projectDao.getProjectsByClientId(clientId);
            List<Project> completedProjects = new ArrayList<>();

            // Filter only completed and paid projects
            for (Project p : allProjects) {
                if ("completed".equalsIgnoreCase(p.getStatus())
                        && "transferred".equalsIgnoreCase(p.getPaymentStatus())) {

                    boolean hasReviewed = reviewDao.hasReview(clientId, p.getId());
                    p.setCanReview(!hasReviewed);  // true if review not submitted
                    completedProjects.add(p);
                }
            }

            // Set data and forward to JSP
            request.setAttribute("completedProjects", completedProjects);
            request.getRequestDispatcher("/client/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/client/dashboard.jsp?msg=dashboard_failed");
        }
    }
}
