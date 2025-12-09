package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/RecentActivityServlet")
public class RecentActivityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            sendErrorResponse(out, "Unauthorized access");
            return;
        }

        String activityType = request.getParameter("type");
        if (activityType == null || activityType.isEmpty()) {
            activityType = "all";
        }

        try {
            List<Map<String, String>> activities = getRecentActivities(activityType);

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.add("activities", new Gson().toJsonTree(activities));

            out.print(new Gson().toJson(jsonResponse));

        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(out, "Failed to fetch activities: " + e.getMessage());
        }
    }

    private List<Map<String, String>> getRecentActivities(String type) throws SQLException {
        List<Map<String, String>> activities = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            switch (type.toLowerCase()) {
                case "users":
                    activities.addAll(getUserActivities(conn));
                    break;
                case "jobs":
                    activities.addAll(getJobActivities(conn));
                    break;
                case "applications":
                    activities.addAll(getApplicationActivities(conn));
                    break;
                case "system":
                    activities.addAll(getSystemActivities(conn));
                    break;
                case "all":
                default:
                    activities.addAll(getUserActivities(conn));
                    activities.addAll(getJobActivities(conn));
                    activities.addAll(getApplicationActivities(conn));
                    activities.addAll(getSystemActivities(conn));
                    break;
            }

            // Sort by timestamp (newest first)
            activities.sort((a, b) -> {
                try {
                    LocalDateTime timeA = LocalDateTime.parse(a.get("timestamp"),
                            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    LocalDateTime timeB = LocalDateTime.parse(b.get("timestamp"),
                            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                    return timeB.compareTo(timeA);
                } catch (Exception e) {
                    return 0;
                }
            });

            // Limit to 20 most recent activities
            if (activities.size() > 20) {
                activities = activities.subList(0, 20);
            }

            // Convert timestamps to "time ago" format
            for (Map<String, String> activity : activities) {
                String timestamp = activity.get("timestamp");
                activity.put("timeAgo", getTimeAgo(timestamp));
                activity.remove("timestamp");
            }
        }

        return activities;
    }

    private List<Map<String, String>> getUserActivities(Connection conn) throws SQLException {
        List<Map<String, String>> activities = new ArrayList<>();

        String sql = "SELECT TOP 10 userId, fullName, role, createdAt " +
                "FROM Users " +
                "WHERE createdAt >= DATEADD(DAY, -7, GETDATE()) " +
                "AND role != 'Admin' " +
                "ORDER BY createdAt DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, String> activity = new HashMap<>();
                String role = rs.getString("role");
                String fullName = rs.getString("fullName");

                activity.put("title", "New " + formatRole(role) + " Registration");
                activity.put("description", fullName + " joined the platform");
                activity.put("icon", getRoleIcon(role));
                activity.put("iconColor", getRoleColor(role));
                activity.put("timestamp", formatTimestamp(rs.getTimestamp("createdAt")));

                activities.add(activity);
            }
        }

        return activities;
    }

    private List<Map<String, String>> getJobActivities(Connection conn) throws SQLException {
        List<Map<String, String>> activities = new ArrayList<>();

        String sql = "SELECT TOP 10 JobID, CompanyName, JobTitle, Status, CreatedAt, UpdatedAt " +
                "FROM Posts " +
                "WHERE CreatedAt >= DATEADD(DAY, -7, GETDATE()) " +
                "ORDER BY CreatedAt DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, String> activity = new HashMap<>();
                String jobTitle = rs.getString("JobTitle");
                String company = rs.getString("CompanyName");
                String status = rs.getString("Status");

                if ("pending".equalsIgnoreCase(status)) {
                    activity.put("title", "New Job Post Submitted");
                    activity.put("description", company + " posted \"" + jobTitle + "\" for review");
                    activity.put("icon", "fas fa-briefcase");
                    activity.put("iconColor", "orange");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("CreatedAt")));
                } else if ("approved".equalsIgnoreCase(status)) {
                    activity.put("title", "Job Post Approved");
                    activity.put("description", "\"" + jobTitle + "\" at " + company + " is now live");
                    activity.put("icon", "fas fa-check-circle");
                    activity.put("iconColor", "green");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("UpdatedAt")));
                } else if ("rejected".equalsIgnoreCase(status)) {
                    activity.put("title", "Job Post Rejected");
                    activity.put("description", "\"" + jobTitle + "\" at " + company + " needs revision");
                    activity.put("icon", "fas fa-times-circle");
                    activity.put("iconColor", "orange");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("UpdatedAt")));
                }

                activities.add(activity);
            }
        }

        return activities;
    }

    private List<Map<String, String>> getApplicationActivities(Connection conn) throws SQLException {
        List<Map<String, String>> activities = new ArrayList<>();

        String sql = "SELECT TOP 10 ja.applicationId, ja.fullName, ja.status, ja.appliedAt, ja.updatedAt, " +
                "p.JobTitle, p.CompanyName " +
                "FROM JobApplications ja " +
                "INNER JOIN Posts p ON ja.jobId = p.JobID " +
                "WHERE ja.appliedAt >= DATEADD(DAY, -7, GETDATE()) " +
                "ORDER BY ja.appliedAt DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, String> activity = new HashMap<>();
                String applicantName = rs.getString("fullName");
                String jobTitle = rs.getString("JobTitle");
                String company = rs.getString("CompanyName");
                String status = rs.getString("status");

                if ("Pending".equalsIgnoreCase(status)) {
                    activity.put("title", "New Application Received");
                    activity.put("description", applicantName + " applied for " + jobTitle + " at " + company);
                    activity.put("icon", "fas fa-file-alt");
                    activity.put("iconColor", "blue");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("appliedAt")));
                } else if ("Shortlisted".equalsIgnoreCase(status)) {
                    activity.put("title", "Candidate Shortlisted");
                    activity.put("description", applicantName + " shortlisted for " + jobTitle);
                    activity.put("icon", "fas fa-star");
                    activity.put("iconColor", "purple");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("updatedAt")));
                } else if ("Interview".equalsIgnoreCase(status)) {
                    activity.put("title", "Interview Scheduled");
                    activity.put("description", "Interview scheduled for " + applicantName + " - " + jobTitle);
                    activity.put("icon", "fas fa-calendar-check");
                    activity.put("iconColor", "purple");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("updatedAt")));
                } else if ("Hired".equalsIgnoreCase(status)) {
                    activity.put("title", "Candidate Hired");
                    activity.put("description", applicantName + " hired for " + jobTitle + " at " + company);
                    activity.put("icon", "fas fa-user-check");
                    activity.put("iconColor", "green");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("updatedAt")));
                } else if ("Rejected".equalsIgnoreCase(status)) {
                    activity.put("title", "Application Reviewed");
                    activity.put("description", applicantName + "'s application for " + jobTitle + " was reviewed");
                    activity.put("icon", "fas fa-times-circle");
                    activity.put("iconColor", "orange");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("updatedAt")));
                }

                activities.add(activity);
            }
        }

        return activities;
    }

    private List<Map<String, String>> getSystemActivities(Connection conn) throws SQLException {
        List<Map<String, String>> activities = new ArrayList<>();

        try {
            // Track Admin Assistant additions
            String adminAssistantSql = "SELECT TOP 5 fullName, createdAt " +
                    "FROM Users " +
                    "WHERE role = 'AdminAssistant' " +
                    "AND createdAt >= DATEADD(DAY, -7, GETDATE()) " +
                    "ORDER BY createdAt DESC";

            try (PreparedStatement stmt = conn.prepareStatement(adminAssistantSql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Map<String, String> activity = new HashMap<>();
                    activity.put("title", "New Admin Assistant Added");
                    activity.put("description", rs.getString("fullName") + " was added as admin assistant");
                    activity.put("icon", "fas fa-user-shield");
                    activity.put("iconColor", "cyan");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("createdAt")));

                    activities.add(activity);
                }
            }

            // Track Company registrations
            String companySql = "SELECT TOP 5 c.companyName, c.createdAt " +
                    "FROM Company c " +
                    "WHERE c.createdAt >= DATEADD(DAY, -7, GETDATE()) " +
                    "ORDER BY c.createdAt DESC";

            try (PreparedStatement stmt = conn.prepareStatement(companySql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Map<String, String> activity = new HashMap<>();
                    activity.put("title", "Company Profile Created");
                    activity.put("description", rs.getString("companyName") + " completed their company profile");
                    activity.put("icon", "fas fa-building");
                    activity.put("iconColor", "orange");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("createdAt")));

                    activities.add(activity);
                }
            }

            // Track Interview schedules
            String interviewSql = "SELECT TOP 5 i.interviewer, i.scheduledAt, i.createdAt, p.JobTitle " +
                    "FROM Interview i " +
                    "INNER JOIN Posts p ON i.jobId = p.JobID " +
                    "WHERE i.createdAt >= DATEADD(DAY, -7, GETDATE()) " +
                    "ORDER BY i.createdAt DESC";

            try (PreparedStatement stmt = conn.prepareStatement(interviewSql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Map<String, String> activity = new HashMap<>();
                    activity.put("title", "Interview Scheduled");
                    activity.put("description", "Interview scheduled by " + rs.getString("interviewer") +
                            " for " + rs.getString("JobTitle"));
                    activity.put("icon", "fas fa-calendar-alt");
                    activity.put("iconColor", "purple");
                    activity.put("timestamp", formatTimestamp(rs.getTimestamp("createdAt")));

                    activities.add(activity);
                }
            }

        } catch (SQLException e) {
            System.out.println("System activities error: " + e.getMessage());
        }

        return activities;
    }

    private String formatRole(String role) {
        if (role == null) return "User";

        switch (role) {
            case "JobSeeker":
                return "Job Seeker";
            case "JobCounsellor":
                return "Job Counselor";
            case "AdminAssistant":
                return "Admin Assistant";
            case "Employer":
                return "Employer";
            case "Recruiter":
                return "Recruiter";
            default:
                return role;
        }
    }

    private String getRoleIcon(String role) {
        if (role == null) return "fas fa-user";

        switch (role) {
            case "JobSeeker":
                return "fas fa-user";
            case "Employer":
                return "fas fa-building";
            case "Recruiter":
                return "fas fa-user-tie";
            case "JobCounsellor":
                return "fas fa-user-graduate";
            case "AdminAssistant":
                return "fas fa-user-shield";
            default:
                return "fas fa-user";
        }
    }

    private String getRoleColor(String role) {
        if (role == null) return "blue";

        switch (role) {
            case "JobSeeker":
                return "blue";
            case "Employer":
                return "orange";
            case "Recruiter":
                return "purple";
            case "JobCounsellor":
                return "green";
            case "AdminAssistant":
                return "cyan";
            default:
                return "blue";
        }
    }

    private String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) return "";
        return timestamp.toLocalDateTime()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    private String getTimeAgo(String timestamp) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime dateTime = LocalDateTime.parse(timestamp, formatter);
            LocalDateTime now = LocalDateTime.now();

            long minutes = ChronoUnit.MINUTES.between(dateTime, now);
            long hours = ChronoUnit.HOURS.between(dateTime, now);
            long days = ChronoUnit.DAYS.between(dateTime, now);

            if (minutes < 1) {
                return "Just now";
            } else if (minutes < 60) {
                return minutes + " minute" + (minutes > 1 ? "s" : "") + " ago";
            } else if (hours < 24) {
                return hours + " hour" + (hours > 1 ? "s" : "") + " ago";
            } else if (days < 7) {
                return days + " day" + (days > 1 ? "s" : "") + " ago";
            } else {
                return dateTime.format(DateTimeFormatter.ofPattern("MMM dd, yyyy"));
            }
        } catch (Exception e) {
            return timestamp;
        }
    }

    private void sendErrorResponse(PrintWriter out, String message) {
        JsonObject errorResponse = new JsonObject();
        errorResponse.addProperty("success", false);
        errorResponse.addProperty("error", message);
        out.print(new Gson().toJson(errorResponse));
    }
}