package com.servlet.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.dao.ClientDao;
import com.db.DBConnect;
import com.entity.Client;

@WebServlet("/ClientLoginServlet")
public class ClientLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        ClientDao dao = new ClientDao(DBConnect.getConn());
        Client client = dao.login(email, password);

        HttpSession session = request.getSession();

        if (client != null) {
            session.setAttribute("clientObj", client);
            session.removeAttribute("errorMsg"); // Clear previous error message

            // ✅ Redirect to dashboard servlet instead of direct JSP
            response.sendRedirect(request.getContextPath() + "/ClientDashboardServlet");
        } else {
            session.setAttribute("errorMsg", "Invalid email or password. Please try again.");
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
        }
    }
}
