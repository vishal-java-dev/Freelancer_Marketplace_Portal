<%@ page import="com.entity.Freelancer" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<%
    Freelancer freelancerObj = (Freelancer) session.getAttribute("freelancerObj");
    if (freelancerObj == null) {
        response.sendRedirect("${pageContext.request.contextPath}/login.jsp");
        return;
    }

    String currentPage = request.getRequestURI();
    request.setAttribute("freelancerObj", freelancerObj);
%>

<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #1f2e3d;">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/freelancer/dashboard.jsp">
            <i class="fas fa-briefcase"></i> WorkLink
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#freelancerNavbar" aria-controls="freelancerNavbar"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="freelancerNavbar">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
            
            <li class="nav-item">
                    <a class="nav-link <%= currentPage.contains("dashboard.jsp") ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/freelancer/dashboard.jsp">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
            

                <li class="nav-item">
                    <a class="nav-link <%= currentPage.contains("view_projects.jsp") ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/freelancer/view_projects.jsp">
                        <i class="fa-solid fa-layer-group"></i> Projects
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= currentPage.contains("my_bids.jsp") ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/freelancer/my_bids.jsp">
                        <i class="fa-solid fa-gavel"></i> My Bids
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%= currentPage.contains("earnings.jsp") ? "active" : "" %>"
                       href="${pageContext.request.contextPath}/freelancer/earnings.jsp">
                        <i class="fa-solid fa-coins"></i> Earnings
                    </a>
                </li>

                <!-- Profile Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle <%= currentPage.contains("view_profile.jsp") || currentPage.contains("change_password.jsp") ? "active" : "" %>"
                       href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-circle-user me-1"></i>
                        <c:out value="${freelancerObj.fullname}" />
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/FreelancerProfileServlet">
                                <i class="fa fa-id-card me-2 text-primary"></i> View Profile
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/freelancer/change_password.jsp">
                                <i class="fa fa-lock me-2 text-warning"></i> Change Password
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/freelancerLogout">
                                <i class="fa fa-sign-out-alt me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>

            </ul>
        </div>
    </div>
</nav>
