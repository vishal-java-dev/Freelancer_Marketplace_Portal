package com.servlet.client;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.dao.ClientDao;
import com.db.DBConnect;
import com.entity.Client;

@WebServlet("/ClientRegisterServlet")
public class ClientRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("fullname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String company = request.getParameter("company");
		String skills = request.getParameter("skills");

		Client client = new Client();
		client.setFullname(name);
		client.setEmail(email);
		client.setPassword(password);
		client.setCompany(company);  // ✅ Make sure this line exists
		client.setSkills(skills);

		ClientDao dao = new ClientDao(DBConnect.getConn());
		boolean success = dao.registerClient(client);

		HttpSession session = request.getSession();

		if (success) {
			session.setAttribute("successMsg", "Client registered successfully. Please login.");
			response.sendRedirect("client/login.jsp");
		} else {
			session.setAttribute("errorMsg", "Something went wrong. Try again.");
			response.sendRedirect("client/register.jsp");
		}
	}
}
