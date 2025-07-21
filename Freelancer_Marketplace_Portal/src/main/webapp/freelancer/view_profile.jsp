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
    <title>Freelancer Profile - WorkLink</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        .profile-card {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-radius: 15px;
            padding: 30px;
        }
        .profile-label {
            font-weight: bold;
        }
        .review-box {
            background: #f9f9f9;
            border-left: 4px solid #0d6efd;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<jsp:include page="Navbar.jsp" />

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card profile-card">
                <h4 class="text-center mb-4">My Profile</h4>
                <table class="table">
                    <tr>
                        <td class="profile-label">Full Name:</td>
                        <td><%= freelancerObj.getFullname() %></td>
                    </tr>
                    <tr>
                        <td class="profile-label">Email:</td>
                        <td><%= freelancerObj.getEmail() %></td>
                    </tr>
                    <tr>
                        <td class="profile-label">Skills:</td>
                        <td><%= freelancerObj.getSkills() %></td>
                    </tr>
                    <tr>
                        <td class="profile-label">Experience:</td>
                        <td><%= freelancerObj.getExperience() %> years</td>
                    </tr>
                    <tr>
                        <td class="profile-label">Registered On:</td>
                        <td><%= freelancerObj.getRegDate() %></td>
                    </tr>
                </table>

                <div class="text-end">
                    <a href="freelancer/change_password.jsp" class="btn btn-warning">Change Password</a>
                </div>
            </div>
        </div>
    </div>

    <!-- ⭐ Review Section -->
    <div class="row justify-content-center mt-5">
        <div class="col-md-8">
            <h4 class="mb-3 text-primary">Client Reviews</h4>

            <c:choose>
                <c:when test="${not empty freelancerReviews}">
                    <c:forEach var="r" items="${freelancerReviews}">
                        <div class="review-box">
                            <strong>Project:</strong> ${r.projectTitle} <br/>
                            <strong>Rating:</strong> 
                            <c:forEach begin="1" end="${r.rating}">
                                ⭐
                            </c:forEach> <br/>
                            <strong>Review:</strong> ${r.review} <br/>
                            <small class="text-muted">From Client ID: ${r.clientId}</small>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="text-muted">No reviews yet.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

</body>
</html>
