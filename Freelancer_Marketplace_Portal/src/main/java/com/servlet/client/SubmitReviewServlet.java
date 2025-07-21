package com.servlet.client;

import com.dao.ReviewDao;
import com.db.DBConnect;
import com.entity.Client;
import com.entity.Review;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        int freelancerId = Integer.parseInt(request.getParameter("freelancerId"));
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String reviewText = request.getParameter("review");

        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("clientObj");

        if (client == null) {
            response.sendRedirect(contextPath + "/client/login.jsp?msg=unauthorized");
            return;
        }

        Review r = new Review();
        r.setFreelancerId(freelancerId);
        r.setClientId(client.getId());
        r.setProjectId(projectId);
        r.setRating(rating);
        r.setReview(reviewText);

        ReviewDao dao = new ReviewDao(DBConnect.getConn());
        boolean success = dao.addReview(r);

        // ✅ Redirect to servlet for proper project reload
        if (success) {
            response.sendRedirect(contextPath + "/ClientDashboardServlet?msg=reviewed");
        } else {
            response.sendRedirect(contextPath + "/ClientDashboardServlet?msg=fail");
        }
    }
}
