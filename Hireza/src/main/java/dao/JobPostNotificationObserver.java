package dao;

import model.JobPost;
import model.Notification;
import model.NotificationObserver;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class JobPostNotificationObserver implements NotificationObserver {
    private NotificationDAO notificationDAO;
    private static final Logger logger = Logger.getLogger(JobPostNotificationObserver.class.getName());

    public JobPostNotificationObserver() {
        this.notificationDAO = new NotificationDAO();
    }

    @Override
    public void update(JobPost jobPost, String action) {
        String message = "";
        String type = "";

        switch (action.toLowerCase()) {
            case "approved":
                message = "Your job post '" + jobPost.getJobTitle() + "' has been approved and is now live on the platform.";
                type = "approved";
                break;
            case "rejected":
                message = "Your job post '" + jobPost.getJobTitle() + "' has been rejected. Please review the admin notes.";
                type = "rejected";
                break;
            case "pending":
                message = "Your job post '" + jobPost.getJobTitle() + "' is under review by our admin team.";
                type = "info";
                break;
            default:
                message = "Status of your job post '" + jobPost.getJobTitle() + "' has been updated to: " + action;
                type = "info";
                break;
        }

        // Convert all parameters to String to ensure data type compatibility
        String companyId = String.valueOf(jobPost.getCompanyId());
        String jobId = String.valueOf(jobPost.getJobId());
        String jobTitle = String.valueOf(jobPost.getJobTitle());
        String adminNotes = jobPost.getAdminNotes() != null ? String.valueOf(jobPost.getAdminNotes()) : "";

        // Get userId from database
        String userId = getUserIdForCompany(companyId);

        if (userId == null) {
            logger.warning("Could not find userId for company " + companyId + ". Notification will be created without userId.");
        }

        // Create notification with ALL parameters including userId
        Notification notification = new Notification(
                companyId,
                jobId,
                userId,  // userId fetched from database
                message,
                type,
                jobTitle,
                adminNotes
        );

        // Save to database
        boolean success = notificationDAO.createNotification(notification);

        if (success) {
            logger.info("Notification created successfully: " + message);
            System.out.println("Notification created: " + message);
        } else {
            logger.warning("Failed to create notification: " + message);
            System.err.println("Failed to create notification: " + message);
        }
    }

    private String getUserIdForCompany(String companyId) {
        String sql = "SELECT UserID FROM Company WHERE CompanyID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String userId = rs.getString("UserID");
                logger.info("Found userId: " + userId + " for company: " + companyId);
                return userId;
            } else {
                logger.warning("No userId found for company: " + companyId);
                return null;
            }

        } catch (SQLException e) {
            logger.severe("Error getting userId for company " + companyId + ": " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}