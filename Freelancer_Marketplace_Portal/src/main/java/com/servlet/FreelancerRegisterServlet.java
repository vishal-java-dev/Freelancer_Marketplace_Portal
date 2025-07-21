package com.servlet;

import java.io.IOException;

import java.sql.*;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FreelancerRegisterServlet")
public class FreelancerRegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		String skills = request.getParameter("skills");
		int experience = Integer.parseInt(request.getParameter("experience"));
		String password = request.getParameter("password");

		try {
			Connection conn = DBConnect.getConn();
			PreparedStatement ps = conn.prepareStatement(
					"INSERT INTO freelancers (fullname, email, skills, experience, password) VALUES (?, ?, ?, ?, ?)");
			ps.setString(1, fullname);
			ps.setString(2, email);
			ps.setString(3, skills);
			ps.setInt(4, experience);
			ps.setString(5, password);

			int rowsInserted = ps.executeUpdate();

			if (rowsInserted > 0) {
				response.sendRedirect("freelancer/login.jsp?msg=success");
			} else {
				response.sendRedirect("freelancer/register.jsp?msg=fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("freelancer/register.jsp?msg=error");
		}
	}
}
