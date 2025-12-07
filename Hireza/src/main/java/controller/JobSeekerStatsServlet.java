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

@WebServlet("/JobSeekerStatsServlet")
public class JobSeekerStatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = util.DBConnection.getConnection()) {

            // Get total applications submitted by all job seekers
            int totalApplications = getTotalApplications(conn);

            // Get number of job seekers with completed profiles
            int profilesCompleted = getCompletedProfiles(conn);

            stats.put("success", true);
            stats.put("totalApplications", totalApplications);
            stats.put("profilesCompleted", profilesCompleted);

        } catch (SQLException e) {
            e.printStackTrace();
            stats.put("success", false);
            stats.put("error", "Database error: " + e.getMessage());
            stats.put("totalApplications", 0);
            stats.put("profilesCompleted", 0);
        }

        // Convert to JSON and send response
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(stats));
        out.flush();
    }

    /**
     * Get total number of applications submitted by all job seekers
     */
    private int getTotalApplications(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM JobApplications";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    /**
     * Get number of job seekers who have completed their profiles
     * A profile is considered completed if it has:
     * - title
     * - location
     * - about
     * - skills
     */
    private int getCompletedProfiles(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) AS total " +
                "FROM JobSeekerProfile " +
                "WHERE title IS NOT NULL AND title != '' " +
                "AND location IS NOT NULL AND location != '' " +
                "AND about IS NOT NULL AND about != '' " +
                "AND skills IS NOT NULL AND skills != ''";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}