<%@ page import="com.dao.ReviewDao, com.db.DBConnect, com.entity.Review" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    int freelancerId = Integer.parseInt(request.getParameter("freelancerId"));
    int projectId = Integer.parseInt(request.getParameter("projectId"));

    ReviewDao dao = new ReviewDao(DBConnect.getConn());
    Review review = dao.getReviewByProjectAndFreelancer(projectId, freelancerId);

    if (review == null) {
        response.sendRedirect(request.getContextPath() + "/client/dashboard.jsp?msg=review_not_found");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Review</title>
    <%@ include file="../Components/allCss.jsp" %>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="container mt-5">
    <h3 class="text-center text-primary mb-4">Edit Review</h3>

    <form action="${pageContext.request.contextPath}/UpdateReviewServlet" method="post" class="col-md-6 offset-md-3">
        <input type="hidden" name="freelancerId" value="<%= review.getFreelancerId() %>" />
        <input type="hidden" name="projectId" value="<%= review.getProjectId() %>" />

        <div class="mb-3">
            <label class="form-label">Rating (1 to 5):</label>
            <input type="number" name="rating" min="1" max="5" value="<%= review.getRating() %>" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Review:</label>
            <textarea name="review" class="form-control" rows="4" required><%= review.getReview() %></textarea>
        </div>

        <button type="submit" class="btn btn-success">Update Review</button>
        <a href="${pageContext.request.contextPath}/client/dashboard.jsp" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</div>

</body>
</html>
