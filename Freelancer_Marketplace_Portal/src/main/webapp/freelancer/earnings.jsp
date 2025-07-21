<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="java.util.*, java.text.SimpleDateFormat, com.entity.Freelancer, com.entity.Project, com.dao.ProjectDao, com.db.DBConnect"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>

<%
Freelancer freelancerObj = (Freelancer) session.getAttribute("freelancerObj");
if (freelancerObj == null) {
	response.sendRedirect("login.jsp?msg=unauthorized");
	return;
}

ProjectDao dao = new ProjectDao(DBConnect.getConn());
List<Project> completedProjects = dao.getCompletedProjectsByFreelancer(freelancerObj.getId());

double totalEarnings = 0;
Map<String, Double> earningsByMonth = new LinkedHashMap<>();

for (Project p : completedProjects) {
	totalEarnings += p.getBudget();
	Date completionDate = p.getCompletionDate(); // ✅ use correct date
	String month = new SimpleDateFormat("MMM yyyy").format(completionDate);
	earningsByMonth.put(month, earningsByMonth.getOrDefault(month, 0.0) + p.getBudget());
}

request.setAttribute("completedProjects", completedProjects);
request.setAttribute("earningsByMonth", earningsByMonth);
request.setAttribute("totalEarnings", totalEarnings);
%>

<!DOCTYPE html>
<html>
<head>
<title>My Earnings - WorkLink</title>
<%@ include file="../Components/allCss.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.earnings-card {
	border-radius: 12px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 25px;
	background-color: #fff;
}

.project-row {
	border-bottom: 1px solid #dee2e6;
	padding: 12px 0;
}

.badge-paid {
	background-color: #28a745;
	color: white;
	padding: 3px 8px;
	font-size: 12px;
	border-radius: 6px;
}

.badge-pending {
	background-color: #ffc107;
	color: #000;
	padding: 3px 8px;
	font-size: 12px;
	border-radius: 6px;
}
</style>
</head>
<body>

	<jsp:include page="Navbar.jsp" />

	<div class="container mt-5">
		<h3 class="mb-4 text-primary">Freelancer Earnings Summary</h3>

		<div class="card earnings-card">
			<div class="card-body">
				<h5>
					Total Earnings: <span class="text-success fw-bold">₹ <%=totalEarnings%></span>
				</h5>
				<hr>
				<h6 class="text-secondary mb-3">Completed Projects:</h6>
				<div>
					<c:forEach var="p" items="${completedProjects}">
						<div class="project-row">
							<strong>${p.title}</strong> — ₹ ${p.budget} <span
								class="text-muted float-end"> Completed: <fmt:formatDate
									value="${p.completionDate}" pattern="dd MMM yyyy" />
							</span> <br /> Payment Status:
							<c:choose>
								<c:when test="${p.paymentStatus eq 'transferred'}">
									<span class="badge-paid">Transferred</span>
								</c:when>
								<c:otherwise>
									<span class="badge-pending">Pending</span>
								</c:otherwise>
							</c:choose>
							<br />

							<c:if test="${not empty p.paymentDate}">
                            Paid On: <fmt:formatDate
									value="${p.paymentDate}" pattern="dd MMM yyyy" />
								<br />
							</c:if>

							<a
								href="${pageContext.request.contextPath}/freelancerdownloadInvoice?projectId=${p.id}&freelancerId=${freelancer.id}"
								class="btn btn-sm btn-outline-primary"> <i
								class="fas fa-download me-1"></i>Download Invoice
							</a>

						</div>
					</c:forEach>
				</div>

				<!-- Chart -->
				<div class="chart-container mt-5">
					<h6 class="text-secondary">Monthly Earnings</h6>
					<canvas id="earningsChart" height="80"></canvas>
				</div>
			</div>
		</div>
	</div>

	<script>
    const ctx = document.getElementById('earningsChart').getContext('2d');
    const earningsChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                <%for (String month : earningsByMonth.keySet()) {%>
                    "<%=month%>",
                <%}%>
            ],
            datasets: [{
                label: 'Earnings (₹)',
                data: [
                    <%for (Double val : earningsByMonth.values()) {%>
                        <%=val%>,
                    <%}%>
                ],
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 2
            }]
        },
        options: {
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>

</body>
</html>
