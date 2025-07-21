<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.dao.FreelancerDao"%>
<%@ page import="com.entity.Freelancer"%>
<%@ page import="com.db.DBConnect"%>

<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("../login.jsp?msg=unauthorized");
        return;
    }

    FreelancerDao freelancerDao = new FreelancerDao(DBConnect.getConn());
    List<Freelancer> freelancerList = freelancerDao.getAllFreelancers();
    request.setAttribute("freelancerList", freelancerList);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Freelancers</title>
    <%@ include file="../Components/allCss.jsp"%>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://www.transparenttextures.com/patterns/cubes.png') repeat,
                        linear-gradient(to bottom right, #f0f4f8, #e6ecf3);
            background-size: auto;
            color: #333;
        }

        .table-card {
            margin-top: 60px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h3 {
            color: #2a4365;
            font-weight: 600;
        }

        .table thead {
            background: linear-gradient(to right, #48c6ef, #6f86d6);
            color: white;
        }

        .table tbody tr:hover {
            background-color: #f3faff;
        }

        .btn-info {
            background-color: #007bff;
            border: none;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        #msgBox {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp"%>

<div class="container">
    <div class="table-card">
        <h3><i class="fas fa-users"></i> All Freelancers</h3>

        <c:if test="${param.msg == 'deleted'}">
            <div class="alert alert-success" id="msgBox">Freelancer deleted successfully.</div>
        </c:if>

        <c:if test="${param.msg == 'error'}">
            <div class="alert alert-danger" id="msgBox">Something went wrong while deleting.</div>
        </c:if>

        <script>
            setTimeout(() => {
                if (window.history.replaceState) {
                    const url = window.location.protocol + "//" + window.location.host + window.location.pathname;
                    window.history.replaceState({}, document.title, url);
                }
            }, 3000);
        </script>

        <table class="table table-bordered table-hover mt-3">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Skills</th>
                    <th>Experience</th>
                    <th>Registered On</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="freelancer" items="${freelancerList}">
                    <tr>
                        <td>${freelancer.id}</td>
                        <td>${freelancer.fullname}</td>
                        <td>${freelancer.email}</td>
                        <td>${freelancer.skills}</td>
                        <td>${freelancer.experience} yrs</td>
                        <td>${freelancer.regDate}</td>
                        <td>
                            <a href="view_freelancer.jsp?id=${freelancer.id}" class="btn btn-sm btn-info">View</a>
                            <a href="delete_freelancer.jsp?id=${freelancer.id}" class="btn btn-sm btn-danger"
                               onclick="return confirm('Are you sure you want to delete this freelancer?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty freelancerList}">
            <div class="alert alert-warning text-center">No freelancers found.</div>
        </c:if>
    </div>
</div>

</body>
</html>
