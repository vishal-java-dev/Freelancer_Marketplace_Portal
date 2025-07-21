package com.dao;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import com.db.DBConnect;
import com.entity.Project;

public class ProjectDao {
	private Connection conn;

	public ProjectDao(Connection conn) {
		this.conn = conn;
	}

	// ✅ Add new project
	public boolean addProject(Project p) {
	    boolean success = false;
	    try {
	        String sql = "INSERT INTO projects (client_id, client_email, category, title, description, skills_required, budget, deadline, status, freelancer_name, created_at, posted_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), CURDATE())";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, p.getClientId());
	        ps.setString(2, p.getClientEmail());
	        ps.setString(3, p.getCategory());
	        ps.setString(4, p.getTitle());
	        ps.setString(5, p.getDescription());
	        ps.setString(6, p.getSkillsRequired());
	        ps.setDouble(7, p.getBudget());
	        ps.setDate(8, p.getDeadline());
	        ps.setString(9, "Open"); // default project status
	        ps.setString(10, p.getFreelancerName() != null ? p.getFreelancerName() : ""); // required field, set as empty string initially

	        success = ps.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return success;
	}


	public List<Project> getAllActiveProjects() {
		List<Project> list = new ArrayList<>();
		String sql = "SELECT * FROM projects WHERE LOWER(status) = 'open'";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Project p = new Project();
				p.setId(rs.getInt("id"));
				p.setTitle(rs.getString("title"));
				p.setDescription(rs.getString("description"));
				p.setSkillsRequired(rs.getString("skills_required"));
				p.setBudget(rs.getDouble("budget"));
				p.setStatus(rs.getString("status"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	 // ✅ Get project by ID with client name
    public Project getProjectById(int id) {
        Project p = null;
        try {
            String sql = "SELECT p.*, c.fullname AS client_name " +
                         "FROM projects p " +
                         "LEFT JOIN clients c ON p.client_id = c.id " +
                         "WHERE p.id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Project();
                populateProjectFromResultSet(rs, p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }





	public List<Project> getCompletedProjectsByFreelancer(int freelancerId) {
		List<Project> list = new ArrayList<>();
		String sql = "SELECT * FROM projects WHERE assigned_to = ? AND LOWER(status) = 'completed'";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, freelancerId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Project p = new Project();
				populateProjectFromResultSet(rs, p);
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Project> getAllProjects() {
		List<Project> list = new ArrayList<>();
		String sql = "SELECT * FROM projects ORDER BY id DESC";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Project p = new Project();
				populateProjectFromResultSet(rs, p);
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Project> getProjectsByClientId(int clientId) {
		List<Project> list = new ArrayList<>();
		String sql = "SELECT * FROM projects WHERE client_id = ? ORDER BY id DESC";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, clientId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Project p = new Project();
				populateProjectFromResultSet(rs, p);
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int getTotalProjects() {
		int count = 0;
		try (Connection conn = DBConnect.getConn();
				PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM projects")) {
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}




	public boolean assignFreelancerToProject(int projectId, int freelancerId) {
	    try {
	        // Step 1: Fetch freelancer name from freelancers table
	        String nameSql = "SELECT fullname FROM freelancers WHERE id = ?";
	        PreparedStatement namePs = conn.prepareStatement(nameSql);
	        namePs.setInt(1, freelancerId);
	        ResultSet nameRs = namePs.executeQuery();

	        String freelancerName = null;
	        if (nameRs.next()) {
	            freelancerName = nameRs.getString("fullname");
	        }

	        // Step 2: Update project with freelancer ID and name
	        String updateSql = "UPDATE projects SET assigned_to = ?, freelancer_name = ?, status = 'in progress' WHERE id = ?";
	        PreparedStatement updatePs = conn.prepareStatement(updateSql);
	        updatePs.setInt(1, freelancerId);
	        updatePs.setString(2, freelancerName);
	        updatePs.setInt(3, projectId);

	        return updatePs.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	public boolean deleteProjectById(int id) {
		boolean f = false;
		try {
			String sql = "DELETE FROM projects WHERE id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			f = ps.executeUpdate() == 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// ✅ Mark project as completed and set payment status/date
	public boolean markProjectAsCompleted(int projectId, Date currentDate) {
	    boolean success = false;
	    String sql = "UPDATE projects SET status = ?, payment_status = ?, completion_date = ?, payment_date = ? WHERE id = ?";

	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, "completed");
	        ps.setString(2, "transferred");
	        ps.setDate(3, currentDate);
	        ps.setDate(4, currentDate);
	        ps.setInt(5, projectId);

	        success = ps.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return success;
	}



	public boolean updateProjectStatus(int projectId, String status) {
		try {
			PreparedStatement ps;
			if ("completed".equalsIgnoreCase(status)) {
				String sql = "UPDATE projects SET status = ?, completion_date = CURDATE() WHERE id = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, status);
				ps.setInt(2, projectId);
			} else {
				String sql = "UPDATE projects SET status = ? WHERE id = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, status);
				ps.setInt(2, projectId);
			}
			return ps.executeUpdate() == 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean markPaymentTransferred(int projectId, Date paymentDate) {
	    boolean result = false;
	    try {
	        String sql = "UPDATE projects SET payment_status = ?, payment_date = ? WHERE id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, "transferred");
	        ps.setDate(2, paymentDate);
	        ps.setInt(3, projectId);

	        result = ps.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}


	public List<Project> getCompletedProjectsByFreelancerId(int freelancerId) {
		List<Project> list = new ArrayList<>();
		try {
			String sql = "SELECT * FROM projects WHERE assigned_to = ? AND status = 'completed'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, freelancerId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				// populate and add to list
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public void logPayment(int projectId, String markedBy, String mode, String txnId, String notes) {
	    try {
	        String sql = "INSERT INTO payment_logs (project_id, marked_by, payment_mode, transaction_id, notes) VALUES (?, ?, ?, ?, ?)";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, projectId);
	        ps.setString(2, markedBy);
	        ps.setString(3, mode);
	        ps.setString(4, txnId);
	        ps.setString(5, notes);
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public List<Project> getAllCompletedProjectsWithRatings() {
	    List<Project> list = new ArrayList<>();
	    String sql = "SELECT p.*, c.fullname AS client_name, f.fullname AS freelancer_name, r.rating " +
	                 "FROM projects p " +
	                 "JOIN clients c ON p.client_id = c.id " +
	                 "JOIN freelancers f ON p.assigned_to = f.id " +
	                 "LEFT JOIN reviews r ON p.id = r.project_id " +
	                 "WHERE p.status = 'completed' AND p.payment_status = 'transferred'";

	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Project p = new Project();
	            populateProjectFromResultSet(rs, p);
	            try {
	                p.setRating(rs.getInt("rating"));
	            } catch (SQLException ignored) {
	                // in case rating is null
	            }
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	public List<Project> getAssignedProjects(int freelancerId) {
	    List<Project> list = new ArrayList<>();
	    String sql = "SELECT p.*, c.fullname AS client_name FROM projects p " +
	                 "JOIN clients c ON p.client_id = c.id " +
	                 "WHERE p.assigned_to = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, freelancerId);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Project p = new Project();
	            populateProjectFromResultSet(rs, p);
	            p.setClientName(rs.getString("client_name"));
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}



	// ✅ Extract reusable mapping logic
	     private void populateProjectFromResultSet(ResultSet rs, Project p) throws SQLException {
        p.setId(rs.getInt("id"));
        p.setClientId(rs.getInt("client_id"));
        p.setClientEmail(rs.getString("client_email"));
        p.setTitle(rs.getString("title"));
        p.setCategory(rs.getString("category"));
        p.setDescription(rs.getString("description"));
        p.setSkillsRequired(rs.getString("skills_required"));
        p.setBudget(rs.getDouble("budget"));
        p.setStatus(rs.getString("status"));
        p.setAssignedTo(rs.getInt("assigned_to"));
        p.setFreelancerName(rs.getString("freelancer_name"));
        p.setDeadline(rs.getDate("deadline"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setPostedDate(rs.getDate("posted_date"));
        p.setCompletionDate(rs.getDate("completion_date"));
        p.setPaymentDate(rs.getDate("payment_date"));
        p.setPaymentStatus(rs.getString("payment_status"));

        // ✅ Set clientName if present in joined result
        try {
            String clientName = rs.getString("client_name");
            if (clientName != null) {
                p.setClientName(clientName);
            }
        } catch (SQLException ignore) {
            // client_name not present in the result (e.g., in non-joined queries)
        }
    }

    
}