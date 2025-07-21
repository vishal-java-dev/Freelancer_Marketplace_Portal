<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../Components/allCss.jsp" %>

<%
    com.entity.Client clientObj = (com.entity.Client) session.getAttribute("clientObj");
    if (clientObj == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <style>
        body {
            background: url('https://images.unsplash.com/photo-1535223289827-42f1e9919769?auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
        }

        .edit-profile-form {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            max-width: 600px;
            margin: 80px auto;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        h2 {
            color: #333;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: none;
        }

        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="edit-profile-form">
        <h2 class="text-center mb-4"><i class="fas fa-user-edit"></i> Edit Profile</h2>

        <form action="../UpdateClientProfileServlet" method="post">
            <input type="hidden" name="id" value="${clientObj.id}">

            <div class="mb-3">
                <label>Full Name</label>
                <input type="text" name="fullname" class="form-control" value="${clientObj.fullname}" required>
            </div>

            <div class="mb-3">
                <label>Email (read-only)</label>
                <input type="email" class="form-control" value="${clientObj.email}" readonly>
            </div>

            <div class="mb-3">
                <label>Company</label>
                <input type="text" name="company" class="form-control" value="${clientObj.company}">
            </div>

            <div class="mb-3">
                <label>Skills</label>
                <input type="text" name="skills" class="form-control" placeholder="E.g., Java, React, MySQL" value="${clientObj.skills}">
            </div>

            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>
    </div>
</div>

</body>
</html>
