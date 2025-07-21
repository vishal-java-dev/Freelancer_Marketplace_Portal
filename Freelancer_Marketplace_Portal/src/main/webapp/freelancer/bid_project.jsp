<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.dao.ProjectDao"%>
<%@ page import="com.db.DBConnect"%>
<%@ page import="com.entity.Project"%>
<%@ page isELIgnored="false"%>

<%
    int projectId = Integer.parseInt(request.getParameter("pid"));
    ProjectDao dao = new ProjectDao(DBConnect.getConn());
    Project project = dao.getProjectById(projectId);

    // ✅ Make the project accessible to JSTL/EL
    request.setAttribute("project", project);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Bid on Project - WorkLink</title>
    <%@ include file="../Components/allCss.jsp"%>
    <style>
        .project-card {
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <%@ include file="Navbar.jsp"%>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card project-card p-4">
                    <h3>${project.title}</h3>
                    <p><strong>Skills Required:</strong> ${project.skillsRequired}</p>
                    <p><strong>Budget:</strong> ₹${project.budget}</p>
                    <p><strong>Description:</strong><br> ${project.description}</p>

                    <hr>
                    <h5>Place Your Bid</h5>

                    <c:if test="${not empty sessionScope.sucMsg}">
                        <div class="alert alert-success">${sessionScope.sucMsg}</div>
                        <c:remove var="sucMsg" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMsg}">
                        <div class="alert alert-danger">${sessionScope.errorMsg}</div>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>

                    <form action="../BidServlet" method="post">
                        <input type="hidden" name="projectId" value="${project.id}" />
                        <div class="mb-3">
                            <label class="form-label">Your Bid Amount (₹)</label>
                            <input type="number" class="form-control" name="bidAmount" required min="1">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Estimated Time (in days)</label>
                            <input type="number" class="form-control" name="timeline" required min="1">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cover Letter</label>
                            <textarea class="form-control" name="coverLetter" rows="4" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-success">Submit Bid</button>
                    </form>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
