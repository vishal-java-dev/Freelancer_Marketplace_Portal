<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.dao.BidDao, com.entity.Bid, com.entity.Freelancer, com.db.DBConnect" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<%
    Freelancer freelancerObj = (Freelancer) session.getAttribute("freelancerObj");
    if (freelancerObj == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }

    BidDao bidDao = new BidDao(DBConnect.getConn());
    List<Bid> bidList = bidDao.getBidsByFreelancerId(freelancerObj.getId());
    request.setAttribute("bidList", bidList);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bids - WorkLink</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        body {
            background-color: #f1f3f6;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            background: #ffffff;
            padding: 40px;
            margin-top: 50px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }

        .card {
            border: none;
            border-radius: 16px;
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        }

        .card h5 {
            font-weight: 600;
            color: #212529;
        }

        .card p {
            font-size: 14px;
            color: #333;
        }

        .text-muted small {
            font-size: 12px;
        }

        .btn-chat {
            margin-top: 12px;
        }
    </style>
</head>
<body>

<jsp:include page="Navbar.jsp" />

<div class="container">
    <h3 class="mb-4 text-dark fw-bold"><i class="fas fa-gavel"></i> My Placed Bids</h3>

    <c:if test="${not empty sessionScope.errorMsg}">
        <div class="alert alert-danger">${sessionScope.errorMsg}</div>
        <c:remove var="errorMsg" scope="session" />
    </c:if>

    <c:choose>
        <c:when test="${not empty bidList}">
            <div class="row">
                <c:forEach var="bid" items="${bidList}">
                    <div class="col-md-6 mb-4">
                        <div class="card p-4">
                            <h5><i class="fas fa-diagram-project me-2 text-secondary"></i>
                                <c:out value="${bid.projectTitle}" />
                            </h5>

                            <p><strong>Bid Amount:</strong> ₹
                                <fmt:formatNumber value="${bid.bidAmount}" type="number" minFractionDigits="2" />
                            </p>

                            <c:if test="${not empty bid.coverLetter}">
                                <p><strong>Cover Letter:</strong> <c:out value="${bid.coverLetter}" /></p>
                            </c:if>

                            <c:if test="${not empty bid.message}">
                                <p><strong>Message:</strong> <c:out value="${bid.message}" /></p>
                            </c:if>

                            <p class="text-muted">
                                <small>
                                    <i class="fa fa-calendar-alt me-1"></i>
                                    <fmt:parseDate value="${bid.bidDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" />
                                    <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy hh:mm a" />
                                </small>
                            </p>

                            <a href="freelancer_chat.jsp?pid=${bid.projectId}&clientId=${bid.clientId}" 
                               class="btn btn-sm btn-outline-primary btn-chat">
                                <i class="fa fa-comments"></i> Chat with Client
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">You haven't placed any bids yet.</div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
