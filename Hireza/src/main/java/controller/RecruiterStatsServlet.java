package controller;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/RecruiterStatsServlet")
public class RecruiterStatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = util.DBConnection.getConnection()) {

            // Get interviews by status
            int scheduledInterviews = getInterviewsByStatus(conn, "SCHEDULED");
            int rescheduledInterviews = getInterviewsByStatus(conn, "RESCHEDULED");
            int cancelledInterviews = getInterviewsByStatus(conn, "CANCELLED");
            int completedInterviews = getInterviewsByStatus(conn, "COMPLETED");

            // Calculate approved (scheduled + rescheduled)
            int approvedInterviews = scheduledInterviews + rescheduledInterviews;

            // Pending would be applications that could have interviews (you might need to adjust this logic)
            // For now, using SCHEDULED as pending
            int pendingInterviews = scheduledInterviews;

            // Rejected/Cancelled interviews
            int rejectedInterviews = cancelledInterviews;

            stats.put("success", true);
            stats.put("interviewsApproved", approvedInterviews);
            stats.put("interviewsPending", pendingInterviews);
            stats.put("interviewsRejected", rejectedInterviews);
            stats.put("interviewsCompleted", completedInterviews);

        } catch (SQLException e) {
            e.printStackTrace();
            stats.put("success", false);
            stats.put("error", "Database error: " + e.getMessage());
            stats.put("interviewsApproved", 0);
            stats.put("interviewsPending", 0);
            stats.put("interviewsRejected", 0);
            stats.put("interviewsCompleted", 0);
        }

        // Convert to JSON and send response
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(stats));
        out.flush();
    }

    /**
     * Get count of interviews by status
     * Status can be: SCHEDULED, RESCHEDULED, CANCELLED, COMPLETED
     */
    private int getInterviewsByStatus(Connection conn, String status) throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM Interview WHERE status = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        }
        return 0;
    }

    /**
     * Alternative method: Get all interview stats in one query (more efficient)
     */
    private Map<String, Integer> getAllInterviewStats(Connection conn) throws SQLException {
        Map<String, Integer> statusCounts = new HashMap<>();

        String sql = "SELECT status, COUNT(*) AS count FROM Interview GROUP BY status";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                statusCounts.put(status, count);
            }
        }

        return statusCounts;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}