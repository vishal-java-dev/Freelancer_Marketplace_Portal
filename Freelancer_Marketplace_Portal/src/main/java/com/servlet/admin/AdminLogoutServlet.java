package com.servlet.admin;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminLogout")
public class AdminLogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // ✅ Do not create a new session if one doesn't exist

        if (session != null) {
            session.removeAttribute("adminObj");
            session.setAttribute("sucMsg", "Admin Logout Successfully");
        }

        response.sendRedirect("admin/login.jsp"); // ✅ Assuming admin login page is at admin/login.jsp
    }
}
