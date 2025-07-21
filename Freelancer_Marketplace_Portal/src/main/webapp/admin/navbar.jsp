
<%@ page import="com.entity.Admin" %>


<%
    Admin admin = (Admin) session.getAttribute("adminObj");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold"
           href="${pageContext.request.contextPath}/admin/dashboard.jsp">
            <i class="fas fa-cogs"></i> Admin Panel
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarContent">
            <ul class="navbar-nav me-3">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>

                <!-- Projects Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="projectDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-briefcase"></i> Projects
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="projectDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/manage_projects.jsp">
                                <i class="fas fa-folder-open me-2 text-primary"></i> All Projects
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/AdminCompletedProjectsServlet">
                                <i class="fas fa-check-circle me-2 text-success"></i> Completed Projects
                            </a>
                        </li>
                    </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/manage_freelancers.jsp">
                        <i class="fas fa-users"></i> Freelancers
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/manage_clients.jsp">
                        <i class="fas fa-user-tie"></i> Clients
                    </a>
                </li>

                <li class="nav-item">
                   <a class="nav-link" href="${pageContext.request.contextPath}/AdminPaymentTrackingServlet">
                        <i class="fas fa-money-check-alt"></i> Payment Monitoring
                    </a>
                </li>
            </ul>

            <!-- Super Admin Dropdown -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="adminDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-shield"></i>
                        <%= admin != null ? admin.getName() : "Admin" %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                        <li>
                            <a class="dropdown-item text-danger"
                               href="${pageContext.request.contextPath}/adminLogout">
                                <i class="fas fa-sign-out-alt me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
