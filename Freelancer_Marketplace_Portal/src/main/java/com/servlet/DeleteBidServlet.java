package com.servlet;

import java.io.IOException;

import com.dao.BidDao;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteBidServlet")
public class DeleteBidServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bidId = Integer.parseInt(request.getParameter("bidId"));
        BidDao dao = new BidDao(DBConnect.getConn());
        HttpSession session = request.getSession();

        if (dao.deleteBidById(bidId)) {
            session.setAttribute("succMsg", "Bid deleted successfully.");
        } else {
            session.setAttribute("errorMsg", "Failed to delete bid.");
        }
        response.sendRedirect("freelancer/view_projects.jsp");
    }
}
