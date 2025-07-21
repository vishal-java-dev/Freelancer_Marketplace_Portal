package com.servlet;

import com.dao.BidDao;
import com.db.DBConnect;
import com.entity.Bid;
import com.entity.Freelancer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SubmitBidServlet")
public class SubmitBidServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            double bidAmount = Double.parseDouble(request.getParameter("bidAmount"));
            String message = request.getParameter("message");

            HttpSession session = request.getSession(false);
            Freelancer freelancer = (Freelancer) session.getAttribute("freelancerObj");

            if (freelancer == null) {
                response.sendRedirect("freelancer/login.jsp?msg=loginfirst");
                return;
            }

            Bid bid = new Bid();
            bid.setProjectId(projectId);
            bid.setFreelancerId(freelancer.getId());
            bid.setBidAmount(bidAmount);
            bid.setMessage(message);

            BidDao bidDao = new BidDao(DBConnect.getConn());

            boolean success = bidDao.placeBid(bid);

            if (success) {
                response.sendRedirect("freelancer/view_projects.jsp?msg=bidsuccess");
            } else {
                response.sendRedirect("freelancer/view_projects.jsp?msg=bidfail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("freelancer/view_projects.jsp?msg=error");
        }
    }
}
