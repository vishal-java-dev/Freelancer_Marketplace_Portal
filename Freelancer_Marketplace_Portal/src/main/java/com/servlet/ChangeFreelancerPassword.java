package com.servlet;

import java.io.IOException;

import com.dao.FreelancerDao;
import com.db.DBConnect;
import com.entity.Freelancer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ChangeFreelancerPassword")
public class ChangeFreelancerPassword extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        int freelancerId = Integer.parseInt(request.getParameter("freelancerId"));
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        FreelancerDao dao = new FreelancerDao(DBConnect.getConn());
        Freelancer freelancer = dao.getFreelancerById(freelancerId);

        if (freelancer == null) {
            session.setAttribute("errorMsg", "User not found.");
            response.sendRedirect("freelancer/change_password.jsp");
            return;
        }

        if (!freelancer.getPassword().equals(oldPassword)) {
            session.setAttribute("errorMsg", "Old password is incorrect.");
            response.sendRedirect("freelancer/change_password.jsp");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("errorMsg", "New passwords do not match.");
            response.sendRedirect("freelancer/change_password.jsp");
            return;
        }

        boolean updated = dao.updatePassword(freelancerId, newPassword);
        if (updated) {
            session.setAttribute("sucMsg", "Password updated successfully.");
        } else {
            session.setAttribute("errorMsg", "Failed to update password. Try again.");
        }

        response.sendRedirect("freelancer/change_password.jsp");
    }
}
