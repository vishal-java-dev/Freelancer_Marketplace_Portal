package com.servlet;

import java.io.IOException;

import com.dao.ProjectDao;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MarkProjectCompletedServlet")
public class MarkProjectCompletedServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int projectId = Integer.parseInt(req.getParameter("projectId"));
        ProjectDao dao = new ProjectDao(DBConnect.getConn());

        boolean updated = dao.updateProjectStatus(projectId, "completed");

        HttpSession session = req.getSession();
        if (updated) {
            session.setAttribute("succMsg", "Project marked as completed.");
        } else {
            session.setAttribute("errorMsg", "Something went wrong.");
        }

        res.sendRedirect(req.getContextPath() + "/freelancer/dashboard.jsp");
    }
}

