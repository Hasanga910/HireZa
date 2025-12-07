package controller;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/SystemLogsServlet")
public class SystemLogsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String month = request.getParameter("month");
        if (month == null || month.isEmpty()) {
            YearMonth currentMonth = YearMonth.now();
            month = currentMonth.toString();
        }

        Map<String, Object> result = new HashMap<>();

        try (Connection conn = util.DBConnection.getConnection()) {

            // Parse the selected month
            String[] parts = month.split("-");
            int year = Integer.parseInt(parts[0]);
            int monthNum = Integer.parseInt(parts[1]);
            LocalDate firstDay = LocalDate.of(year, monthNum, 1);
            LocalDate lastDay = firstDay.withDayOfMonth(firstDay.lengthOfMonth());

            // Get current month stats (based on selected month)
            Map<String, Object> currentStats = getMonthStats(conn, firstDay, lastDay);

            // Get previous month stats for comparison
            LocalDate prevFirstDay = firstDay.minusMonths(1);
            LocalDate prevLastDay = prevFirstDay.withDayOfMonth(prevFirstDay.lengthOfMonth());
            Map<String, Object> previousStats = getMonthStats(conn, prevFirstDay, prevLastDay);

            // Calculate percentage changes
            Map<String, Object> statsWithChanges = calculateChanges(currentStats, previousStats);

            // Get top company by applications (for selected month)
            Map<String, Object> topCompany = getTopCompany(conn, firstDay, lastDay);

            // Get weekly data for chart
            List<Map<String, Object>> weeklyData = getWeeklyData(conn, firstDay, lastDay);

            // Get top 5 companies ranking
            List<Map<String, Object>> topCompanies = getTopCompaniesRanking(conn, firstDay, lastDay);

            result.put("success", true);
            result.put("stats", statsWithChanges);
            result.put("topCompany", topCompany);
            result.put("weeklyData", weeklyData);
            result.put("topCompanies", topCompanies);

        } catch (SQLException e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("error", "Error: " + e.getMessage());
        }

        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(result));
        out.flush();
    }

    /**
     * Get statistics for a given month range
     */
    private Map<String, Object> getMonthStats(Connection conn, LocalDate startDate, LocalDate endDate)
            throws SQLException {
        Map<String, Object> stats = new HashMap<>();

        // Jobs Posted
        String jobsSql = "SELECT COUNT(*) AS total FROM Posts " +
                "WHERE CONVERT(DATE, CreatedAt) >= ? AND CONVERT(DATE, CreatedAt) <= ?";
        int jobsPosted = executeCountQuery(conn, jobsSql, startDate, endDate);

        // Applications Received
        String appsSql = "SELECT COUNT(*) AS total FROM JobApplications " +
                "WHERE CONVERT(DATE, appliedAt) >= ? AND CONVERT(DATE, appliedAt) <= ?";
        int applications = executeCountQuery(conn, appsSql, startDate, endDate);

        // People Hired - FIXED: Now checking Interview table with status 'completed'
        String hiredSql = "SELECT COUNT(*) AS total FROM Interview " +
                "WHERE CONVERT(DATE, updatedAt) >= ? AND CONVERT(DATE, updatedAt) <= ? " +
                "AND LOWER(status) = 'completed'";
        int hired = executeCountQuery(conn, hiredSql, startDate, endDate);

        stats.put("jobsPosted", jobsPosted);
        stats.put("applications", applications);
        stats.put("hired", hired);

        return stats;
    }

    /**
     * Calculate percentage changes between current and previous month
     */
    private Map<String, Object> calculateChanges(Map<String, Object> current, Map<String, Object> previous) {
        Map<String, Object> result = new HashMap<>(current);

        int currJobs = (int) current.get("jobsPosted");
        int prevJobs = (int) previous.get("jobsPosted");
        double jobsChange = calculatePercentageChange(currJobs, prevJobs);

        int currApps = (int) current.get("applications");
        int prevApps = (int) previous.get("applications");
        double appsChange = calculatePercentageChange(currApps, prevApps);

        int currHired = (int) current.get("hired");
        int prevHired = (int) previous.get("hired");
        double hiredChange = calculatePercentageChange(currHired, prevHired);

        result.put("jobsPostedChange", jobsChange);
        result.put("applicationsChange", appsChange);
        result.put("hiredChange", hiredChange);

        return result;
    }

    /**
     * Calculate percentage change
     */
    private double calculatePercentageChange(int current, int previous) {
        if (previous == 0) {
            return current > 0 ? 100.0 : 0.0;
        }
        return ((double) (current - previous) / previous) * 100.0;
    }

    /**
     * Get top company by applications for the selected month
     */
    private Map<String, Object> getTopCompany(Connection conn, LocalDate startDate, LocalDate endDate)
            throws SQLException {
        Map<String, Object> topCompany = new HashMap<>();

        String sql = "SELECT TOP 1 c.companyName, COUNT(ja.applicationId) AS applicationCount " +
                "FROM Company c " +
                "INNER JOIN Posts p ON c.companyId = p.CompanyID " +
                "INNER JOIN JobApplications ja ON p.JobID = ja.jobId " +
                "WHERE CONVERT(DATE, ja.appliedAt) >= ? AND CONVERT(DATE, ja.appliedAt) <= ? " +
                "GROUP BY c.companyName " +
                "ORDER BY applicationCount DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, Date.valueOf(startDate));
            pstmt.setDate(2, Date.valueOf(endDate));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    topCompany.put("name", rs.getString("companyName"));
                    topCompany.put("applications", rs.getInt("applicationCount"));
                } else {
                    topCompany.put("name", "No Data");
                    topCompany.put("applications", 0);
                }
            }
        }

        return topCompany;
    }

    /**
     * Get weekly data for charts (4 weeks of selected month)
     */
    private List<Map<String, Object>> getWeeklyData(Connection conn, LocalDate firstDay, LocalDate lastDay)
            throws SQLException {
        List<Map<String, Object>> weeklyData = new ArrayList<>();

        int daysInMonth = firstDay.lengthOfMonth();
        int daysPerWeek = daysInMonth / 4;

        for (int week = 0; week < 4; week++) {
            LocalDate weekStart = firstDay.plusDays(week * daysPerWeek);
            LocalDate weekEnd = (week == 3) ? lastDay : weekStart.plusDays(daysPerWeek - 1);

            Map<String, Object> weekData = new HashMap<>();
            weekData.put("week", "Week " + (week + 1));

            // Jobs posted in this week
            String jobsSql = "SELECT COUNT(*) AS total FROM Posts " +
                    "WHERE CONVERT(DATE, CreatedAt) >= ? AND CONVERT(DATE, CreatedAt) <= ?";
            int jobs = executeCountQuery(conn, jobsSql, weekStart, weekEnd);

            // Applications in this week
            String appsSql = "SELECT COUNT(*) AS total FROM JobApplications " +
                    "WHERE CONVERT(DATE, appliedAt) >= ? AND CONVERT(DATE, appliedAt) <= ?";
            int apps = executeCountQuery(conn, appsSql, weekStart, weekEnd);

            // Hired in this week - FIXED: Now checking Interview table with status 'completed'
            String hiredSql = "SELECT COUNT(*) AS total FROM Interview " +
                    "WHERE CONVERT(DATE, updatedAt) >= ? AND CONVERT(DATE, updatedAt) <= ? " +
                    "AND LOWER(status) = 'completed'";
            int hired = executeCountQuery(conn, hiredSql, weekStart, weekEnd);

            weekData.put("jobsPosted", jobs);
            weekData.put("applications", apps);
            weekData.put("hired", hired);

            weeklyData.add(weekData);
        }

        return weeklyData;
    }

    /**
     * Get top 5 companies by applications for the selected month
     */
    private List<Map<String, Object>> getTopCompaniesRanking(Connection conn, LocalDate startDate, LocalDate endDate)
            throws SQLException {
        List<Map<String, Object>> companies = new ArrayList<>();

        String sql = "SELECT TOP 5 c.companyName, c.industry, COUNT(ja.applicationId) AS applicationCount " +
                "FROM Company c " +
                "INNER JOIN Posts p ON c.companyId = p.CompanyID " +
                "INNER JOIN JobApplications ja ON p.JobID = ja.jobId " +
                "WHERE CONVERT(DATE, ja.appliedAt) >= ? AND CONVERT(DATE, ja.appliedAt) <= ? " +
                "GROUP BY c.companyName, c.industry " +
                "ORDER BY applicationCount DESC";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, Date.valueOf(startDate));
            pstmt.setDate(2, Date.valueOf(endDate));

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> company = new HashMap<>();
                    company.put("name", rs.getString("companyName"));
                    company.put("category", rs.getString("industry") != null ? rs.getString("industry") : "General");
                    company.put("applications", rs.getInt("applicationCount"));
                    companies.add(company);
                }
            }
        }

        return companies;
    }

    /**
     * Helper method to execute count queries with date parameters
     */
    private int executeCountQuery(Connection conn, String sql, LocalDate startDate, LocalDate endDate)
            throws SQLException {
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setDate(1, Date.valueOf(startDate));
            pstmt.setDate(2, Date.valueOf(endDate));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
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