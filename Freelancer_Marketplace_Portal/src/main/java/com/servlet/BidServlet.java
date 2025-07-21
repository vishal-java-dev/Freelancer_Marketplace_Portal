package com.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import com.dao.BidDao;
import com.db.DBConnect;
import com.entity.Bid;
import com.entity.Freelancer;

@WebServlet("/BidServlet")
public class BidServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            double bidAmount = Double.parseDouble(request.getParameter("bidAmount"));
            int timeline = Integer.parseInt(request.getParameter("timeline"));
            String coverLetter = request.getParameter("coverLetter");

            System.out.println("ðŸš€ Incoming bid request");
            System.out.println("Project ID: " + projectId);
            System.out.println("Bid Amount: " + bidAmount);
            System.out.println("Timeline: " + timeline);
            System.out.println("Cover Letter: " + coverLetter);

            // Get freelancer from session
            Freelancer freelancerObj = (Freelancer) session.getAttribute("freelancerObj");

            if (freelancerObj == null) {
                session.setAttribute("errorMsg", "Login required to bid.");
                response.sendRedirect(request.getContextPath() + "/freelancer/login.jsp");
                return;
            }

            int freelancerId = freelancerObj.getId();
            String freelancerName = freelancerObj.getFullname();

            System.out.println("Freelancer ID: " + freelancerId);
            System.out.println("Freelancer Name: " + freelancerName);

            Bid bid = new Bid();
            bid.setProjectId(projectId);
            bid.setFreelancerId(freelancerId);
            bid.setFreelancerName(freelancerName);
            bid.setBidAmount(bidAmount);
            bid.setTimeline(timeline);
            bid.setCoverLetter(coverLetter);

            BidDao bidDao = new BidDao(DBConnect.getConn());
            System.out.println("ðŸ”� Submitting bid with cover letter: " + coverLetter);
            boolean success = bidDao.placeBid(bid);

            if (success) {
                session.setAttribute("sucMsg", "Bid placed successfully!");
                System.out.println("âœ… Bid placed successfully.");
                System.out.println("CoverLetter Received: " + coverLetter);

            } else {
                session.setAttribute("errorMsg", "Failed to place bid.");
                System.out.println("â�Œ Failed to place bid.");
            }

            response.sendRedirect("freelancer/bid_project.jsp?pid=" + projectId);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Something went wrong.");
            response.sendRedirect("freelancer/bid_project.jsp?pid=" + request.getParameter("projectId"));
        }
    }
}
