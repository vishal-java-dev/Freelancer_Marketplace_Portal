package com.dao;

import java.sql.*;
import com.entity.Admin;

public class AdminDao {
    private Connection conn;

    public AdminDao(Connection conn) {
        this.conn = conn;
    }

    public Admin loginAdmin(String email, String password) {
        Admin admin = null;
        try {
            String sql = "SELECT * FROM admins WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
