package com.servlet.client;

import java.io.IOException;

import com.dao.MessageDao;
import com.db.DBConnect;
import com.entity.Message;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ClientSendMessageServlet")
public class ClientSendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            // ✅ Read parameters
            int senderId = Integer.parseInt(request.getParameter("senderId"));
            int receiverId = Integer.parseInt(request.getParameter("receiverId"));
            int projectId = Integer.parseInt(request.getParameter("projectId")); // 🔥 you missed this!
            String message = request.getParameter("message");

            // ✅ Prepare message object
            Message msgObj = new Message();
            msgObj.setSenderId(senderId);
            msgObj.setReceiverId(receiverId);
            msgObj.setMessage(message);
            msgObj.setProjectId(projectId);

            // ✅ Save message
            MessageDao dao = new MessageDao(DBConnect.getConn());
            dao.sendMessage(msgObj);

            // ✅ Redirect back to correct chat (client view)
            response.sendRedirect("client/client_chat.jsp?pid=" + projectId + "&freelancerId=" + receiverId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("client/client_chat.jsp?msg=error");
        }
    }
}
