package com.dao;

import java.sql.*;
import java.util.*;

import com.entity.Message;

public class MessageDao {

    private Connection conn;

    public MessageDao(Connection conn) {
        this.conn = conn;
    }

    // ✅ 1. Insert new message
    public boolean sendMessage(Message msg) {
        boolean success = false;
        try {
            String sql = "INSERT INTO messages (project_id, sender_id, receiver_id, message) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, msg.getProjectId());
            ps.setInt(2, msg.getSenderId());
            ps.setInt(3, msg.getReceiverId());
            ps.setString(4, msg.getMessage());

            int rows = ps.executeUpdate();
            success = rows == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // ✅ 2. Get messages by project ID
    public List<Message> getMessagesByProjectId(int projectId) {
        List<Message> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM messages WHERE project_id = ? ORDER BY timestamp ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setProjectId(rs.getInt("project_id"));
                msg.setSenderId(rs.getInt("sender_id"));
                msg.setReceiverId(rs.getInt("receiver_id"));
                msg.setMessage(rs.getString("message"));
                msg.setTimestamp(rs.getString("timestamp"));
                list.add(msg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ 3. Get messages by sender & receiver ID (ignores project)
    public List<Message> getMessages(int senderId, int receiverId) {
        List<Message> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM messages WHERE " +
                         "(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) " +
                         "ORDER BY timestamp ASC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            ps.setInt(3, receiverId);
            ps.setInt(4, senderId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setProjectId(rs.getInt("project_id"));
                msg.setSenderId(rs.getInt("sender_id"));
                msg.setReceiverId(rs.getInt("receiver_id"));
                msg.setMessage(rs.getString("message"));
                msg.setTimestamp(rs.getString("timestamp"));
                list.add(msg);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
     
    
    public boolean deleteMessagesByProjectAndFreelancer(int projectId, int freelancerId) {
        try {
            String sql = "DELETE FROM messages WHERE project_id = ? AND (sender_id = ? OR receiver_id = ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, projectId);
            ps.setInt(2, freelancerId);
            ps.setInt(3, freelancerId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
