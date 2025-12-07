package dao;

import model.RecruiterActivityLog;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecruiterActivityDAO {

    public List<RecruiterActivityLog> getActivitiesByCompanyId(String companyId) {
        List<RecruiterActivityLog> activities = new ArrayList<>();
        String sql = "SELECT ral.* FROM RecruiterActivityLog ral " +
                "JOIN Recruiter r ON ral.recruiterId = r.recruiterId " +
                "WHERE r.companyId = ? ORDER BY ral.actionDate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                RecruiterActivityLog activity = new RecruiterActivityLog();
                activity.setLogId(rs.getString("logId"));
                activity.setRecruiterId(rs.getString("recruiterId"));
                activity.setApplicationId(rs.getString("applicationId"));
                activity.setAction(rs.getString("action"));
                activity.setActionDate(rs.getTimestamp("actionDate"));
                activities.add(activity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }

    // NEW: Save a new recruiter activity log
    public boolean saveActivity(String recruiterId, String applicationId, String action) {
        String sql = "INSERT INTO RecruiterActivityLog (logId, recruiterId, applicationId, action, actionDate) " +
                "VALUES (?, ?, ?, ?, GETDATE())";

        try (Connection conn = DBConnection.getConnection()) {
            // Generate next logId (e.g., L001, L002)
            String newLogId = generateNextLogId(conn);

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newLogId);
                stmt.setString(2, recruiterId);
                stmt.setString(3, applicationId);
                stmt.setString(4, action);

                int rowsInserted = stmt.executeUpdate();
                return rowsInserted > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // NEW: Generate next logId in format L001, L002, etc.
    private String generateNextLogId(Connection conn) throws SQLException {
        String prefix = "L";
        String sql = "SELECT TOP 1 logId FROM RecruiterActivityLog ORDER BY logId DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("logId");
                int num = Integer.parseInt(lastId.substring(1));
                num++;
                return String.format("%s%03d", prefix, num);
            }
        }
        return prefix + "001";
    }
}