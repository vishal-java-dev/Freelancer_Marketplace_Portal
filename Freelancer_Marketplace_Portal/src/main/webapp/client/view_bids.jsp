<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>View Bids</title>
<%@ include file="../Components/allCss.jsp"%>

<style>
body {
	background:
		url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1600&q=80')
		no-repeat center center fixed;
	background-size: cover;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.bids-card {
	background: rgba(255, 255, 255, 0.95);
	padding: 2rem;
	border-radius: 1rem;
	margin: 5rem auto;
	max-width: 100%;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
	backdrop-filter: blur(6px);
}

.table thead {
	background-color: #198754;
	color: #fff;
}

.table td, .table th {
	vertical-align: middle;
	font-size: 0.95rem;
}

.btn {
	margin: 2px;
}

.cover-letter-box {
	max-height: 150px;
	overflow-y: auto;
	white-space: pre-wrap;
	font-size: 0.9rem;
}

@media screen and (max-width: 768px) {
	.table thead {
		display: none;
	}
	.table, .table tbody, .table tr, .table td {
		display: block;
		width: 100%;
	}
	.table tr {
		margin-bottom: 1rem;
		background: #f8f9fa;
		border-radius: 10px;
		box-shadow: 0 3px 8px rgba(0, 0, 0, 0.05);
		padding: 1rem;
	}
	.table td {
		text-align: right;
		padding-left: 50%;
		position: relative;
	}
	.table td::before {
		content: attr(data-label);
		position: absolute;
		left: 1rem;
		width: 45%;
		font-weight: bold;
		text-align: left;
	}
}
</style>
</head>

<body>

	<%@ include file="navbar.jsp"%>

	<div class="container">
		<div class="bids-card">
			<h3 class="text-success mb-4">
				<i class="fas fa-gavel"></i> Bids for Project ID:
				<c:out value="${projectId}" />
			</h3>

			<c:if test="${empty bidList}">
				<div class="alert alert-warning text-center">No bids found for
					this project.</div>
			</c:if>

			<c:if test="${not empty bidList}">
				<div class="table-responsive">
					<table class="table table-bordered table-hover align-middle">
						<thead class="text-center">
							<tr>
								<th>Freelancer Name</th>
								<th>Email</th>
								<th>Bid Amount</th>
								<th>Timeline</th>
								<th>Cover Letter</th>
								<th>Bid Date</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="bid" items="${bidList}">
								<tr>
									<td data-label="Name"><c:out value="${bid.freelancerName}" /></td>
									<td data-label="Email"><c:out
											value="${bid.freelancerEmail}" /></td>
									<td data-label="Bid Amount">₹<fmt:formatNumber
											value="${bid.bidAmount}" type="number" minFractionDigits="2" /></td>
									<td data-label="Timeline"><c:out value="${bid.timeline}" />
										days</td>
									<td data-label="Cover Letter">
										<div class="cover-letter-box">
											<c:out value="${bid.coverLetter}" />
										</div>
									</td>
									<td data-label="Date"><fmt:parseDate
											value="${bid.bidDate}" pattern="yyyy-MM-dd HH:mm:ss"
											var="parsedDate" /> <fmt:formatDate value="${parsedDate}"
											pattern="dd MMM yyyy hh:mm a" /></td>
									<td data-label="Action"><a
										href="client/bid_view_profile.jsp?freelancerId=${bid.freelancerId}&projectId=${bid.projectId}"
										class="btn btn-info btn-sm">View Profile</a> <a
										href="client/client_chat.jsp?pid=${bid.projectId}&freelancerId=${bid.freelancerId}"
										class="btn btn-sm btn-primary">Chat</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>
		</div>
	</div>

</body>
</html>
