package model;

import java.util.Date;

public class RecruiterActivityLog {
    private String logId;
    private String recruiterId;
    private String applicationId;
    private String action;
    private Date actionDate;

    public String getLogId() { return logId; }
    public void setLogId(String logId) { this.logId = logId; }

    public String getRecruiterId() { return recruiterId; }
    public void setRecruiterId(String recruiterId) { this.recruiterId = recruiterId; }

    public String getApplicationId() { return applicationId; }
    public void setApplicationId(String applicationId) { this.applicationId = applicationId; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public Date getActionDate() { return actionDate; }
    public void setActionDate(Date actionDate) { this.actionDate = actionDate; }
}