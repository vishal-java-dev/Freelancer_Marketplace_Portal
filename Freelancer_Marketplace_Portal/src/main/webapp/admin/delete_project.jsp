<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.dao.ProjectDao" %>
<%@ page import="com.db.DBConnect" %>

<%
    // Check admin session
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }

    String idStr = request.getParameter("id");
    int id = 0;
    boolean deleted = false;

    try {
        id = Integer.parseInt(idStr);
        ProjectDao dao = new ProjectDao(DBConnect.getConn());
        deleted = dao.deleteProjectById(id);
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (deleted) {
        response.sendRedirect("view_project.jsp?msg=deleted");
    } else {
        response.sendRedirect("view_project.jsp?msg=error");
    }
%>
