<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ page
	import="java.util.*, com.dao.ProjectDao, com.dao.BidDao, com.db.DBConnect, com.entity.Project, com.entity.Bid, com.entity.Freelancer"%>

<%
// Check login
Freelancer freelancer = (Freelancer) session.getAttribute("freelancerObj");
if (freelancer == null) {
	response.sendRedirect("login.jsp?msg=unauthorized");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Available Projects - Freelancer Panel</title>
<%@ include file="../Components/allCss.jsp"%>
<style>
body {
	background-color: #f0f2f5;
}

.project-card {
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	margin-bottom: 20px;
}

.card-title {
	font-size: 20px;
	font-weight: 600;
}
</style>
</head>
<body>

	<%@ include file="Navbar.jsp"%>

	<div class="container mt-4">
		<h3 class="mb-4">Available Projects</h3>

		<div class="row">
			<%
			ProjectDao projectDao = new ProjectDao(DBConnect.getConn());
			BidDao bidDao = new BidDao(DBConnect.getConn());
			List<Project> list = projectDao.getAllActiveProjects();

			for (Project p : list) {
				Bid existingBid = bidDao.getBidByProjectAndFreelancer(p.getId(), freelancer.getId());
			%>
			<div class="col-md-6">
				<div class="card project-card p-3">
					<h5 class="card-title"><%=p.getTitle()%></h5>
					<p>
						<strong>Budget:</strong> ₹<%=p.getBudget()%></p>
					<p>
						<strong>Skills Required:</strong>
						<%=p.getSkillsRequired()%></p>
					<p>
						<strong>Description:</strong>
						<%=p.getDescription()%></p>

					<%
					if (existingBid == null) {
					%>
					<a href="bid_project.jsp?pid=<%=p.getId()%>"
						class="btn btn-success btn-sm">Place a Bid</a>
					<%
					} else {
					%>
					<form action="../DeleteBidServlet" method="post"
						onsubmit="return confirm('Are you sure you want to delete your bid for this project?');"
						style="display: inline;">
						<input type="hidden" name="bidId" value="<%=existingBid.getId()%>">
						<button type="submit" class="btn btn-danger btn-sm">Delete
							Bid</button>
					</form>
					<%
					}
					%>
				</div>
			</div>
			<%
			}

			if (list.isEmpty()) {
			%>
			<div class="col-12">
				<div class="alert alert-info text-center">No active projects
					available at the moment.</div>
			</div>
			<%
			}
			%>
		</div>
	</div>

</body>
</html>
