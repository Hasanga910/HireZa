package controller;

import model.User;
import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String userRole = request.getParameter("userRole");

        // ✅ Always clear existing session attributes first
        HttpSession session = request.getSession();
        clearUserSessionAttributes(session);

        // ✅ Improved user role detection with explicit parameter validation
        if (userRole == null || userRole.isEmpty()) {
            userRole = detectUserRoleFromRequest(request);
        }

        if ("delete".equals(action)) {
            deleteUser(request, response, userRole);
        } else {
            fetchUsersByRole(request, response, userRole);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Clear all user-related session attributes to prevent data bleeding between pages
     */
    private void clearUserSessionAttributes(HttpSession session) {
        session.removeAttribute("users");
        session.removeAttribute("selectedRole");
        session.removeAttribute("totalUsers");
        session.removeAttribute("errorMessage");
        session.removeAttribute("successMessage");
    }

    /**
     * Improved user role detection from request parameters and referer
     */
    private String detectUserRoleFromRequest(HttpServletRequest request) {
        // First, check if it's in the request URI
        String requestURI = request.getRequestURI();
        if (requestURI != null) {
            if (requestURI.contains("UMjobseeker.jsp")) {
                return "JobSeeker";
            } else if (requestURI.contains("UMemployers.jsp")) {
                return "Employer";
            } else if (requestURI.contains("UMrecruiters.jsp")) {
                return "Recruiter";
            } else if (requestURI.contains("UMcounselors.jsp")) {
                return "JobCounsellor";
            }
        }

        // Fallback to referer header
        String referer = request.getHeader("referer");
        if (referer != null) {
            if (referer.contains("UMjobseeker.jsp")) {
                return "JobSeeker";
            } else if (referer.contains("UMemployers.jsp")) {
                return "Employer";
            } else if (referer.contains("UMrecruiters.jsp")) {
                return "Recruiter";
            } else if (referer.contains("UMcounselors.jsp")) {
                return "JobCounsellor";
            }
        }

        return "JobSeeker"; // Default fallback
    }

    private void fetchUsersByRole(HttpServletRequest request, HttpServletResponse response, String userRole)
            throws ServletException, IOException {

        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            String sql;
            if (userRole != null && !userRole.isEmpty() && !"All".equals(userRole)) {
                sql = "SELECT userId, fullName, username, email, role, phone, createdAt " +
                        "FROM Users WHERE role = ? ORDER BY createdAt DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userRole);
            } else {
                sql = "SELECT userId, fullName, username, email, role, phone, createdAt " +
                        "FROM Users ORDER BY createdAt DESC";
                pstmt = conn.prepareStatement(sql);
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("userId")); // Get as String
                user.setFullName(rs.getString("fullName"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                users.add(user);
            }

            // ✅ Store in session with explicit role tracking
            HttpSession session = request.getSession();
            session.setAttribute("users", users);
            session.setAttribute("selectedRole", userRole);
            session.setAttribute("totalUsers", users.size());
            session.setAttribute("lastFetchedRole", userRole); // Track what was last fetched

            // ✅ Determine correct JSP path for redirect
            String jspPath = getJspPathForRole(userRole);

            // ✅ Debug logging (remove in production)
            System.out.println("Fetched " + users.size() + " users for role: " + userRole);
            System.out.println("Redirecting to: " + jspPath);

            // ✅ Redirect (browser URL will change)
            response.sendRedirect(request.getContextPath() + jspPath);

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error fetching users: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        } finally {
            closeResources(conn, pstmt, rs);
        }
    }

    /**
     * Get JSP path based on user role
     */
    private String getJspPathForRole(String userRole) {
        switch (userRole) {
            case "JobSeeker":
                return "/admin/UMjobseeker.jsp";
            case "Recruiter":
                return "/admin/UMrecruiters.jsp";
            case "Employer":
                return "/admin/UMemployers.jsp";
            case "JobCounsellor":
                return "/admin/UMcounselors.jsp";
            default:
                return "/admin/UMjobseeker.jsp"; // fallback
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response, String userRole)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("userId");

        System.out.println("=== DELETE USER DEBUG ===");
        System.out.println("Received userId parameter: " + userIdStr);
        System.out.println("User role: " + userRole);

        if (userIdStr == null || userIdStr.isEmpty()) {
            request.getSession().setAttribute("errorMessage", "User ID is required for deletion.");
            fetchUsersByRole(request, response, userRole);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // ✅ CHANGED: Use String ID directly, no parsing needed
            String userId = userIdStr;

            System.out.println("Processing deletion for userId: " + userId);

            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Check if user exists - CHANGED to use String
            String checkSql = "SELECT role FROM Users WHERE userId = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, userId); // ✅ CHANGED: setString instead of setInt
            ResultSet rs = pstmt.executeQuery();

            if (!rs.next()) {
                System.out.println("User not found with ID: " + userId);
                request.getSession().setAttribute("errorMessage", "User not found.");
                conn.rollback();
                fetchUsersByRole(request, response, userRole);
                return;
            }

            String deletedUserRole = rs.getString("role");
            System.out.println("Found user with role: " + deletedUserRole);
            rs.close();
            pstmt.close();

            // Handle cascading deletes manually if needed
            if ("JobSeeker".equals(deletedUserRole)) {
                System.out.println("Deleting JobSeeker related data...");

                // Delete job applications
                String deleteApplicationsSql = "DELETE FROM JobApplications WHERE seekerId = ?";
                pstmt = conn.prepareStatement(deleteApplicationsSql);
                pstmt.setString(1, userId); // ✅ CHANGED: setString
                int appsDeleted = pstmt.executeUpdate();
                System.out.println("Deleted " + appsDeleted + " job applications");
                pstmt.close();
            }

            if ("Employer".equals(deletedUserRole)) {
                System.out.println("Deleting Employer related data...");

                // Get company IDs
                String getCompanySql = "SELECT companyId FROM Company WHERE userId = ?";
                pstmt = conn.prepareStatement(getCompanySql);
                pstmt.setString(1, userId); // ✅ CHANGED: setString
                ResultSet companyRs = pstmt.executeQuery();

                List<String> companyIds = new ArrayList<>(); // ✅ CHANGED: String instead of Integer
                while (companyRs.next()) {
                    companyIds.add(companyRs.getString("companyId")); // ✅ CHANGED: getString
                }
                companyRs.close();
                pstmt.close();

                System.out.println("Found " + companyIds.size() + " companies to clean up");

                for (String companyId : companyIds) { // ✅ CHANGED: String instead of Integer
                    // Delete job applications for jobs posted by this company
                    String deleteAppsSql = "DELETE FROM JobApplications WHERE jobId IN (SELECT JobID FROM Posts WHERE CompanyID = ?)";
                    pstmt = conn.prepareStatement(deleteAppsSql);
                    pstmt.setString(1, companyId); // ✅ CHANGED: setString
                    int appsDeleted = pstmt.executeUpdate();
                    System.out.println("Deleted " + appsDeleted + " applications for company " + companyId);
                    pstmt.close();
                }
            }

            if ("Recruiter".equals(deletedUserRole)) {
                System.out.println("Deleting Recruiter related data...");

                String deleteRecruiterSql = "DELETE FROM Recruiter WHERE userId = ?";
                pstmt = conn.prepareStatement(deleteRecruiterSql);
                pstmt.setString(1, userId); // ✅ CHANGED: setString
                int recruitersDeleted = pstmt.executeUpdate();
                System.out.println("Deleted " + recruitersDeleted + " recruiter records");
                pstmt.close();
            }

            // Delete the user - CHANGED to use String
            String deleteUserSql = "DELETE FROM Users WHERE userId = ?";
            pstmt = conn.prepareStatement(deleteUserSql);
            pstmt.setString(1, userId); // ✅ CHANGED: setString
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                conn.commit();
                System.out.println("Successfully deleted user " + userId);
                request.getSession().setAttribute("successMessage", "User and all related data deleted successfully.");
            } else {
                conn.rollback();
                System.out.println("Failed to delete user " + userId);
                request.getSession().setAttribute("errorMessage", "Failed to delete user.");
            }

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            System.out.println("SQL Exception during delete: " + e.getMessage());
            request.getSession().setAttribute("errorMessage", "Error deleting user: " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResources(conn, pstmt, null);
        }

        fetchUsersByRole(request, response, userRole);
    }

    private void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}