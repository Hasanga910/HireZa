package controller;

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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Unified Servlet to fetch job post statistics
 * Handles both Employer and Admin Assistant statistics based on request type
 */
@WebServlet("/JobPostStatsServlet")
public class JobPostStatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        // Get the type parameter to determine which stats to fetch
        String type = request.getParameter("type");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", "User not logged in");
            out.print(jsonResponse.toString());
            return;
        }

        model.User user = (model.User) session.getAttribute("user");
        String userRole = user.getRole();

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();

            // Determine which statistics to fetch based on type parameter
            if ("employer".equalsIgnoreCase(type)) {
                // Admin viewing employer stats - show aggregate for ALL employers
                if ("Admin".equalsIgnoreCase(userRole) || "AdminAssistant".equalsIgnoreCase(userRole)) {
                    fetchAllEmployersStats(conn, jsonResponse);
                } else if ("Employer".equalsIgnoreCase(userRole)) {
                    // Actual employer viewing their own stats
                    fetchEmployerStats(conn, user, jsonResponse);
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("error", "Unauthorized access");
                }
            } else if ("assistant".equalsIgnoreCase(type)) {
                fetchAssistantStats(conn, jsonResponse);
            } else if ("Admin".equalsIgnoreCase(userRole)) {
                // Admin can view both, default to assistant stats
                fetchAssistantStats(conn, jsonResponse);
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("error", "Invalid request type or unauthorized access");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", "Error fetching job post statistics: " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        out.print(jsonResponse.toString());
        out.flush();
    }

    /**
     * Fetch statistics for a specific Employer
     * Returns: Active Job Posts and Total Job Posts for specific employer
     */
    private void fetchEmployerStats(Connection conn, model.User user, JsonObject jsonResponse) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String companyId = user.getId();

            // Query 1: Get Active Job Posts (approved status)
            String activeQuery = "SELECT COUNT(*) AS activeCount FROM Posts " +
                    "WHERE CompanyID = ? AND Status = 'approved'";
            pstmt = conn.prepareStatement(activeQuery);
            pstmt.setString(1, companyId);
            rs = pstmt.executeQuery();

            int activePosts = 0;
            if (rs.next()) {
                activePosts = rs.getInt("activeCount");
            }
            rs.close();
            pstmt.close();

            // Query 2: Get Total Job Posts (all statuses)
            String totalQuery = "SELECT COUNT(*) AS totalCount FROM Posts WHERE CompanyID = ?";
            pstmt = conn.prepareStatement(totalQuery);
            pstmt.setString(1, companyId);
            rs = pstmt.executeQuery();

            int totalPosts = 0;
            if (rs.next()) {
                totalPosts = rs.getInt("totalCount");
            }

            // Build JSON response
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("type", "employer");
            jsonResponse.addProperty("activePosts", activePosts);
            jsonResponse.addProperty("totalPosts", totalPosts);

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", "Error fetching employer statistics: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Fetch aggregate statistics for ALL Employers (used by Admin)
     * Returns: Total Active Job Posts and Total Job Posts across all employers
     */
    private void fetchAllEmployersStats(Connection conn, JsonObject jsonResponse) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Query 1: Get All Active Job Posts (approved status)
            String activeQuery = "SELECT COUNT(*) AS activeCount FROM Posts WHERE Status = 'approved'";
            pstmt = conn.prepareStatement(activeQuery);
            rs = pstmt.executeQuery();

            int activePosts = 0;
            if (rs.next()) {
                activePosts = rs.getInt("activeCount");
            }
            rs.close();
            pstmt.close();

            // Query 2: Get Total Job Posts (all statuses)
            String totalQuery = "SELECT COUNT(*) AS totalCount FROM Posts";
            pstmt = conn.prepareStatement(totalQuery);
            rs = pstmt.executeQuery();

            int totalPosts = 0;
            if (rs.next()) {
                totalPosts = rs.getInt("totalCount");
            }

            // Build JSON response
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("type", "employer");
            jsonResponse.addProperty("activePosts", activePosts);
            jsonResponse.addProperty("totalPosts", totalPosts);

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", "Error fetching all employers statistics: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Fetch statistics for Admin Assistants
     * Returns: Job Posts Approved, Pending, and Rejected (system-wide)
     */
    private void fetchAssistantStats(Connection conn, JsonObject jsonResponse) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Query 1: Get Approved Job Posts
            String approvedQuery = "SELECT COUNT(*) AS approvedCount FROM Posts WHERE Status = 'approved'";
            pstmt = conn.prepareStatement(approvedQuery);
            rs = pstmt.executeQuery();

            int approvedPosts = 0;
            if (rs.next()) {
                approvedPosts = rs.getInt("approvedCount");
            }
            rs.close();
            pstmt.close();

            // Query 2: Get Pending Job Posts
            String pendingQuery = "SELECT COUNT(*) AS pendingCount FROM Posts WHERE Status = 'pending'";
            pstmt = conn.prepareStatement(pendingQuery);
            rs = pstmt.executeQuery();

            int pendingPosts = 0;
            if (rs.next()) {
                pendingPosts = rs.getInt("pendingCount");
            }
            rs.close();
            pstmt.close();

            // Query 3: Get Rejected Job Posts
            String rejectedQuery = "SELECT COUNT(*) AS rejectedCount FROM Posts WHERE Status = 'rejected'";
            pstmt = conn.prepareStatement(rejectedQuery);
            rs = pstmt.executeQuery();

            int rejectedPosts = 0;
            if (rs.next()) {
                rejectedPosts = rs.getInt("rejectedCount");
            }

            // Build JSON response
            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("type", "assistant");
            jsonResponse.addProperty("approvedPosts", approvedPosts);
            jsonResponse.addProperty("pendingPosts", pendingPosts);
            jsonResponse.addProperty("rejectedPosts", rejectedPosts);

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", "Error fetching assistant statistics: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}