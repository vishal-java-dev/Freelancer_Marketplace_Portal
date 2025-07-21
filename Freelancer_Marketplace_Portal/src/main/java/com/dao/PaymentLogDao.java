package com.dao;

import com.entity.PaymentLog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentLogDao {
    private Connection conn;

    public PaymentLogDao(Connection conn) {
        this.conn = conn;
    }

    // Insert a new payment log
    public boolean insertPaymentLog(PaymentLog log) {
        boolean success = false;
        try {
            String sql = "INSERT INTO payment_logs " +
                         "(project_id, marked_by, payment_mode, transaction_id, notes, client_id, freelancer_id, amount) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, log.getProjectId());
            ps.setString(2, log.getMarkedBy());
            ps.setString(3, log.getPaymentMode());
            ps.setString(4, log.getTransactionId());
            ps.setString(5, log.getNotes());
            ps.setInt(6, log.getClientId());
            ps.setInt(7, log.getFreelancerId());
            ps.setDouble(8, log.getAmount());

            success = ps.executeUpdate() == 1;
        } catch (Exception e) {
            System.out.println("Error inserting payment log: " + e.getMessage());
            e.printStackTrace();
        }
        return success;
    }


    // Optional: Get logs by project ID
    public List<PaymentLog> getLogsByProjectId(int projectId) {
        List<PaymentLog> logs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM payment_logs WHERE project_id = ? ORDER BY marked_on DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PaymentLog log = new PaymentLog();
                log.setId(rs.getInt("id"));
                log.setProjectId(rs.getInt("project_id"));
                log.setMarkedBy(rs.getString("marked_by"));
                log.setMarkedOn(rs.getTimestamp("marked_on"));
                log.setPaymentMode(rs.getString("payment_mode"));
                log.setTransactionId(rs.getString("transaction_id"));
                log.setNotes(rs.getString("notes"));
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return logs;
    }

    // Optional: Get all payment logs (admin feature)
    public List<PaymentLog> getAllPaymentLogs() {
        List<PaymentLog> logs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM payment_logs ORDER BY marked_on DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PaymentLog log = new PaymentLog();
                log.setId(rs.getInt("id"));
                log.setProjectId(rs.getInt("project_id"));
                log.setMarkedBy(rs.getString("marked_by"));
                log.setMarkedOn(rs.getTimestamp("marked_on"));
                log.setPaymentMode(rs.getString("payment_mode"));
                log.setTransactionId(rs.getString("transaction_id"));
                log.setNotes(rs.getString("notes"));
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return logs;
    }
}
