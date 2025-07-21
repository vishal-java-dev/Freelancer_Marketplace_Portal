<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.dao.ProjectDao, com.db.DBConnect, com.entity.Project" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    com.entity.Client client = (com.entity.Client) session.getAttribute("clientObj");
    if (client == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }

    ProjectDao dao = new ProjectDao(DBConnect.getConn());
    List<Project> projects = dao.getProjectsByClientId(client.getId());
    request.setAttribute("projectList", projects);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Project Status</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            padding: 5rem;
            background-color: #f8f9fa;
        }

        .status-form {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-top: 10px;
        }

        .card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-5">
    <h3 class="mb-4 text-primary">Manage Your Projects</h3>

    <c:if test="${not empty succMsg}">
        <div class="alert alert-success">${succMsg}</div>
        <c:remove var="succMsg" scope="session" />
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
        <c:remove var="errorMsg" scope="session" />
    </c:if>

    <c:choose>
        <c:when test="${empty projectList}">
            <div class="alert alert-info text-center">You haven't posted any projects yet.</div>
        </c:when>
        <c:otherwise>
            <c:forEach var="p" items="${projectList}">
                <div class="card p-3 shadow-sm">
                    <h5>${p.title}</h5>
                    <p><strong>Current Status:</strong> ${p.status}</p>
                    <form action="${pageContext.request.contextPath}/UpdateProjectStatusServlet" method="post" class="status-form">
                        <input type="hidden" name="projectId" value="${p.id}" />
                        <select name="status" class="form-select" style="width: 200px;">
                            <option value="active" ${p.status eq 'active' ? 'selected' : ''}>Active</option>
                            <option value="in progress" ${p.status eq 'in progress' ? 'selected' : ''}>In Progress</option>
                            <option value="submitted" ${p.status eq 'submitted' ? 'selected' : ''}>Submitted</option>
                            <option value="completed" ${p.status eq 'completed' ? 'selected' : ''}>Completed</option>
                        </select>
                        <button type="submit" class="btn btn-success btn-sm">Update</button>
                    </form>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
