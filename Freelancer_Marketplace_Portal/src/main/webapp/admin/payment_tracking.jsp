<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../Components/allCss.jsp" %>
<%@ include file="navbar.jsp" %>

<div class="container mt-5">
    <h3 class="text-center mb-4 text-primary">Project Payment & Status Monitoring</h3>

    <c:if test="${empty projects}">
        <div class="text-center text-muted">No projects found.</div>
    </c:if>

    <c:if test="${not empty projects}">
        <table class="table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>Project Title</th>
                    <th>Client</th>
                    <th>Freelancer</th>
                    <th>Budget</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Rating</th>
                    <th>Payment Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${projects}">
                    <tr>
                        <td>${p.title}</td>
                        <td>${p.clientName}</td>
                        <td>${p.freelancerName}</td>
                        <td>₹${p.budget}</td>
                        <td>
                            <span class="badge bg-info text-dark">${p.status}</span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${p.paymentStatus == 'transferred'}">
                                    <span class="badge bg-success">Transferred</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-warning text-dark">Pending</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${p.rating > 0}">
                                    <span class="text-warning fw-bold">${p.rating} ★</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">No rating</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${p.paymentDate != null}">
                                <fmt:formatDate value="${p.paymentDate}" pattern="dd-MM-yyyy" />
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
