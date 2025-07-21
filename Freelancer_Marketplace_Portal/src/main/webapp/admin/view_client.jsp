<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.dao.ClientDao"%>
<%@ page import="com.entity.Client"%>
<%@ page import="com.db.DBConnect"%>

<%
if (session.getAttribute("adminObj") == null) {
	response.sendRedirect("login.jsp?msg=unauthorized");
	return;
}

ClientDao clientDao = new ClientDao(DBConnect.getConn());
List<Client> clientList = clientDao.getAllClients();
request.setAttribute("clientList", clientList);
%>

<!DOCTYPE html>
<html>
<head>
<title>All Clients - Admin</title>
<%@ include file="../Components/allCss.jsp"%>
<style>
body {
	background: url('https://images.unsplash.com/photo-1581092334394-75c4b7f9b586?auto=format&fit=crop&w=1600&q=80') no-repeat center center fixed;
	background-size: cover;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.client-card {
	background-color: rgba(255, 255, 255, 0.95);
	padding: 25px;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
	margin-bottom: 20px;
}

h3 {

	font-weight: bold;
	color:#182b4a;
}

.client-detail {
	font-size: 1rem;
	color: #333;
}

.label {
	font-weight: 600;
	color: #555;
}
</style>
</head>
<body>

	<%@ include file="navbar.jsp"%>

	<div class="container py-5">
		<h3 class="mb-4">
			<i class="fas fa-user-tie"></i>Client Details
		</h3>

		<c:if test="${param.msg == 'deleted'}">
			<div class="alert alert-success">Client deleted successfully.</div>
		</c:if>

		<c:if test="${param.msg == 'error'}">
			<div class="alert alert-danger">Something went wrong.</div>
		</c:if>

		<c:if test="${empty clientList}">
			<div class="alert alert-warning text-center">No clients found.</div>
		</c:if>

		<div class="row">
			<c:forEach var="client" items="${clientList}">
				<div class="col-md-6">
					<div class="client-card">
						<p>
							<span class="label">Client ID:</span> ${client.id}
						</p>
						<p>
							<span class="label">Name:</span> ${client.fullname}
						</p>
						<p>
							<span class="label">Email:</span> ${client.email}
						</p>
						<p>
							<span class="label">Company:</span> ${client.company}
						</p>
						<p>
							<span class="label">Registered On:</span> ${client.regDate}
						</p>
						<a href="delete_client.jsp?id=${client.id}"
							class="btn btn-sm btn-danger"
							onclick="return confirm('Are you sure you want to delete this client?')">Delete</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>
