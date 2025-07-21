package com.servlet.client;

import java.io.IOException;
import java.util.List;

import com.dao.ProjectDao;
import com.db.DBConnect;
import com.entity.Client;
import com.entity.Project;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ViewProjectServlet")
public class ViewProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    try {
	        HttpSession session = request.getSession();
	        Client client = (Client) session.getAttribute("clientObj");

	        if (client == null) {
	            response.sendRedirect("client/login.jsp");
	            return;
	        }

	        ProjectDao dao = new ProjectDao(DBConnect.getConn());
	        List<Project> projectList = dao.getProjectsByClientId(client.getId());

	        if (projectList != null && !projectList.isEmpty()) {
	            request.setAttribute("projectList", projectList);
	        } else {
	            request.setAttribute("projectList", null);
	        }

	        // ✅ Forward to JSP (so includes like Bootstrap work properly)
	        RequestDispatcher rd = request.getRequestDispatcher("client/view_projects.jsp");
	        rd.forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        HttpSession session = request.getSession();
	        session.setAttribute("errorMsg", "Unable to load projects at the moment.");
	        response.sendRedirect(request.getContextPath() + "/ClientDashboardServlet");

	    }
	}
}
