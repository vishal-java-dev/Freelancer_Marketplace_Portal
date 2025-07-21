package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.db.DBConnect;
import com.entity.Freelancer;

public class FreelancerDao {

    private Connection conn;

    public FreelancerDao(Connection conn) {
        this.conn = conn;
    }

    // Register new freelancer
    public boolean registerFreelancer(Freelancer f) {
        boolean success = false;
        try {
            String sql = "INSERT INTO freelancers (fullname, email, skills, experience, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, f.getFullname());
            ps.setString(2, f.getEmail());
            ps.setString(3, f.getSkills());
            ps.setInt(4, f.getExperience());
            ps.setString(5, f.getPassword());

            int rowCount = ps.executeUpdate();
            success = rowCount == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }

    // Login freelancer
    public Freelancer loginFreelancer(String email, String password) {
        Freelancer freelancer = null;
        try {
            String sql = "SELECT * FROM freelancers WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                freelancer = new Freelancer();
                freelancer.setId(rs.getInt("id"));
                freelancer.setFullname(rs.getString("fullname"));
                freelancer.setEmail(rs.getString("email"));
                freelancer.setSkills(rs.getString("skills"));
                freelancer.setExperience(rs.getInt("experience"));
                freelancer.setPassword(rs.getString("password"));
                freelancer.setRegDate(rs.getString("reg_date"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return freelancer;
    }
    
 // Get freelancer by ID
    public Freelancer getFreelancerById(int id) {
        Freelancer freelancer = null;
        try {
            String sql = "SELECT * FROM freelancers WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                freelancer = new Freelancer();
                freelancer.setId(rs.getInt("id"));
                freelancer.setFullname(rs.getString("fullname"));
                freelancer.setEmail(rs.getString("email"));
                freelancer.setSkills(rs.getString("skills"));
                freelancer.setExperience(rs.getInt("experience"));
                freelancer.setPassword(rs.getString("password"));
                freelancer.setRegDate(rs.getString("reg_date").toString());

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return freelancer;
    }

    // Update password
    public boolean updatePassword(int id, String newPassword) {
        boolean result = false;
        try {
            String sql = "UPDATE freelancers SET password = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, id);
            int rows = ps.executeUpdate();
            result = rows == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public List<Freelancer> getAllFreelancers() {
        List<Freelancer> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM freelancers ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Freelancer f = new Freelancer();
                f.setId(rs.getInt("id"));
                f.setFullname(rs.getString("fullname"));
                f.setEmail(rs.getString("email"));
                f.setSkills(rs.getString("skills"));
                f.setExperience(rs.getInt("experience"));
                f.setPassword(rs.getString("password"));
                f.setRegDate(rs.getString("reg_date"));
                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteFreelancerById(int id) {
        boolean result = false;
        try {
            String sql = "DELETE FROM freelancers WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            result = ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public int getTotalFreelancers() {
        int count = 0;
        try (Connection conn = DBConnect.getConn();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM freelancers")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }



}
