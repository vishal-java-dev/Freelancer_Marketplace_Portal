<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.dao.FreelancerDao, com.entity.Freelancer, com.db.DBConnect" %>
<%
Freelancer freelancer = null;
try {
    String sid = request.getParameter("id");
    if (sid != null && !sid.trim().equals("")) {
        int id = Integer.parseInt(sid);
        FreelancerDao dao = new FreelancerDao(DBConnect.getConn());
        freelancer = dao.getFreelancerById(id);
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Freelancer Details - Admin</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        .details-card {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .details-title {
            font-size: 24px;
            font-weight: 600;
            color:#182b4a;
            margin-bottom: 20px;
        }
        .details-row {
            margin-bottom: 15px;
        }
        .details-label {
            font-weight: bold;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container">
    <div class="details-card">
        <div class="details-title">Freelancer Profile</div>

        <% if (freelancer != null) { %>
            <div class="details-row">
                <span class="details-label">Full Name:</span>
                <span><%= freelancer.getFullname() %></span>
            </div>

            <div class="details-row">
                <span class="details-label">Email:</span>
                <span><%= freelancer.getEmail() %></span>
            </div>

            <div class="details-row">
                <span class="details-label">Skills:</span>
                <span><%= freelancer.getSkills() %></span>
            </div>

            <div class="details-row">
                <span class="details-label">Experience:</span>
                <span><%= freelancer.getExperience() %> years</span>
            </div>

            <div class="details-row">
                <span class="details-label">Registered On:</span>
                <span><%= freelancer.getRegDate() %></span>
            </div>
        <% } else { %>
            <div class="alert alert-danger text-center">
                Invalid freelancer ID or freelancer not found.
            </div>
        <% } %>

        <div class="text-center mt-4">
            <a href="manage_freelancers.jsp" class="btn btn-secondary">Back to List</a>
        </div>
    </div>
</div>

</body>
</html>
