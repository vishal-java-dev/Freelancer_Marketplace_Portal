<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.entity.Freelancer, com.dao.MessageDao, com.entity.Message, com.db.DBConnect" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<%
    Freelancer freelancerObj = (Freelancer) session.getAttribute("freelancerObj");
    if (freelancerObj == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }

    int projectId = 0;
    int clientId = 0;

    try {
        if (request.getParameter("pid") != null) {
            projectId = Integer.parseInt(request.getParameter("pid"));
        }
        if (request.getParameter("clientId") != null) {
            clientId = Integer.parseInt(request.getParameter("clientId"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    MessageDao msgDao = new MessageDao(DBConnect.getConn());
    List<Message> chatList = msgDao.getMessagesByProjectId(projectId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Freelancer Chat - WorkLink</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        .chat-box {
            height: 400px;
            overflow-y: scroll;
            background: #f9f9f9;
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .message {
            margin-bottom: 15px;
        }

        .message.client {
            text-align: left;
        }

        .message.freelancer {
            text-align: right;
        }

        .message p {
            position: relative;
            display: inline-block;
            padding: 10px 15px;
            border-radius: 12px;
            max-width: 70%;
            margin: 0;
            cursor: pointer;
        }

        .message.client p {
            background: #e4e6eb;
        }

        .message.freelancer p {
            background: #d1e7dd;
        }

        .timestamp {
            display: none;
            position: absolute;
            bottom: -18px;
            left: 10px;
            font-size: 0.75em;
            color: #666;
            white-space: nowrap;
        }

        .message:hover .timestamp {
            display: block;
        }
    </style>
</head>
<body>

<jsp:include page="Navbar.jsp" />

<div class="container mt-4">
    <h4>Chat (Project ID: <%= projectId %>)</h4>
    <div class="card">
        <div class="card-body">
            <div class="chat-box">
                <% for (Message msg : chatList) {
                    String cssClass = "unknown";
                    if (msg.getSenderId() == freelancerObj.getId()) {
                        cssClass = "freelancer";
                    } else if (msg.getSenderId() == clientId) {
                        cssClass = "client";
                    }
                %>
                    <div class="message <%= cssClass %>">
                        <p>
                            <%= msg.getMessage() %>
                            <span class="timestamp"><%= msg.getTimestamp() %></span>
                        </p>
                    </div>
                <% } %>
            </div>

            <!-- Send Message Form -->
            <form action="../freelancerSendMessageServlet" method="post">
                <input type="hidden" name="projectId" value="<%= projectId %>">
                <input type="hidden" name="senderId" value="<%= freelancerObj.getId() %>">
                <input type="hidden" name="receiverId" value="<%= clientId %>">

                <div class="input-group">
                    <input type="text" name="message" class="form-control" placeholder="Type your message..." required>
                    <button type="submit" class="btn btn-success">Send</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
