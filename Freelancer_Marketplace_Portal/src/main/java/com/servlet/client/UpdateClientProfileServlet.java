package com.servlet.client;

import com.dao.ClientDao;
import com.db.DBConnect;
import com.entity.Client;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/UpdateClientProfileServlet")
public class UpdateClientProfileServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String fullname = request.getParameter("fullname");
        String company = request.getParameter("company");
        String skills = request.getParameter("skills");

        Connection conn = DBConnect.getConn();
        ClientDao dao = new ClientDao(conn);

        Client client = new Client();
        client.setId(id);
        client.setFullname(fullname);
        client.setCompany(company);
        client.setSkills(skills);

        boolean updated = dao.updateClientProfile(client);

        HttpSession session = request.getSession();
        if (updated) {
            Client updatedClient = dao.getClientById(id); // fetch updated client info
            session.setAttribute("clientObj", updatedClient);
            session.setAttribute("successMsg", "Profile updated successfully!");
            response.sendRedirect("client/view_profile.jsp");
        } else {
            session.setAttribute("errorMsg", "Something went wrong. Try again!");
            response.sendRedirect("client/edit_profile.jsp");
        }
    }
}
