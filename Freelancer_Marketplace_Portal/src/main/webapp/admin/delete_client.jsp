<%@ page import="com.dao.ClientDao" %>
<%@ page import="com.db.DBConnect" %>

<%
    String idStr = request.getParameter("id");
    try {
        int id = Integer.parseInt(idStr);
        ClientDao dao = new ClientDao(DBConnect.getConn());
        boolean deleted = dao.deleteClientById(id);

        if (deleted) {
            response.sendRedirect("manage_clients.jsp?msg=deleted");
        } else {
            response.sendRedirect("manage_clients.jsp?msg=error");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manage_clients.jsp?msg=error");
    }
%>
