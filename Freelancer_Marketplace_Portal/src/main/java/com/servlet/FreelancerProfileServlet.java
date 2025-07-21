package com.servlet;

import com.dao.ReviewDao;
import com.db.DBConnect;
import com.entity.Freelancer;
import com.entity.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/FreelancerProfileServlet")
public class FreelancerProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Freelancer freelancer = (Freelancer) session.getAttribute("freelancerObj");

        if (freelancer == null) {
            response.sendRedirect("freelancer/login.jsp?msg=unauthorized");
            return;
        }

        int freelancerId = freelancer.getId();
        ReviewDao reviewDao = new ReviewDao(DBConnect.getConn());

        List<Review> freelancerReviews = reviewDao.getReviewsByFreelancerId(freelancerId);
        request.setAttribute("freelancerReviews", freelancerReviews);

        request.getRequestDispatcher("freelancer/view_profile.jsp").forward(request, response);
    }
}
