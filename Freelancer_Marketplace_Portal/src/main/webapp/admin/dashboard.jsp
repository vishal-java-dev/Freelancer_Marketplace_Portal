<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.entity.Admin, com.dao.FreelancerDao, com.dao.ClientDao, com.dao.ProjectDao, java.sql.*"%>
<%
    Admin adminObj = (Admin) session.getAttribute("adminObj");
    if (adminObj == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }

    Connection conn = com.db.DBConnect.getConn();
    
    FreelancerDao freelancerDao = new FreelancerDao(conn);
    ClientDao clientDao = new ClientDao(conn);
    ProjectDao projectDao = new ProjectDao(conn);

    int freelancerCount = freelancerDao.getTotalFreelancers();
    int clientCount = clientDao.getTotalClients();
    int projectCount = projectDao.getTotalProjects();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - WorkLink</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://www.transparenttextures.com/patterns/cubes.png'), #eaf4fc; /* ✅ Light tech texture */
            background-size: contain;
            overflow: hidden; /* ✅ No scroll bar */
        }

        .dashboard-container {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: -15px;
        }

        .dashboard-card {
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 90%;
            max-width: 1000px;
        }

        .dashboard-card h3 {
            font-weight: 600;
            color:#182b4a;
        }

        .welcome-text {
            font-size: 1.2rem;
            color: #495057;
        }

        .card .card-title {
            font-weight: 600;
        }

        .card .card-text {
            font-size: 2rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="dashboard-container">
    <div class="dashboard-card">
        <h3><i class="fas fa-home me-2"></i> Admin Dashboard</h3>
        <p class="welcome-text mb-4">
            Welcome back, <strong class="text-dark"><%= adminObj.getName() %></strong> 👋
        </p>

        <div class="row text-center">
            <div class="col-md-4 mb-3">
                <div class="card text-white bg-success h-100">
                    <div class="card-body">
                        <h5 class="card-title">Total Freelancers</h5>
                        <p class="card-text"><%= freelancerCount %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card text-white bg-primary h-100">
                    <div class="card-body">
                        <h5 class="card-title">Total Clients</h5>
                        <p class="card-text"><%= clientCount %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card text-white bg-warning h-100">
                    <div class="card-body">
                        <h5 class="card-title">Total Projects</h5>
                        <p class="card-text"><%= projectCount %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>