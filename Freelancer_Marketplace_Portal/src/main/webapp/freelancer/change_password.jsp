<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.entity.Freelancer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<%
    Freelancer freelancerObj = (Freelancer) session.getAttribute("freelancerObj");
    if (freelancerObj == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Change Password - Freelancer</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        .card {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
        }
        .form-label {
            font-weight: bold;
        }
    </style>
</head>
<body>

<jsp:include page="Navbar.jsp" />

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card p-4">
                <h4 class="text-center mb-3">Change Password</h4>

                <!-- ✅ Success/Error Message -->
                <c:if test="${not empty sucMsg}">
                    <div class="alert alert-success" role="alert">${sucMsg}</div>
                    <c:remove var="sucMsg" scope="session" />
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger" role="alert">${errorMsg}</div>
                    <c:remove var="errorMsg" scope="session" />
                </c:if>

                <form action="../ChangeFreelancerPassword" method="post">
                    <input type="hidden" name="freelancerId" value="<%= freelancerObj.getId() %>">
                    
                    <div class="mb-3">
                        <label class="form-label">Old Password</label>
                        <input type="password" class="form-control" name="oldPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">New Password</label>
                        <input type="password" class="form-control" name="newPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Confirm New Password</label>
                        <input type="password" class="form-control" name="confirmPassword" required>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success">Update Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
