<%@ page import="com.dao.FreelancerDao"%>
<%@ page import="com.db.DBConnect"%>

<%
    String idStr = request.getParameter("id");
    try {
        int id = Integer.parseInt(idStr);
        FreelancerDao dao = new FreelancerDao(DBConnect.getConn());
        boolean deleted = dao.deleteFreelancerById(id);

        if (deleted) {
            response.sendRedirect("manage_freelancers.jsp?msg=deleted");
        } else {
            response.sendRedirect("manage_freelancers.jsp?msg=error");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manage_freelancers.jsp?msg=error");
    }
%>
