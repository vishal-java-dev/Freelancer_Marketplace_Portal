package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Bid;

public class BidDao {

	private Connection conn;

	public BidDao(Connection conn) {
		this.conn = conn;
	}

	// ✅ Used to show "Messages" in freelancer side (with clientId & projectId)
	public List<Bid> getBidsByFreelancerId(int freelancerId) {
		List<Bid> list = new ArrayList<>();
		try {
			String sql = "SELECT b.id, b.project_id, b.freelancer_id, b.bid_amount, b.timeline, b.cover_letter, b.message, b.bid_date, "
					+ "p.title AS project_title, p.client_id AS client_id " + "FROM bids b "
					+ "JOIN projects p ON b.project_id = p.id " + "WHERE b.freelancer_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, freelancerId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Bid bid = new Bid();
				bid.setId(rs.getInt("id"));
				bid.setProjectId(rs.getInt("project_id"));
				bid.setFreelancerId(rs.getInt("freelancer_id"));
				bid.setProjectTitle(rs.getString("project_title"));
				bid.setClientId(rs.getInt("client_id"));
				bid.setBidAmount(rs.getDouble("bid_amount"));
				bid.setTimeline(rs.getInt("timeline")); // Optional: use if needed
				bid.setCoverLetter(rs.getString("cover_letter")); // ✅ Cover letter now retrieved
				bid.setMessage(rs.getString("message")); // ✅ Message explicitly fetched
				bid.setBidDate(rs.getTimestamp("bid_date").toString());
				list.add(bid);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean placeBid(Bid bid) {
	    boolean result = false;
	    try {
	        System.out.println("⚙️ DEBUG: Inside placeBid()");
	        System.out.println("➡️ Project ID: " + bid.getProjectId());
	        System.out.println("➡️ Freelancer ID: " + bid.getFreelancerId());
	        System.out.println("➡️ Bid Amount: " + bid.getBidAmount());
	        System.out.println("➡️ Timeline: " + bid.getTimeline());
	        System.out.println("➡️ Cover Letter: " + bid.getCoverLetter());

	        String sql = "INSERT INTO bids (project_id, freelancer_id, bid_amount, timeline, cover_letter, bid_date) " +
	                     "VALUES (?, ?, ?, ?, ?, NOW())";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, bid.getProjectId());
	        ps.setInt(2, bid.getFreelancerId());
	        ps.setDouble(3, bid.getBidAmount());
	        ps.setInt(4, bid.getTimeline());
	        ps.setString(5, bid.getCoverLetter());

	        int count = ps.executeUpdate();
	        result = (count == 1);
	        System.out.println(result ? "✅ Bid inserted successfully" : "❌ Bid insert failed");
	        System.out.println("📨 Bid CoverLetter to insert: " + bid.getCoverLetter());

	    } catch (Exception e) {
	        System.out.println("❌ Exception in placeBid(): " + e.getMessage());
	        e.printStackTrace();
	    }
	    return result;
	}




	public List<Bid> getBidsByProjectId(int projectId) {
	    List<Bid> list = new ArrayList<>();

	    String sql = "SELECT b.*, f.fullname AS freelancer_name, f.email AS freelancer_email, p.client_id " +
	                 "FROM bids b " +
	                 "JOIN freelancers f ON b.freelancer_id = f.id " +
	                 "JOIN projects p ON b.project_id = p.id " +
	                 "WHERE b.project_id = ?";

	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, projectId);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Bid bid = new Bid();
	            bid.setId(rs.getInt("id"));
	            bid.setProjectId(rs.getInt("project_id"));
	            bid.setClientId(rs.getInt("client_id"));
	            bid.setFreelancerId(rs.getInt("freelancer_id"));
	            bid.setBidAmount(rs.getDouble("bid_amount"));
	            bid.setTimeline(rs.getInt("timeline"));
	            bid.setCoverLetter(rs.getString("cover_letter")); // ✅ correct
	            bid.setMessage(rs.getString("message"));           // ✅ add this
	            bid.setBidDate(rs.getString("bid_date")); 
	            bid.setFreelancerName(rs.getString("freelancer_name"));
	            bid.setFreelancerEmail(rs.getString("freelancer_email"));

	            // 🧪 Debugging
	            System.out.println("📦 Bid Retrieved - ID: " + bid.getId());
	            System.out.println("📝 Cover Letter: " + bid.getCoverLetter());

	            list.add(bid);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}



	
	// Place this inside class BidDao

	public List<Bid> getActiveBidsByFreelancerId(int freelancerId) {
	    List<Bid> list = new ArrayList<>();
	    String sql = "SELECT b.*, p.title AS project_title, p.client_id AS client_id " +
	                 "FROM bids b " +
	                 "JOIN projects p ON b.project_id = p.id " +
	                 "WHERE b.freelancer_id = ? AND p.status != 'completed'";
	    try {
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, freelancerId);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Bid bid = new Bid();
	            bid.setId(rs.getInt("id"));
	            bid.setProjectId(rs.getInt("project_id"));
	            bid.setProjectTitle(rs.getString("project_title"));
	            bid.setClientId(rs.getInt("client_id"));
	            bid.setBidAmount(rs.getDouble("bid_amount"));
	            bid.setMessage(rs.getString("message"));
	            bid.setBidDate(rs.getTimestamp("bid_date").toString());
	            list.add(bid);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public boolean deleteBidById(int bidId) {
	    try {
	        String sql = "DELETE FROM bids WHERE id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, bidId);
	        return ps.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public Bid getBidByProjectAndFreelancer(int projectId, int freelancerId) {
	    Bid bid = null;
	    try {
	        String sql = "SELECT * FROM bids WHERE project_id = ? AND freelancer_id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, projectId);
	        ps.setInt(2, freelancerId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            bid = new Bid();
	            bid.setId(rs.getInt("id"));
	            bid.setProjectId(rs.getInt("project_id"));
	            bid.setFreelancerId(rs.getInt("freelancer_id"));
	            bid.setBidAmount(rs.getDouble("bid_amount"));
	            bid.setMessage(rs.getString("message"));
	            bid.setBidDate(rs.getTimestamp("bid_date").toString());
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return bid;
	}



}
