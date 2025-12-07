package model;

import java.sql.Timestamp;

public class Notification2 {
    private String notificationId;
    private String companyId;
    private String applicationId;
    private String jobId;
    private String message;
    private boolean isRead;
    private Timestamp createdAt;
    private String jobTitle; // For display purposes

    // Full constructor
    public Notification2(String notificationId, String companyId, String applicationId,
                         String jobId, String message, boolean isRead,
                         Timestamp createdAt, String jobTitle) {
        this.notificationId = notificationId;
        this.companyId = companyId;
        this.applicationId = applicationId;
        this.jobId = jobId;
        this.message = message;
        this.isRead = isRead;
        this.createdAt = createdAt;
        this.jobTitle = jobTitle;
    }

    // Constructor without jobTitle
    public Notification2(String notificationId, String companyId, String applicationId,
                         String jobId, String message, boolean isRead, Timestamp createdAt) {
        this(notificationId, companyId, applicationId, jobId, message, isRead, createdAt, "");
    }

    // Getters
    public String getNotificationId() { return notificationId; }
    public String getCompanyId() { return companyId; }
    public String getApplicationId() { return applicationId; }
    public String getJobId() { return jobId; }
    public String getMessage() { return message; }
    public boolean isRead() { return isRead; }
    public boolean getIsRead() { return isRead; } // For JSP compatibility
    public Timestamp getCreatedAt() { return createdAt; }
    public String getJobTitle() { return jobTitle; }

    // Setters
    public void setNotificationId(String notificationId) { this.notificationId = notificationId; }
    public void setCompanyId(String companyId) { this.companyId = companyId; }
    public void setApplicationId(String applicationId) { this.applicationId = applicationId; }
    public void setJobId(String jobId) { this.jobId = jobId; }
    public void setMessage(String message) { this.message = message; }
    public void setRead(boolean read) { isRead = read; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    @Override
    public String toString() {
        return "Notification2{" +
                "notificationId='" + notificationId + '\'' +
                ", companyId='" + companyId + '\'' +
                ", applicationId='" + applicationId + '\'' +
                ", jobId='" + jobId + '\'' +
                ", message='" + message + '\'' +
                ", isRead=" + isRead +
                ", createdAt=" + createdAt +
                ", jobTitle='" + jobTitle + '\'' +
                '}';
    }
}