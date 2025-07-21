<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.dao.ProjectDao" %>
<%@ page import="com.db.DBConnect" %>
<%@ page import="com.entity.Project" %>

<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("../login.jsp?msg=unauthorized");
        return;
    }

    ProjectDao projectDao = new ProjectDao(DBConnect.getConn());
    List<Project> projectList = projectDao.getAllProjects(); // define this in ProjectDao
    request.setAttribute("projectList", projectList);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Projects</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            background: linear-gradient(to right, #e3f2fd, #ffffff);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
        }

        .container {
            padding-top: 50px;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background: #182b4a;
            color: white;
            font-size: 1.4rem;
            font-weight: bold;
            border-radius: 15px 15px 0 0;
        }

        .table th {
            background-color: #e3f2fd;
        }

        .btn {
            border-radius: 20px;
        }

        .alert {
            border-radius: 10px;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="card">
        <div class="card-header text-center">
            <i class="fas fa-briefcase"></i> Manage Posted Projects
        </div>
        <div class="card-body">

            <c:if test="${param.msg == 'deleted'}">
                <div class="alert alert-success">Project deleted successfully.</div>
            </c:if>

            <c:if test="${param.msg == 'error'}">
                <div class="alert alert-danger">Something went wrong while deleting the project.</div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-hover table-bordered text-center align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Client Email</th>
                            <th>Budget</th>
                            <th>Status</th>
                            <th>Posted On</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="project" items="${projectList}">
                            <tr>
                                <td>${project.id}</td>
                                <td>${project.title}</td>
                                <td>${project.clientEmail}</td>
                                <td>₹${project.budget}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${project.status == 'Open'}">
                                            <span class="badge bg-success">${project.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${project.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${project.postedDate}</td>
                                <td>
                                    <a href="view_project.jsp?id=${project.id}" class="btn btn-sm btn-info">View</a>
                                    <a href="delete_project.jsp?id=${project.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty projectList}">
                <div class="alert alert-warning text-center">No projects found.</div>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>
