package com.servlet.client;

import com.dao.ClientDao;
import com.db.DBConnect;
import com.entity.Client;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int clientId = Integer.parseInt(request.getParameter("clientId"));
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        ClientDao dao = new ClientDao(DBConnect.getConn());

        Client client = dao.getClientById(clientId);

        if (client != null && client.getPassword().equals(oldPassword)) {
            if (newPassword.equals(confirmPassword)) {
                boolean success = dao.updatePassword(clientId, newPassword);
                if (success) {
                    session.setAttribute("msg", "Password updated successfully!");
                } else {
                    session.setAttribute("error", "Something went wrong while updating.");
                }
            } else {
                session.setAttribute("error", "New and Confirm Password do not match.");
            }
        } else {
            session.setAttribute("error", "Incorrect old password.");
        }

        response.sendRedirect("client/change_password.jsp");
    }
}
