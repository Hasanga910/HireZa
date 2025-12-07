package dao;

import model.Notification2;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobNotificationDAO {

    // 🔹 Generate notification ID
    private String generateNotificationId() {
        String sql = "SELECT TOP 1 notificationId FROM JobNotifications ORDER BY notificationId DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                String lastId = rs.getString("notificationId");
                int num = Integer.parseInt(lastId.substring(1)) + 1;
                return String.format("N%09d", num);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "N000000001"; // First notification
    }

    // 🔹 Add new notification (FIXED to match JobNotifications table schema)
    public boolean addNotification(String companyId, String applicationId, String jobId, String message) {
        String notificationId = generateNotificationId();
        String sql = "INSERT INTO JobNotifications (notificationId, companyId, applicationId, jobId, message, isRead, createdAt) " +
                "VALUES (?, ?, ?, ?, ?, 0, GETDATE())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, notificationId);
            stmt.setString(2, companyId);
            stmt.setString(3, applicationId);
            stmt.setString(4, jobId);
            stmt.setString(5, message);

            int rowsAffected = stmt.executeUpdate();
            System.out.println(" Notification insert - Rows affected: " + rowsAffected);
            System.out.println(" Notification ID: " + notificationId + ", Company: " + companyId + ", Application: " + applicationId);
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println(" SQL Error in addNotification: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // 🔹 Get all notifications for a company
    public List<Notification2> getNotificationsByCompanyId(String companyId) {
        List<Notification2> notifications = new ArrayList<>();
        String sql = "SELECT jn.*, p.JobTitle " +
                "FROM JobNotifications jn " +
                "LEFT JOIN Posts p ON jn.jobId = p.JobID " +
                "WHERE jn.companyId = ? " +
                "ORDER BY jn.createdAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Notification2 n = new Notification2(
                        rs.getString("notificationId"),
                        rs.getString("companyId"),
                        rs.getString("applicationId"),
                        rs.getString("jobId"),
                        rs.getString("message"),
                        rs.getBoolean("isRead"),
                        rs.getTimestamp("createdAt"),
                        rs.getString("JobTitle")
                );
                notifications.add(n);
            }

        } catch (SQLException e) {
            System.err.println(" Error fetching notifications: " + e.getMessage());
            e.printStackTrace();
        }
        return notifications;
    }

    // 🔹 Count unread notifications
    public int getUnreadNotificationsCount(String companyId) {
        String sql = "SELECT COUNT(*) FROM JobNotifications WHERE companyId = ? AND isRead = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 🔹 Mark single notification as read
    public boolean markAsRead(String notificationId) {
        String sql = "UPDATE JobNotifications SET isRead = 1 WHERE notificationId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, notificationId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 Mark all as read for a company
    public boolean markAllAsRead(String companyId) {
        String sql = "UPDATE JobNotifications SET isRead = 1 WHERE companyId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 Delete all notifications for a company
    public boolean deleteAllNotifications(String companyId) {
        String sql = "DELETE FROM JobNotifications WHERE companyId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Add this method to your JobApplicationDAO class

    /**
     * Inserts a new job application and returns the generated applicationId
     */
    public String insertAndReturnId(String jobId, String seekerId, String fullName,
                                    String email, String phone, String coverLetter,
                                    String resumePath) {
        String applicationId = generateApplicationId(); // Your existing ID generation method

        String sql = "INSERT INTO JobApplications (applicationId, JobID, SeekerId, FullName, Email, Phone, CoverLetter, ResumePath, Status, AppliedDate) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending', GETDATE())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, applicationId);
            stmt.setString(2, jobId);
            stmt.setString(3, seekerId);
            stmt.setString(4, fullName);
            stmt.setString(5, email);
            stmt.setString(6, phone);
            stmt.setString(7, coverLetter);
            stmt.setString(8, resumePath);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println(" Application inserted with ID: " + applicationId);
                return applicationId; // Return the generated ID
            } else {
                System.err.println(" Failed to insert application");
                return null;
            }

        } catch (SQLException e) {
            System.err.println(" SQL Error in insertAndReturnId: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // If you don't have this method, here's a simple ID generator:
    private String generateApplicationId() {
        String sql = "SELECT TOP 1 applicationId FROM JobApplications ORDER BY applicationId DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                String lastId = rs.getString("applicationId");
                // Assuming format like "APP000001"
                int num = Integer.parseInt(lastId.substring(3)) + 1;
                return String.format("APP%06d", num);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "APP000001"; // First application
    }

    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE notifications SET is_read = TRUE WHERE notification_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, notificationId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteNotification(String notificationId) {
        String sql = "DELETE FROM JobNotifications WHERE notificationId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, notificationId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Add this method to your JobNotificationDAO class

    /**
     * Marks all notifications as read for a specific company
     * @param companyId The company ID
     * @return true if successful, false otherwise
     */
    public boolean markAllAsReadByCompanyId(String companyId) {
        String sql = "UPDATE JobNotifications SET isRead = 1 WHERE companyId = ? AND isRead = 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            System.out.println("=== JobNotificationDAO.markAllAsReadByCompanyId ===");
            System.out.println("CompanyId: " + companyId);

            stmt.setString(1, companyId);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

            return true; // Return true even if no rows affected (means all already read)

        } catch (SQLException e) {
            System.err.println("Error marking all notifications as read: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}