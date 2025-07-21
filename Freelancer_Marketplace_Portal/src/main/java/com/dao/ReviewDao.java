package com.dao;

import java.sql.*;
import java.util.*;
import com.entity.Review;
import com.db.DBConnect;

public class ReviewDao {
    private Connection conn;

    public ReviewDao(Connection conn) {
        this.conn = conn;
    }

    public boolean addReview(Review review) {
        boolean f = false;
        try {
            String sql = "INSERT INTO reviews (freelancer_id, client_id, project_id, rating, review) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, review.getFreelancerId());
            ps.setInt(2, review.getClientId());
            ps.setInt(3, review.getProjectId());
            ps.setInt(4, review.getRating());
            ps.setString(5, review.getReview());

            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Review> getReviewsByFreelancer(int freelancerId) {
        List<Review> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM reviews WHERE freelancer_id = ? ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, freelancerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getInt("id"));
                r.setFreelancerId(rs.getInt("freelancer_id"));
                r.setClientId(rs.getInt("client_id"));
                r.setProjectId(rs.getInt("project_id"));
                r.setRating(rs.getInt("rating"));
                r.setReview(rs.getString("review"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean hasReview(int clientId, int projectId) {
        boolean exists = false;
        try {
            String sql = "SELECT id FROM reviews WHERE client_id=? AND project_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, clientId);
            ps.setInt(2, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) exists = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }
    
    public List<Review> getReviewsByFreelancerId(int freelancerId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, p.title AS project_title FROM reviews r " +
                     "JOIN projects p ON r.project_id = p.id " +
                     "WHERE r.freelancer_id = ? ORDER BY r.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, freelancerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getInt("id"));
                r.setFreelancerId(rs.getInt("freelancer_id"));
                r.setClientId(rs.getInt("client_id"));
                r.setProjectId(rs.getInt("project_id"));
                r.setRating(rs.getInt("rating"));
                r.setReview(rs.getString("review"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
                r.setProjectTitle(rs.getString("project_title"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public Review getReviewByProjectAndFreelancer(int projectId, int freelancerId) {
        Review r = null;
        String sql = "SELECT * FROM reviews WHERE project_id=? AND freelancer_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setInt(2, freelancerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                r = new Review();
                r.setId(rs.getInt("id"));
                r.setFreelancerId(rs.getInt("freelancer_id"));
                r.setClientId(rs.getInt("client_id"));
                r.setProjectId(rs.getInt("project_id"));
                r.setRating(rs.getInt("rating"));
                r.setReview(rs.getString("review"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    public boolean updateReview(Review r) {
        boolean success = false;
        String sql = "UPDATE reviews SET rating=?, review=? WHERE freelancer_id=? AND project_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getRating());
            ps.setString(2, r.getReview());
            ps.setInt(3, r.getFreelancerId());
            ps.setInt(4, r.getProjectId());

            int i = ps.executeUpdate();
            success = i > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }


    
    public boolean deleteReviewByProjectAndFreelancer(int projectId, int freelancerId) {
        boolean deleted = false;
        String sql = "DELETE FROM reviews WHERE project_id=? AND freelancer_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setInt(2, freelancerId);
            int i = ps.executeUpdate();
            if (i > 0) deleted = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deleted;
    }




}