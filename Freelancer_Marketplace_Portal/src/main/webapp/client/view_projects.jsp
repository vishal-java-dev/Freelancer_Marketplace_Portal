<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.dao.ProjectDao, com.db.DBConnect, com.entity.Project, java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../Components/allCss.jsp"%>

<%
com.entity.Client clientObj = (com.entity.Client) session.getAttribute("clientObj");
if (clientObj == null) {
	response.sendRedirect("login.jsp");
	return;
}

// ✅ Fetch projects for the current client
ProjectDao projectDao = new ProjectDao(DBConnect.getConn());
List<Project> projectList = projectDao.getProjectsByClientId(clientObj.getId());
request.setAttribute("projectList", projectList);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Projects</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1531297484001-80022131f5a1?auto=format&fit=crop&w=1950&q=80');
	background-size: cover;
	background-position: center;
	background-attachment: fixed;
	min-height: 100vh;
	padding-top: 80px;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.project-card {
	background-color: rgba(255, 255, 255, 0.95);
	border-radius: 15px;
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
	margin-bottom: 30px;
}

.project-title {
	font-size: 1.4rem;
	font-weight: 600;
	color: #0d6efd;
}

.budget {
	color: green;
	font-weight: 600;
	font-size: 1.1rem;
}

.status-badge {
	font-size: 0.9rem;
	padding: 6px 10px;
}

.view-section {
	padding: 40px 0;
}
</style>
</head>

<body>

	<%@ include file="navbar.jsp"%>

	<div class="container view-section">
		<h2 class="text-white text-center mb-5">
			<i class="fas fa-folder-open me-2"></i>Your Posted Projects
		</h2>

		<!-- Flash Messages -->
		<c:if test="${not empty param.msg}">
			<div class="alert alert-success">${param.msg}</div>
		</c:if>
		<c:if test="${not empty param.error}">
			<div class="alert alert-danger">${param.error}</div>
		</c:if>

		<c:forEach var="p" items="${projectList}">
			<div class="project-card p-4">
				<div class="row">
					<div class="col-md-9">
						<h4 class="project-title">${p.title}</h4>
						<p class="mb-1">
							<strong>Description:</strong> ${p.description}
						</p>
						<p class="mb-1">
							<strong>Skills Required:</strong> ${p.skillsRequired}
						</p>
						<p class="mb-1">
							<strong>Posted On:</strong>
							<fmt:formatDate value="${p.postedDate}" pattern="dd MMM yyyy" />
						</p>
						<c:if test="${p.deadline != null}">
							<p class="mb-1">
								<strong>Deadline:</strong>
								<fmt:formatDate value="${p.deadline}" pattern="dd MMM yyyy" />
							</p>
						</c:if>
						<c:if test="${not empty p.freelancerName}">
							<p class="mb-1">
								<strong>Assigned To:</strong> ${p.freelancerName}
							</p>
						</c:if>
					</div>
					<div class="col-md-3 text-end">
						<p class="budget">
							<i class="fas fa-rupee-sign"></i>
							<fmt:formatNumber value="${p.budget}" type="currency"
								currencySymbol="₹" />
						</p>

						<!-- Status Badge -->
						<c:choose>
							<c:when test="${fn:toLowerCase(p.status) == 'open'}">
								<span class="badge bg-success status-badge">${p.status}</span>
							</c:when>
							<c:when test="${fn:toLowerCase(p.status) == 'in progress'}">
								<span class="badge bg-warning text-dark status-badge">${p.status}</span>
							</c:when>
							<c:when test="${fn:toLowerCase(p.status) == 'completed'}">
								<span class="badge bg-info status-badge">${p.status}</span>
							</c:when>
							<c:when test="${fn:toLowerCase(p.status) == 'closed'}">
								<span class="badge bg-danger status-badge">${p.status}</span>
							</c:when>
							<c:otherwise>
								<span class="badge bg-secondary status-badge">${p.status}</span>
							</c:otherwise>
						</c:choose>

						<!-- View Bids Button -->
						<br />
						<br /> <a
							href="${pageContext.request.contextPath}/viewBids?projectId=${p.id}"
							class="btn btn-sm btn-info"> View Bids </a>


						<!-- Show Complete + Payment Modal -->
						<c:if
							test="${fn:toLowerCase(p.status) eq 'in progress' && not empty p.assignedTo}">
							<br />
							<br />
							<button class="btn btn-sm btn-success" data-bs-toggle="modal"
								data-bs-target="#paymentModal${p.id}">Complete & Pay</button>
						</c:if>
					</div>
				</div>
			</div>

			<!-- Payment Modal -->
			<div class="modal fade" id="paymentModal${p.id}" tabindex="-1"
				aria-labelledby="modalLabel${p.id}" aria-hidden="true">
				<div class="modal-dialog">
					<form
						action="${pageContext.request.contextPath}/CompleteProjectServlet"
						method="post" class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalLabel${p.id}">Payment &
								Completion</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<div class="modal-body">
							<input type="hidden" name="projectId" value="${p.id}" /> <input
								type="hidden" name="freelancerId" value="${p.assignedTo}" /> <input
								type="hidden" name="clientId" value="${clientObj.id}" /> <input
								type="hidden" name="amount" value="${p.budget}" />

							<div class="mb-3">
								<label class="form-label">Payment Mode</label> <input
									type="text" name="paymentMode" class="form-control" required
									placeholder="e.g. UPI, Bank Transfer" />
							</div>
							<div class="mb-3">
								<label class="form-label">Transaction ID</label> <input
									type="text" name="transactionId" class="form-control" required
									placeholder="e.g. TXN123456789" />
							</div>
							<div class="mb-3">
								<label class="form-label">Notes</label>
								<textarea name="notes" class="form-control"
									placeholder="Any remarks..."></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success">Confirm &
								Complete</button>
						</div>
					</form>
				</div>
			</div>
		</c:forEach>

		<c:if test="${empty projectList}">
			<div class="alert alert-warning text-center mt-5">
				<i class="fas fa-exclamation-circle me-2"></i>No projects posted
				yet.
			</div>
		</c:if>
	</div>

</body>
</html>
