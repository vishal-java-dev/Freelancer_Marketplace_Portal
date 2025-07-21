<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    com.entity.Client client = (com.entity.Client) session.getAttribute("clientObj");
    if (client == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- Bootstrap Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/ClientDashboardServlet">
            <i class="fas fa-user-tie me-1"></i> Client Panel
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarClient" aria-controls="navbarClient"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarClient">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/ClientDashboardServlet" class="btn btn-primary btn-sm">Dashboard</a>

                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/client/post_project.jsp">Post Project</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/client/manage_status.jsp">Manage Projects</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/ViewProjectServlet">My Projects</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/client/view_profile.jsp">Profile</a>
                </li>

                <!-- 👤 Dropdown with Logged-in Client Name -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#clientDropdown" id="clientDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle me-1"></i> <%= client.getFullname() %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="clientDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/client/change_password.jsp">
                                <i class="fas fa-key me-2"></i> Change Password
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/ClientLogoutServlet">
                                <i class="fas fa-sign-out-alt me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
