package com.servlet.client;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.dao.ProjectDao;
import com.db.DBConnect;
import com.entity.Client;
import com.entity.Project;

@WebServlet("/PostProjectServlet")
public class PostProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    try {
	        HttpSession session = request.getSession();
	        Client client = (Client) session.getAttribute("clientObj");

	        if (client == null) {
	            response.sendRedirect("../login.jsp");
	            return;
	        }

	        // Get form parameters
	        String title = request.getParameter("title");
	        String description = request.getParameter("description");
	        String category = request.getParameter("category");
	        String skills = request.getParameter("skills");
	        String budgetStr = request.getParameter("budget");
	        String deadlineStr = request.getParameter("deadline");

	        // Validate fields
	        if (title == null || title.trim().isEmpty() ||
	            description == null || description.trim().isEmpty() ||
	            category == null || category.trim().isEmpty() ||
	            skills == null || skills.trim().isEmpty() ||
	            budgetStr == null || budgetStr.trim().isEmpty() ||
	            deadlineStr == null || deadlineStr.trim().isEmpty()) {

	            response.sendRedirect("client/post_project.jsp?error=Please+fill+all+fields");
	            return;
	        }

	        double budget;
	        Date deadline;
	        try {
	            budget = Double.parseDouble(budgetStr);
	            deadline = Date.valueOf(deadlineStr);
	        } catch (Exception ex) {
	            response.sendRedirect("client/post_project.jsp?error=Invalid+Budget+or+Deadline+Format");
	            return;
	        }

	        // Create Project object
	        Project p = new Project();
	        p.setTitle(title);
	        p.setCategory(category); // ✅ category is required
	        p.setDescription(description);
	        p.setSkillsRequired(skills);
	        p.setBudget(budget);
	        p.setDeadline(deadline);
	        p.setClientId(client.getId());
	        p.setClientEmail(client.getEmail());
	        p.setFreelancerName(""); // ✅ Initially empty

	        // Save to DB
	        Connection conn = DBConnect.getConn();
	        ProjectDao dao = new ProjectDao(conn);
	        boolean success = dao.addProject(p);

	        if (success) {
	            response.sendRedirect("client/view_projects.jsp?msg=Project+Posted+Successfully");
	        } else {
	            response.sendRedirect("client/post_project.jsp?error=Server+Error+Try+Again");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("client/post_project.jsp?error=Unexpected+Error+Occurred");
	    }
	}
}
