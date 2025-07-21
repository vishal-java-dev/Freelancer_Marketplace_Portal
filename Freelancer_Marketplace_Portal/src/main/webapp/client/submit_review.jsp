<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.entity.Project"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
int freelancerId = Integer.parseInt(request.getParameter("freelancerId"));
int projectId = Integer.parseInt(request.getParameter("projectId"));
%>

<!DOCTYPE html>
<html>
<head>
<title>Submit Review</title>
<%@ include file="../Components/allCss.jsp"%>
</head>
<body>
	<%@ include file="navbar.jsp"%>

	<div class="container mt-5">
		<div class="card p-4 shadow-sm">
			<h4 class="mb-4">Write a Review</h4>
			<form action="${pageContext.request.contextPath}/SubmitReviewServlet"
				method="post">
				<input type="hidden" name="freelancerId"
					value="${param.freelancerId}" /> <input type="hidden"
					name="projectId" value="${param.projectId}" /> <label for="rating">Rating:</label>
				<select name="rating" id="rating" class="form-select mb-3" required>
					 <option value="5">⭐⭐⭐⭐⭐ - Excellent</option>
                    <option value="4">⭐⭐⭐⭐ - Good</option>
                    <option value="3">⭐⭐⭐ - Average</option>
                    <option value="2">⭐⭐ - Poor</option>
                    <option value="1">⭐ - Very Poor</option>
				</select> <label for="review">Review:</label>
				<textarea name="review" id="review" rows="4"
					class="form-control mb-3" required></textarea>

				<button type="submit" class="btn btn-primary">Submit Review</button>
			</form>

		</div>
	</div>
</body>
</html>
