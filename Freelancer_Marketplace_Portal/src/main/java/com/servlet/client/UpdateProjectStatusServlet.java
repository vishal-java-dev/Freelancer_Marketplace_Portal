package com.servlet.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.dao.ProjectDao;
import com.db.DBConnect;

@WebServlet("/UpdateProjectStatusServlet")
public class UpdateProjectStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        try {
            String projectIdStr = request.getParameter("projectId");
            String status = request.getParameter("status");

            if (projectIdStr == null || projectIdStr.isEmpty() || status == null || status.trim().isEmpty()) {
                session.setAttribute("errorMsg", "Project ID or Status is missing.");
                response.sendRedirect("client/manage_status.jsp");
                return;
            }

            int projectId = Integer.parseInt(projectIdStr.trim());

            ProjectDao dao = new ProjectDao(DBConnect.getConn());
            boolean result = dao.updateProjectStatus(projectId, status.trim());

            if (result) {
                session.setAttribute("succMsg", "✅ Project status updated successfully.");
            } else {
                session.setAttribute("errorMsg", "❌ Failed to update project status.");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Invalid Project ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred while updating project status.");
        }

        response.sendRedirect("client/manage_status.jsp");
    }
}
