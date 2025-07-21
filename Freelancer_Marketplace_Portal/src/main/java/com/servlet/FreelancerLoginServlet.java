package com.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.dao.FreelancerDao;
import com.db.DBConnect;
import com.entity.Freelancer;

@WebServlet("/FreelancerLoginServlet")
public class FreelancerLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        FreelancerDao dao = new FreelancerDao(DBConnect.getConn());
        Freelancer freelancer = dao.loginFreelancer(email, password);

        if (freelancer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("freelancerObj", freelancer);
            response.sendRedirect("freelancer/dashboard.jsp");
        } else {
            response.sendRedirect("freelancer/login.jsp?msg=invalid");
        }
    }
}
