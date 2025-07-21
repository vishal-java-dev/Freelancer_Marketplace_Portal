<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
if (session.getAttribute("clientObj") == null) {
	response.sendRedirect(request.getContextPath() + "/client/login.jsp?msg=unauthorized");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Client Dashboard</title>
<%@ include file="../Components/allCss.jsp"%>
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1518779578993-ec3579fee39f?auto=format&fit=crop&w=1950&q=80');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	min-height: 100vh;
}

.bg-overlay {
	background-color: rgba(255, 255, 255, 0.95);
	min-height: 100vh;
	padding-top: 80px;
	padding-bottom: 40px;
}

.dashboard-card:hover {
	transform: scale(1.02);
	transition: 0.3s ease-in-out;
}

.icon-lg {
	font-size: 2.5rem;
	color: #0d6efd;
}
</style>
</head>
<body>

	<%@ include file="navbar.jsp"%>

	<div class="bg-overlay">
		<div class="container">
			<div class="text-center mb-5">
				<h2 class="fw-bold text-primary">Client Dashboard</h2>
				<p class="text-muted">Manage your projects and profile easily.</p>
			</div>

			<div class="row g-4 justify-content-center">
				<div class="col-md-4">
					<div
						class="card p-4 shadow dashboard-card text-center bg-white border-0 rounded-4">
						<i class="fas fa-folder-plus icon-lg mb-3"></i>
						<h5 class="mb-2">Post New Project</h5>
						<a
							href="${pageContext.request.contextPath}/client/post_project.jsp"
							class="btn btn-primary btn-sm">Post Now</a>
					</div>
				</div>
				<div class="col-md-4">
					<div
						class="card p-4 shadow dashboard-card text-center bg-white border-0 rounded-4">
						<i class="fas fa-clipboard-list icon-lg mb-3"></i>
						<h5 class="mb-2">View My Projects</h5>
						<a href="${pageContext.request.contextPath}/ViewProjectServlet"
							class="btn btn-primary btn-sm">View Projects</a>
					</div>
				</div>
				<div class="col-md-4">
					<div
						class="card p-4 shadow dashboard-card text-center bg-white border-0 rounded-4">
						<i class="fas fa-user-circle icon-lg mb-3"></i>
						<h5 class="mb-2">My Profile</h5>
						<a
							href="${pageContext.request.contextPath}/client/view_profile.jsp"
							class="btn btn-primary btn-sm">View Profile</a>
					</div>
				</div>
			</div>

			<!-- Completed Projects Section -->
			<hr class="my-5">
			<div class="text-center mb-4">
				<h4 class="fw-bold text-success">Completed Projects</h4>
			</div>

			<c:if test="${empty completedProjects}">
				<div class="text-center text-muted mb-4">No completed projects
					found.</div>
			</c:if>

			<c:if test="${not empty completedProjects}">
				<div class="row justify-content-center">
					<c:forEach var="proj" items="${completedProjects}">
						<div class="col-md-6 mb-4">
							<div class="card shadow-sm border-0 rounded-4 p-3">
								<h5>${proj.title}</h5>
								<p>
									<strong>Status:</strong> ${proj.status}
								</p>
								<p>
									<strong>Payment:</strong> ${proj.paymentStatus}
								</p>

								<c:choose>
									<c:when test="${proj.canReview}">
										<form
											action="${pageContext.request.contextPath}/client/submit_review.jsp"
											method="get">
											<input type="hidden" name="freelancerId"
												value="${proj.assignedTo}" /> <input type="hidden"
												name="projectId" value="${proj.id}" />
											<button type="submit"
												class="btn btn-sm btn-outline-primary mt-2">Write
												Review</button>
										</form>
									</c:when>
									    <c:otherwise>
    <p class="text-muted mt-2"><em>Review submitted</em></p>

    <div class="d-flex gap-2 mt-2">
        <!-- Edit Review -->
        <form action="${pageContext.request.contextPath}/client/edit_review.jsp" method="get" class="d-inline">
            <input type="hidden" name="freelancerId" value="${proj.assignedTo}" />
            <input type="hidden" name="projectId" value="${proj.id}" />
            <button type="submit" class="btn btn-sm btn-warning">Edit</button>
        </form>

        <!-- Delete Review -->
        <form action="${pageContext.request.contextPath}/DeleteReviewServlet" method="post" class="d-inline">
            <input type="hidden" name="freelancerId" value="${proj.assignedTo}" />
            <input type="hidden" name="projectId" value="${proj.id}" />
            <button type="submit" class="btn btn-sm btn-danger"
                    onclick="return confirm('Are you sure you want to delete this review?');">Delete</button>
        </form>
    </div>
</c:otherwise>


								</c:choose>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>

		</div>
	</div>
</body>
</html>
