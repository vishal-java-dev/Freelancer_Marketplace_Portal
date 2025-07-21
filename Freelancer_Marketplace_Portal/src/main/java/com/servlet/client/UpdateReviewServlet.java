package com.servlet.client;

import com.dao.ReviewDao;
import com.db.DBConnect;
import com.entity.Review;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateReviewServlet")
public class UpdateReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int freelancerId = Integer.parseInt(request.getParameter("freelancerId"));
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String reviewText = request.getParameter("review");

        Review updatedReview = new Review();
        updatedReview.setFreelancerId(freelancerId);
        updatedReview.setProjectId(projectId);
        updatedReview.setRating(rating);
        updatedReview.setReview(reviewText);

        ReviewDao dao = new ReviewDao(DBConnect.getConn());
        boolean updated = dao.updateReview(updatedReview);

        String ctx = request.getContextPath();
        if (updated) {
            // ✅ Redirect to the servlet, not JSP
            response.sendRedirect(ctx + "/ClientDashboardServlet?msg=updated");
        } else {
            response.sendRedirect(ctx + "/ClientDashboardServlet?msg=update_failed");
        }
    }
}
