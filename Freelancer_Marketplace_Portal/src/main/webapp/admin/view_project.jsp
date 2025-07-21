<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.dao.ProjectDao"%>
<%@ page import="com.entity.Project"%>
<%@ page import="com.db.DBConnect"%>
<%@ page import="java.sql.*"%>

<%
    // Session check
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }

    int projectId = Integer.parseInt(request.getParameter("id"));
    ProjectDao projectDao = new ProjectDao(DBConnect.getConn());
    Project project = projectDao.getProjectById(projectId);

    if (project == null) {
        response.sendRedirect("manage_projects.jsp?msg=notfound");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Project Details</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://www.transparenttextures.com/patterns/circles.png') repeat,
                        linear-gradient(to bottom right, #e2ebf0, #ffffff);
            background-size: auto;
            color: #333;
        }

        .project-card {
            max-width: 800px;
            margin: 60px auto;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 35px;
        }

        .project-card h3 {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .project-info label {
            font-weight: 600;
            color: #555;
        }

        .project-info p {
            font-size: 1.1rem;
            margin-bottom: 15px;
        }

        .btn-back {
            margin-top: 25px;
        }
    </style>
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <div class="container">
        <div class="project-card">
            <h3><i class="fas fa-folder-open"></i> Project Details</h3>

            <div class="project-info">
                <label>Project ID:</label>
                <p><%= project.getId() %></p>

                <label>Title:</label>
                <p><%= project.getTitle() %></p>

                <label>Description:</label>
                <p><%= project.getDescription() %></p>

                <label>Category:</label>
                <p><%= project.getCategory() %></p>

                <label>Budget:</label>
                <p>₹<%= project.getBudget() %></p>

                <label>Status:</label>
                <p><%= project.getStatus() %></p>

                <label>Posted By (Client ID):</label>
                <p><%= project.getClientId() %></p>

                <label>Posted Date:</label>
                <p><%= project.getPostedDate() %></p>
            </div>

            <a href="manage_projects.jsp" class="btn btn-primary btn-back">
                <i class="fas fa-arrow-left"></i> Back to Projects
            </a>
        </div>
    </div>

</body>
</html>
