package dao;

import model.Recruiter;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecruiterDAO {

    public static int getRecruitersCount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE role = 'Recruiter'";
        int count = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public boolean saveRecruiter(Recruiter recruiter) {
        String sql = "INSERT INTO Recruiter (recruiterId, userId, companyId, position, bio, profileCompleted) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            String newRecruiterId = generateNextRecruiterId(conn);
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newRecruiterId);
                stmt.setString(2, recruiter.getUserId());
                stmt.setString(3, recruiter.getCompanyId());
                stmt.setString(4, recruiter.getPosition());
                stmt.setString(5, recruiter.getBio());
                stmt.setBoolean(6, recruiter.isProfileCompleted());

                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // UPDATED METHOD - CHANGE #1
    public boolean updateRecruiter(Recruiter recruiter) {
        String sql = "UPDATE Recruiter SET position = ?, bio = ?, profileCompleted = ?, profileImage = ?, updatedAt = GETDATE() WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, recruiter.getPosition());
            stmt.setString(2, recruiter.getBio());
            stmt.setBoolean(3, recruiter.isProfileCompleted());
            stmt.setString(4, recruiter.getProfileImage());  // NEW LINE
            stmt.setString(5, recruiter.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // UPDATED METHOD - CHANGE #2
    public Recruiter getRecruiterByUserId(String userId) {
        String sql = "SELECT * FROM Recruiter WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterId(rs.getString("recruiterId"));
                recruiter.setUserId(rs.getString("userId"));
                recruiter.setCompanyId(rs.getString("companyId"));
                recruiter.setPosition(rs.getString("position"));
                recruiter.setBio(rs.getString("bio"));
                recruiter.setProfileCompleted(rs.getBoolean("profileCompleted"));
                recruiter.setProfileImage(rs.getString("profileImage"));  // NEW LINE
                return recruiter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // UPDATED METHOD - CHANGE #3
    public Recruiter getRecruiterById(String recruiterId) {
        String sql = "SELECT * FROM Recruiter WHERE recruiterId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, recruiterId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterId(rs.getString("recruiterId"));
                recruiter.setUserId(rs.getString("userId"));
                recruiter.setCompanyId(rs.getString("companyId"));
                recruiter.setPosition(rs.getString("position"));
                recruiter.setBio(rs.getString("bio"));
                recruiter.setProfileCompleted(rs.getBoolean("profileCompleted"));
                recruiter.setProfileImage(rs.getString("profileImage"));  // NEW LINE
                return recruiter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // UPDATED METHOD - CHANGE #4
    public List<Recruiter> getRecruitersByCompanyId(String companyId) {
        List<Recruiter> recruiters = new ArrayList<>();
        String sql = "SELECT * FROM Recruiter WHERE companyId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterId(rs.getString("recruiterId"));
                recruiter.setUserId(rs.getString("userId"));
                recruiter.setCompanyId(rs.getString("companyId"));
                recruiter.setPosition(rs.getString("position"));
                recruiter.setBio(rs.getString("bio"));
                recruiter.setProfileCompleted(rs.getBoolean("profileCompleted"));
                recruiter.setProfileImage(rs.getString("profileImage"));  // NEW LINE
                recruiters.add(recruiter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return recruiters;
    }

    public boolean isRecruiterProfileCompleted(String userId) {
        String sql = "SELECT profileCompleted FROM Recruiter WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("profileCompleted");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private String generateNextRecruiterId(Connection conn) throws SQLException {
        String sql = "SELECT TOP 1 recruiterId FROM Recruiter ORDER BY recruiterId DESC";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("recruiterId");
                int num = Integer.parseInt(lastId.substring(1));
                return String.format("R%03d", num + 1);
            }
        }
        return "R001";
    }

    public boolean deleteRecruiterByUserId(String userId) {
        String sql = "DELETE FROM Recruiter WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("✅ Recruiter record deleted for userId: " + userId);
                return true;
            } else {
                System.err.println("⚠️ No recruiter record found for userId: " + userId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error deleting recruiter: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRecruiterById(String recruiterId) {
        String sql = "DELETE FROM Recruiter WHERE recruiterId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, recruiterId);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("✅ Recruiter record deleted for recruiterId: " + recruiterId);
                return true;
            } else {
                System.err.println("⚠️ No recruiter record found for recruiterId: " + recruiterId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("❌ Error deleting recruiter: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}