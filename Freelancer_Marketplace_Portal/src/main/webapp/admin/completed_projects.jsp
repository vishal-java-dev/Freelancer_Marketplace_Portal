<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../Components/allCss.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container mt-5">
    <h3 class="text-center text-success mb-4">Completed Projects with Reviews</h3>

    <c:if test="${empty completedProjects}">
        <p class="text-center text-muted">No completed projects found.</p>
    </c:if>

    <c:if test="${not empty completedProjects}">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Project Title</th>
                    <th>Freelancer Name</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Client Rating</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${completedProjects}">
                    <tr>
                        <td>${p.title}</td>
                        <td>${p.freelancerName}</td>
                        <td>${p.status}</td>
                        <td>${p.paymentStatus}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.rating > 0}">
                                    <c:forEach var="i" begin="1" end="${p.rating}">
                                        <i class="fas fa-star text-warning"></i>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Not rated</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
