package com.servlet.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

import com.dao.BidDao;
import com.db.DBConnect;
import com.entity.Bid;
import com.entity.Client;

@WebServlet("/viewBids")
public class ViewBidsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("clientObj");

        if (client == null) {
            response.sendRedirect("client/login.jsp?msg=unauthorized");
            return;
        }

        String pid = request.getParameter("projectId");
        if (pid == null || pid.isEmpty()) {
            response.sendRedirect("client/view_projects.jsp?msg=invalid");
            return;
        }

        try {
            int projectId = Integer.parseInt(pid);
            BidDao bidDao = new BidDao(DBConnect.getConn());
            List<Bid> bidList = bidDao.getBidsByProjectId(projectId);

            request.setAttribute("projectId", projectId);
            request.setAttribute("bidList", bidList);
            request.getRequestDispatcher("client/view_bids.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("client/view_projects.jsp?msg=invalid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("client/view_projects.jsp?msg=error");
        }
    }
}
