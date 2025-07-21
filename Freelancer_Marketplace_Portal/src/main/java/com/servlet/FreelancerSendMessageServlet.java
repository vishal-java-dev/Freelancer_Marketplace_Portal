package com.servlet;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.dao.MessageDao;
import com.db.DBConnect;
import com.entity.Message;

@WebServlet("/freelancerSendMessageServlet")
public class FreelancerSendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Fetch projectId from request
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            int senderId = Integer.parseInt(request.getParameter("senderId"));
            int receiverId = Integer.parseInt(request.getParameter("receiverId"));
            String content = request.getParameter("message");

            // Log values for debugging
            System.out.println("FREELANCER SEND MSG -> projectId=" + projectId + ", senderId=" + senderId + ", receiverId=" + receiverId);

            Message msg = new Message();
            msg.setProjectId(projectId);
            msg.setSenderId(senderId);
            msg.setReceiverId(receiverId);
            msg.setMessage(content);

            MessageDao dao = new MessageDao(DBConnect.getConn());
            boolean result = dao.sendMessage(msg);

            if (result) {
                // ðŸ”� Redirect to same chat with correct context
                response.sendRedirect("freelancer/freelancer_chat.jsp?pid=" + projectId + "&clientId=" + receiverId);
            } else {
                response.sendRedirect("freelancer/freelancer_chat.jsp?pid=" + projectId + "&clientId=" + receiverId + "&msg=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("freelancer/freelancer_chat.jsp?msg=error");
        }
    }
}
