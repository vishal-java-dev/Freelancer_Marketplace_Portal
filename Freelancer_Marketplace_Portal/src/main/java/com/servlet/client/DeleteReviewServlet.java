package com.servlet.client;

import com.dao.ReviewDao;
import com.db.DBConnect;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/DeleteReviewServlet")
public class DeleteReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int freelancerId = Integer.parseInt(request.getParameter("freelancerId"));
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        HttpSession session = request.getSession();
        String contextPath = request.getContextPath();

        try {
            ReviewDao dao = new ReviewDao(DBConnect.getConn());
            boolean deleted = dao.deleteReviewByProjectAndFreelancer(projectId, freelancerId);

            if (deleted) {
                // ✅ Redirect to servlet for proper data reload
                response.sendRedirect(contextPath + "/ClientDashboardServlet?msg=review_deleted");
            } else {
                response.sendRedirect(contextPath + "/ClientDashboardServlet?msg=delete_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/ClientDashboardServlet?msg=error");
        }
    }
}
