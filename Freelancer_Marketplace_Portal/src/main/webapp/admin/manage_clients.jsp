<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="com.dao.ClientDao" %>
<%@ page import="com.entity.Client" %>
<%@ page import="com.db.DBConnect" %>

<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("../login.jsp?msg=unauthorized");
        return;
    }

    ClientDao clientDao = new ClientDao(DBConnect.getConn());
    List<Client> clientList = clientDao.getAllClients();  // You must have this method in ClientDao
    request.setAttribute("clientList", clientList);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Clients</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            background: linear-gradient(135deg, #e0f7fa, #ffffff);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            padding-top: 40px;
            padding-bottom: 40px;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background: #182b4a;
            color: white;
            font-size: 1.5rem;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .table th {
            background-color: #e8f5e9;
        }

        .btn-info, .btn-danger {
            border-radius: 20px;
            font-size: 0.85rem;
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
                <i class="fas fa-users-cog"></i> Manage Clients
            </div>
            <div class="card-body">

                <c:if test="${param.msg == 'deleted'}">
                    <div class="alert alert-success">Client deleted successfully.</div>
                </c:if>

                <c:if test="${param.msg == 'error'}">
                    <div class="alert alert-danger">Something went wrong while deleting the client.</div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Company</th>
                                <th>Registered On</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="client" items="${clientList}">
                                <tr>
                                    <td>${client.id}</td>
                                    <td>${client.fullname}</td>
                                    <td>${client.email}</td>
                                    <td>${client.company}</td>
                                    <td>${client.regDate}</td>
                                    <td>
                                        <a href="view_client.jsp?id=${client.id}" class="btn btn-sm btn-info">View</a>
                                        <a href="delete_client.jsp?id=${client.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${empty clientList}">
                    <div class="alert alert-warning text-center">No clients found.</div>
                </c:if>
            </div>
        </div>
    </div>

</body>
</html>
