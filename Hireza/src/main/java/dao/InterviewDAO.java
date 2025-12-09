//package dao;
//
//import model.Interview;
//import util.DBConnection;
//
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class InterviewDAO {
//
//    // Save a new interview
//    public boolean saveInterview(Interview interview) {
//        String sql = "INSERT INTO Interview (applicationId, companyId, userId, jobId, interviewer, location, mode, scheduledAt, durationMinutes, notes, status) " +
//                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setString(1, interview.getApplicationId());
//            stmt.setString(2, interview.getCompanyId());
//            stmt.setString(3, interview.getUserId());
//            stmt.setString(4, interview.getJobId());
//            stmt.setString(5, interview.getInterviewer());
//            stmt.setString(6, interview.getLocation());
//            stmt.setString(7, interview.getMode());
//            stmt.setTimestamp(8, Timestamp.valueOf(interview.getScheduledAt()));
//            stmt.setInt(9, interview.getDurationMinutes());
//            stmt.setString(10, interview.getNotes());
//            stmt.setString(11, interview.getStatus());
//            return stmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    // Update an existing interview
//    public boolean updateInterview(Interview interview) {
//        String sql = "UPDATE Interview SET interviewer = ?, location = ?, mode = ?, scheduledAt = ?, durationMinutes = ?, notes = ?, status = ?, updatedAt = GETDATE() " +
//                "WHERE interviewId = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setString(1, interview.getInterviewer());
//            stmt.setString(2, interview.getLocation());
//            stmt.setString(3, interview.getMode());
//            stmt.setTimestamp(4, Timestamp.valueOf(interview.getScheduledAt()));
//            stmt.setInt(5, interview.getDurationMinutes());
//            stmt.setString(6, interview.getNotes());
//            stmt.setString(7, interview.getStatus());
//            stmt.setString(8, interview.getInterviewId());
//            return stmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    // Get interview by ID
//    public Interview getInterviewById(int interviewId) {
//        String sql = "SELECT * FROM Interview WHERE interviewId = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, interviewId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                Interview interview = new Interview();
//                interview.setInterviewId(rs.getString("interviewId"));
//                interview.setApplicationId(rs.getString("applicationId"));
//                interview.setCompanyId(rs.getString("companyId"));
//                interview.setUserId(rs.getString("userId"));
//                interview.setJobId(rs.getString("jobId"));
//                interview.setInterviewer(rs.getString("interviewer"));
//                interview.setLocation(rs.getString("location"));
//                interview.setMode(rs.getString("mode"));
//                interview.setScheduledAt(rs.getTimestamp("scheduledAt").toLocalDateTime());
//                interview.setDurationMinutes(rs.getInt("durationMinutes"));
//                interview.setNotes(rs.getString("notes"));
//                interview.setStatus(rs.getString("status"));
//                interview.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
//                interview.setUpdatedAt(rs.getTimestamp("updatedAt").toLocalDateTime());
//                return interview;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    // Get interviews by company ID
//    public List<Interview> getInterviewsByCompanyId(String companyId) {
//        List<Interview> interviews = new ArrayList<>();
//        String sql = "SELECT * FROM Interview WHERE companyId = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setString(1, companyId);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                Interview interview = new Interview();
//                interview.setInterviewId(rs.getString("interviewId"));
//                interview.setApplicationId(rs.getString("applicationId"));
//                interview.setCompanyId(rs.getString("companyId"));
//                interview.setUserId(rs.getString("userId"));
//                interview.setJobId(rs.getString("jobId"));
//                interview.setInterviewer(rs.getString("interviewer"));
//                interview.setLocation(rs.getString("location"));
//                interview.setMode(rs.getString("mode"));
//                interview.setScheduledAt(rs.getTimestamp("scheduledAt").toLocalDateTime());
//                interview.setDurationMinutes(rs.getInt("durationMinutes"));
//                interview.setNotes(rs.getString("notes"));
//                interview.setStatus(rs.getString("status"));
//                interview.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
//                interview.setUpdatedAt(rs.getTimestamp("updatedAt").toLocalDateTime());
//                interviews.add(interview);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return interviews;
//    }
//
//    // Delete an interview
//    public boolean deleteInterview(int interviewId) {
//        String sql = "DELETE FROM Interview WHERE interviewId = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, interviewId);
//            return stmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//}

package dao;

import model.Interview;
import util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class InterviewDAO {

    /**
     * Saves a new interview to the database
     */
    public boolean saveInterview(Interview interview) {
        String sql = "INSERT INTO Interview (interviewId, applicationId, companyId, userId, jobId, " +
                "interviewer, location, mode, scheduledAt, durationMinutes, notes, status, createdAt, updatedAt) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";

        try (Connection conn = DBConnection.getConnection()) {
            // Generate new interview ID
            String newInterviewId = generateNextInterviewId(conn);

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newInterviewId);
                stmt.setString(2, interview.getApplicationId());
                stmt.setString(3, interview.getCompanyId());
                stmt.setString(4, interview.getUserId());
                stmt.setString(5, interview.getJobId());
                stmt.setString(6, interview.getInterviewer());
                stmt.setString(7, interview.getLocation());
                stmt.setString(8, interview.getMode());
                stmt.setObject(9, interview.getScheduledAt());
                stmt.setInt(10, interview.getDurationMinutes());
                stmt.setString(11, interview.getNotes());
                stmt.setString(12, interview.getStatus());

                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                    System.out.println("✅ Interview saved successfully with ID: " + newInterviewId);
                    return true;
                } else {
                    System.err.println("❌ No rows inserted for interview");
                    return false;
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error saving interview: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Generates the next interview ID (I001, I002, etc.)
     */
    private String generateNextInterviewId(Connection conn) throws SQLException {
        String sql = "SELECT TOP 1 interviewId FROM Interview ORDER BY interviewId DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("interviewId");
                int num = Integer.parseInt(lastId.substring(1)); // Remove 'I' prefix
                return String.format("I%03d", num + 1);
            }
        }
        return "I001"; // First interview ID
    }

    /**
     * Gets interview by ID
     */
    public Interview getInterviewById(String interviewId) {
        String sql = "SELECT * FROM Interview WHERE interviewId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, interviewId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToInterview(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting interview by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Gets all interviews for an application
     */
    public List<Interview> getInterviewsByApplicationId(String applicationId) {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM Interview WHERE applicationId = ? ORDER BY scheduledAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, applicationId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                interviews.add(mapResultSetToInterview(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting interviews by application: " + e.getMessage());
            e.printStackTrace();
        }
        return interviews;
    }

    /**
     * Gets all interviews for a company
     */
    public List<Interview> getInterviewsByCompanyId(String companyId) {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM Interview WHERE companyId = ? ORDER BY scheduledAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                interviews.add(mapResultSetToInterview(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting interviews by company: " + e.getMessage());
            e.printStackTrace();
        }
        return interviews;
    }

    /**
     * Updates interview status
     */
    public boolean updateInterviewStatus(String interviewId, String newStatus) {
        String sql = "UPDATE Interview SET status = ?, updatedAt = GETDATE() WHERE interviewId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setString(2, interviewId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating interview status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes an interview
     */
    public boolean deleteInterview(String interviewId) {
        String sql = "DELETE FROM Interview WHERE interviewId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, interviewId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting interview: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Maps ResultSet to Interview object
     */
    private Interview mapResultSetToInterview(ResultSet rs) throws SQLException {
        Interview interview = new Interview();
        interview.setInterviewId(rs.getString("interviewId"));
        interview.setApplicationId(rs.getString("applicationId"));
        interview.setCompanyId(rs.getString("companyId"));
        interview.setUserId(rs.getString("userId"));
        interview.setJobId(rs.getString("jobId"));
        interview.setInterviewer(rs.getString("interviewer"));
        interview.setLocation(rs.getString("location"));
        interview.setMode(rs.getString("mode"));

        // Handle LocalDateTime conversion
        Timestamp scheduledAt = rs.getTimestamp("scheduledAt");
        if (scheduledAt != null) {
            interview.setScheduledAt(scheduledAt.toLocalDateTime());
        }

        interview.setDurationMinutes(rs.getInt("durationMinutes"));
        interview.setNotes(rs.getString("notes"));
        interview.setStatus(rs.getString("status"));

        Timestamp createdAt = rs.getTimestamp("createdAt");
        if (createdAt != null) {
            interview.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updatedAt");
        if (updatedAt != null) {
            interview.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return interview;
    }

    public boolean updateInterview(Interview interview) {
        String sql = "UPDATE Interview SET interviewer = ?, location = ?, mode = ?, scheduledAt = ?, durationMinutes = ?, notes = ?, status = ?, updatedAt = GETDATE() " +
                "WHERE interviewId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, interview.getInterviewer());
            stmt.setString(2, interview.getLocation());
            stmt.setString(3, interview.getMode());
            stmt.setTimestamp(4, Timestamp.valueOf(interview.getScheduledAt()));
            stmt.setInt(5, interview.getDurationMinutes());
            stmt.setString(6, interview.getNotes());
            stmt.setString(7, interview.getStatus());
            stmt.setString(8, interview.getInterviewId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}