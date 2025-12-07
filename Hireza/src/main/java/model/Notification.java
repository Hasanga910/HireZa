package model;

import java.util.Date;

public class Notification {
    private String notificationId;
    private String companyId;
    private String jobId;
    private String userId;
    private String message;
    private String type; // "approved", "rejected", "info", "interview", "application"
    private boolean isRead;
    private Date createdAt;
    private String jobTitle;
    private String adminNotes;

    public Notification() {}

    public Notification(String companyId, String jobId, String userId, String message,
                        String type, String jobTitle, String adminNotes) {
        this.companyId = companyId;
        this.jobId = jobId;
        this.userId = userId;  // This line is crucial
        this.message = message;
        this.type = type;
        this.jobTitle = jobTitle;
        this.adminNotes = adminNotes;
        this.isRead = false;
        this.createdAt = new Date();
    }

    // Getters and Setters
    public String getNotificationId() { return notificationId; }
    public void setNotificationId(String notificationId) { this.notificationId = notificationId; }

    public String getCompanyId() { return companyId; }
    public void setCompanyId(String companyId) { this.companyId = companyId; }

    public String getJobId() { return jobId; }
    public void setJobId(String jobId) { this.jobId = jobId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public boolean getIsRead() { return isRead; }
    public void setIsRead(boolean isRead) { this.isRead = isRead; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getAdminNotes() { return adminNotes; }
    public void setAdminNotes(String adminNotes) { this.adminNotes = adminNotes; }

    @Override
    public String toString() {
        return "Notification{" +
                "notificationId='" + notificationId + '\'' +
                ", companyId='" + companyId + '\'' +
                ", jobId='" + jobId + '\'' +
                ", userId='" + userId + '\'' +
                ", message='" + message + '\'' +
                ", type='" + type + '\'' +
                ", isRead=" + isRead +
                ", createdAt=" + createdAt +
                ", jobTitle='" + jobTitle + '\'' +
                ", adminNotes='" + adminNotes + '\'' +
                '}';
    }
}