
package com.servlet;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/freelancerLogout")
public class FreelancerLogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(); // ✅ use getSession() (creates session if none)

        session.removeAttribute("freelancerObj");
        session.setAttribute("sucMsg", "Freelancer Logout Successfully");

        response.sendRedirect("freelancer/login.jsp"); // ✅ Make sure this matches the correct JSP filename
    }

    }


