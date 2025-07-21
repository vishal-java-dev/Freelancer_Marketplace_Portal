package com.servlet;

import com.dao.ProjectDao;
import com.db.DBConnect;
import com.entity.Project;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;

@WebServlet("/freelancerdownloadInvoice")
public class DownloadInvoiceServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int projectId = Integer.parseInt(request.getParameter("projectId"));

			Connection conn = DBConnect.getConn();
			ProjectDao dao = new ProjectDao(conn);
			Project project = dao.getProjectById(projectId);

			if (project == null) {
				response.sendRedirect("freelancer/earnings.jsp?msg=error");
				return;
			}

			String invoiceContent = generateInvoiceText(project);

			response.setContentType("text/plain");
			response.setHeader("Content-Disposition", "attachment; filename=invoice_project_" + projectId + ".txt");

			OutputStream out = response.getOutputStream();
			out.write(invoiceContent.getBytes(StandardCharsets.UTF_8));
			out.flush();
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("freelancer/earnings.jsp?msg=error");
		}
	}

	private String generateInvoiceText(Project project) {
		StringBuilder sb = new StringBuilder();
		sb.append("====== Freelancer Project Invoice ======\n");
		sb.append("Invoice Date: ").append(new java.util.Date()).append("\n\n");

		sb.append("Project Title: ").append(project.getTitle()).append("\n");
		sb.append("Client Name: ").append(project.getClientName() != null ? project.getClientName() : "N/A").append("\n");
        sb.append("Freelancer: ").append(project.getFreelancerName()).append("\n");
		sb.append("Budget: ₹").append(project.getBudget()).append("\n");
		sb.append("Completed On: ").append(project.getCompletionDate()).append("\n");
		sb.append("Payment Status: ").append(project.getPaymentStatus()).append("\n");
		sb.append("Payment Date: ").append(project.getPaymentDate()).append("\n");

		sb.append("\nThank you for using Freelancer Portal.\n");
		sb.append("========================================");

		return sb.toString();
	}
}
