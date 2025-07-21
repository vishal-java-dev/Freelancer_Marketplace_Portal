<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.entity.Freelancer" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    <title>Freelancer Dashboard - WorkLink</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            background: #f5f7fa;
        }
        .dashboard-card {
            border-radius: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            transition: 0.3s;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .welcome {
            font-weight: 600;
        }
    </style>
</head>
<body>

<%@ include file="Navbar.jsp" %>

<!-- ✅ Flash Messages -->
<c:if test="${not empty sessionScope.succMsg}">
    <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
        ${sessionScope.succMsg}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="succMsg" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.errMsg}">
    <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
        ${sessionScope.errMsg}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="errMsg" scope="session"/>
</c:if>

<!-- ✅ Dashboard Content -->
<div class="container mt-5">
    <h3 class="mb-4 welcome">Welcome, <%= freelancer.getFullname() %> 👋</h3>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center bg-white">
                <i class="fas fa-tasks fa-2x text-success mb-2"></i>
                <h5 class="card-title">View Available Projects</h5>
                <a href="view_projects.jsp" class="btn btn-outline-success btn-sm mt-2">Browse Projects</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center bg-white">
                <i class="fas fa-gavel fa-2x text-success mb-2"></i>
                <h5 class="card-title">My Bids</h5>
                <a href="my_bids.jsp" class="btn btn-outline-success btn-sm mt-2">View Bids</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center bg-white">
                <i class="fas fa-user-circle fa-2x text-success mb-2"></i>
                <h5 class="card-title">Profile</h5>
                <a href="${pageContext.request.contextPath}/FreelancerProfileServlet" class="btn btn-outline-success btn-sm mt-2">View Profile</a>
            </div>
        </div>

        <!-- ✅ Assigned Projects -->
        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center bg-white">
                <i class="fas fa-briefcase fa-2x text-success mb-2"></i>
                <h5 class="card-title">My Assigned Projects</h5>
                <a href="${pageContext.request.contextPath}/FreelancerAssignedProjectsServlet" class="btn btn-outline-success btn-sm mt-2">Assigned Projects</a>
            </div>
        </div>

        <!-- ✅ Earnings -->
        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center bg-white">
                <i class="fas fa-wallet fa-2x text-success mb-2"></i>
                <h5 class="card-title">Earnings</h5>
                <a href="earnings.jsp" class="btn btn-outline-success btn-sm mt-2">Track Earnings</a>
            </div>
        </div>

    </div>
</div>

</body>
</html>
