<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.dao.MessageDao, com.entity.Message, com.db.DBConnect, com.entity.Client" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<%
    Client clientObj = (Client) session.getAttribute("clientObj");
    if (clientObj == null) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }

    int projectId = 0;
    int freelancerId = 0;

    if (request.getParameter("pid") != null) {
        projectId = Integer.parseInt(request.getParameter("pid"));
    }

    if (request.getParameter("freelancerId") != null) {
        freelancerId = Integer.parseInt(request.getParameter("freelancerId"));
    }

    MessageDao msgDao = new MessageDao(DBConnect.getConn());
    List<Message> chatList = msgDao.getMessagesByProjectId(projectId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Client Chat - WorkLink</title>
    <%@ include file="../Components/allCss.jsp" %>
    <style>
        .chat-box {
            height: 400px;
            overflow-y: scroll;
            background: #f4f6f8;
            padding: 15px;
            border-radius: 10px;
        }

        .message-wrapper {
            width: 100%;
            display: flex;
            margin-bottom: 12px;
        }

        .message {
            position: relative;
            max-width: 70%;
            padding: 10px 15px;
            border-radius: 15px;
            word-wrap: break-word;
            cursor: pointer;
        }

        .client {
            background-color: #d1e7dd;
            margin-left: auto;
            text-align: right;
        }

        .freelancer {
            background-color: #f8d7da;
            margin-right: auto;
            text-align: left;
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

        .input-group {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h4>Chat with Freelancer (Project ID: <%= projectId %>)</h4>
    <div class="card">
        <div class="card-body">
            <div class="chat-box">
                <% for (Message msg : chatList) {
                    int senderId = msg.getSenderId();
                    String senderType = (senderId == clientObj.getId()) ? "client" :
                                        (senderId == freelancerId) ? "freelancer" : "unknown";
                %>
                    <div class="message-wrapper">
                        <div class="message <%= senderType %>">
                            <%= msg.getMessage() %>
                            <span class="timestamp"><%= msg.getTimestamp() %></span>
                        </div>
                    </div>
                <% } %>
            </div>
            
            

            <!-- Send Message Form -->
            <form action="../ClientSendMessageServlet" method="post">
                <input type="hidden" name="projectId" value="<%= projectId %>">
                <input type="hidden" name="senderId" value="<%= clientObj.getId() %>">
                <input type="hidden" name="receiverId" value="<%= freelancerId %>">

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
