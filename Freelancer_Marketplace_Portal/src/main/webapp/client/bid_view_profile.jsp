<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.dao.FreelancerDao, com.entity.Freelancer, com.db.DBConnect" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String idStr = request.getParameter("freelancerId");
    String projectIdStr = request.getParameter("projectId"); // get projectId too

    Freelancer freelancer = null;

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            int freelancerId = Integer.parseInt(idStr);
            FreelancerDao dao = new FreelancerDao(DBConnect.getConn());
            freelancer = dao.getFreelancerById(freelancerId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    if (freelancer == null || projectIdStr == null || projectIdStr.trim().isEmpty()) {
        response.sendRedirect("view_projects.jsp?msg=invalid");
        return;
    }

    int projectId = Integer.parseInt(projectIdStr);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Freelancer Profile</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            background-color: #f3f4f6;
        }

        .profile-card {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .profile-card h3 {
            margin-bottom: 20px;
            color: #198754;
        }

        .profile-card p {
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .btn-back {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <div class="profile-card">
        <h3>Freelancer Profile</h3>
        <hr>
        <p><strong>Name:</strong> <%= freelancer.getFullname() %></p>
        <p><strong>Email:</strong> <%= freelancer.getEmail() %></p>
        <p><strong>Skills:</strong> <%= freelancer.getSkills() %></p>
        <p><strong>Experience:</strong> <%= freelancer.getExperience() %> years</p>
        <p><strong>Member Since:</strong> <%= freelancer.getRegDate() %></p>

        <!-- Assign Button -->
        <form action="${pageContext.request.contextPath}/AssignFreelancerServlet" method="post" class="mt-3">
            <input type="hidden" name="projectId" value="<%= projectId %>">
            <input type="hidden" name="freelancerId" value="<%= freelancer.getId() %>">
            <button type="submit" class="btn btn-success">Assign to this Project</button>
        </form>

        <a href="javascript:history.back()" class="btn btn-secondary btn-back">Back</a>
    </div>
</div>

</body>
</html>
