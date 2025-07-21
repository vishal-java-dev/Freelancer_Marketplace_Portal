<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.entity.Freelancer" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    Freelancer freelancer = (Freelancer) session.getAttribute("freelancerObj");
    if (freelancer == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Assigned Projects - Freelancer</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table td, .table th {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<%@ include file="Navbar.jsp" %>

<div class="container mt-5">
    <h4 class="text-success mb-4">My Assigned Projects</h4>

    <c:if test="${empty assignedProjects}">
        <div class="alert alert-info text-center">No assigned projects found.</div>
    </c:if>

    <c:if test="${not empty assignedProjects}">
        <table class="table table-bordered table-hover bg-white">
            <thead class="table-light">
                <tr>
                    <th>Title</th>
                    <th>Client</th>
                    <th>Budget</th>
                    <th>Status</th>
                    <th>Deadline</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${assignedProjects}">
                    <tr>
                        <td>${p.title}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty p.clientName}">${p.clientName}</c:when>
                                <c:otherwise><span class="text-muted">Not available</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>₹<c:out value="${p.budget}" default="0.0"/></td>
                        <td>
                            <span class="badge 
                                <c:choose>
                                    <c:when test="${p.status eq 'completed'}">bg-success</c:when>
                                    <c:when test="${p.status eq 'in progress'}">bg-info text-dark</c:when>
                                    <c:otherwise>bg-secondary</c:otherwise>
                                </c:choose>">${p.status}</span>
                        </td>
                        <td>
                            <c:if test="${p.deadline != null}">
                                <fmt:formatDate value="${p.deadline}" pattern="dd-MM-yyyy"/>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${p.status eq 'in progress'}">
                                <form method="post" action="${pageContext.request.contextPath}/MarkProjectCompletedServlet">
                                    <input type="hidden" name="projectId" value="${p.id}">
                                    <button type="submit" class="btn btn-sm btn-success"
                                            onclick="return confirm('Are you sure you want to mark this project as completed?')">
                                        Mark as Completed
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${p.status eq 'completed'}">
                                <span class="text-success">✅ Completed</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

</body>
</html>
