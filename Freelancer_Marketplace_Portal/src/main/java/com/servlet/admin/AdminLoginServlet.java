package com.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.entity.Admin;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final String ADMIN_EMAIL = "admin@gmail.com";
    private static final String ADMIN_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            Admin admin = new Admin();
            admin.setId(1); // Optional
            admin.setName("Super Admin");
            admin.setEmail(email);

            HttpSession session = request.getSession();
            session.setAttribute("adminObj", admin);
            response.sendRedirect("admin/dashboard.jsp");
        } else {
            response.sendRedirect("admin/login.jsp?msg=invalid");
        }
    }
}
