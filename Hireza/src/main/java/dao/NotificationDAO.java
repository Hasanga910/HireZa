package dao;

import model.Notification;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    public boolean createNotification(Notification notification) {
        String sql = "INSERT INTO Notifications (NotificationID, CompanyID, JobID, UserID, Message, Type, IsRead, CreatedAt, JobTitle, AdminNotes) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String notificationId = generateNextNotificationId();

            stmt.setString(1, notificationId);
            stmt.setString(2, notification.getCompanyId());
            stmt.setString(3, notification.getJobId());

            // Handle null UserID
            if (notification.getUserId() != null && !notification.getUserId().trim().isEmpty()) {
                stmt.setString(4, notification.getUserId());
            } else {
                stmt.setNull(4, Types.VARCHAR);
            }

            stmt.setString(5, notification.getMessage());
            stmt.setString(6, notification.getType());
            stmt.setBoolean(7, notification.getIsRead());
            stmt.setString(8, notification.getJobTitle());
            stmt.setString(9, notification.getAdminNotes());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Error creating notification: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private String generateNextNotificationId() {
        String prefix = "N";
        String sql = "SELECT TOP 1 NotificationID FROM Notifications ORDER BY NotificationID DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("NotificationID"); // e.g., N012
                int num = Integer.parseInt(lastId.substring(1)); // remove 'N' and parse
                num++;
                return String.format("N%03d", num); // e.g., N013
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Default first ID if table is empty
        return "N001";
    }

    public List<Notification> getNotificationsByCompanyId(String companyId) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM Notifications WHERE CompanyID = ? ORDER BY CreatedAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Notification notification = extractNotification(rs);
                notifications.add(notification);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching notifications for company " + companyId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return notifications;
    }

    public int getUnreadNotificationCount(String companyId) {
        String sql = "SELECT COUNT(*) AS count FROM Notifications WHERE CompanyID = ? AND IsRead = 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            System.err.println("Error getting unread notification count for company " + companyId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }


    public boolean markAsRead(String notificationId) {
        String sql = "UPDATE Notifications SET IsRead = 1 WHERE NotificationID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, notificationId);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Successfully marked notification " + notificationId + " as read");
                return true;
            } else {
                System.out.println("No notification found with ID: " + notificationId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error marking notification " + notificationId + " as read: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean markAllAsRead(String companyId) {
        String sql = "UPDATE Notifications SET IsRead = 1 WHERE CompanyID = ? AND IsRead = 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Successfully marked " + rowsUpdated + " notifications as read for company " + companyId);
                return true;
            } else {
                System.out.println("No unread notifications found for company: " + companyId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error marking all notifications as read for company " + companyId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAllNotifications(String companyId) {
        String sql = "DELETE FROM Notifications WHERE CompanyID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Successfully deleted " + rowsDeleted + " notifications for company " + companyId);
                return true;
            } else {
                System.out.println("No notifications found to delete for company: " + companyId);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error deleting all notifications for company " + companyId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private Notification extractNotification(ResultSet rs) throws SQLException {
        Notification notification = new Notification();
        notification.setNotificationId(rs.getString("NotificationID"));
        notification.setCompanyId(rs.getString("CompanyID"));
        notification.setJobId(rs.getString("JobID"));
        notification.setUserId(rs.getString("UserID"));
        notification.setMessage(rs.getString("Message"));
        notification.setType(rs.getString("Type"));
        notification.setIsRead(rs.getBoolean("IsRead"));
        notification.setCreatedAt(rs.getTimestamp("CreatedAt"));
        notification.setJobTitle(rs.getString("JobTitle"));
        notification.setAdminNotes(rs.getString("AdminNotes"));
        return notification;
    }
}