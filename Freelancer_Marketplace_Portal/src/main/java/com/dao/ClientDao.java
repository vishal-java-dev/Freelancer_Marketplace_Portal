package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.entity.Client;
import com.db.DBConnect;

public class ClientDao {
    private Connection conn;

    public ClientDao(Connection conn) {
        this.conn = conn;
    }
    
 // Register client
    public boolean registerClient(Client client) {
        boolean success = false;
        String sql = "INSERT INTO clients (fullname, email, password, company, skills) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, client.getFullname());
            ps.setString(2, client.getEmail());
            ps.setString(3, client.getPassword());
            ps.setString(4, client.getCompany());
            ps.setString(5, client.getSkills());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 1) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
 // Login method
    public Client login(String email, String password) {
        Client client = null;
        String sql = "SELECT * FROM clients WHERE email = ? AND password = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                client = new Client();
                client.setId(rs.getInt("id"));
                client.setFullname(rs.getString("fullname"));
                client.setEmail(rs.getString("email"));
                client.setCompany(rs.getString("company"));
                client.setSkills(rs.getString("skills"));
                client.setRegDate(rs.getString("reg_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return client;
    }
    
    public boolean updateClientProfile(Client client) {
        boolean success = false;
        try {
            String sql = "UPDATE clients SET fullname=?, company=?, skills=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, client.getFullname());
            ps.setString(2, client.getCompany());
            ps.setString(3, client.getSkills());
            ps.setInt(4, client.getId());

            int rows = ps.executeUpdate();
            success = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
    
    //update profile

    public Client getClientById(int id) {
        Client client = null;
        try {
            String sql = "SELECT * FROM clients WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                client = new Client();
                client.setId(rs.getInt("id"));
                client.setFullname(rs.getString("fullname"));
                client.setEmail(rs.getString("email"));
                client.setCompany(rs.getString("company"));
                client.setSkills(rs.getString("skills"));
                client.setRegDate(rs.getString("reg_date"));
                client.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return client;
    }



    public List<Client> getAllClients() {
        List<Client> list = new ArrayList<>();
        String sql = "SELECT * FROM clients ORDER BY id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Client c = new Client();
                c.setId(rs.getInt("id"));
                c.setFullname(rs.getString("fullname"));
                c.setEmail(rs.getString("email"));
                c.setCompany(rs.getString("company"));
                c.setRegDate(rs.getString("reg_date"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteClientById(int id) {
        boolean result = false;
        String sql = "DELETE FROM clients WHERE id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            result = ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public boolean updatePassword(int clientId, String newPassword) {
        boolean success = false;
        String sql = "UPDATE clients SET password = ? WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, clientId);
            int rows = ps.executeUpdate();
            if (rows == 1) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public int getTotalClients() {
        int count = 0;
        try (Connection conn = DBConnect.getConn();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM clients")) {
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
