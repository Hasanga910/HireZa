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
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet("/ManageAdminAssistantsServlet")
public class ManageAdminAssistantsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ✅ Always clear existing session attributes first
        HttpSession session = request.getSession();
        clearAdminSessionAttributes(session);

        if ("delete".equals(action)) {
            deleteAdminAssistant(request, response);
        } else {
            fetchAdminAssistants(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addAdminAssistant(request, response);
        } else {
            doGet(request, response);
        }
    }

    /**
     * Clear all admin assistant related session attributes to prevent data bleeding
     */
    private void clearAdminSessionAttributes(HttpSession session) {
        session.removeAttribute("users");
        session.removeAttribute("selectedRole");
        session.removeAttribute("totalUsers");
        session.removeAttribute("errorMessage");
        session.removeAttribute("successMessage");
    }

    private void fetchAdminAssistants(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> adminAssistants = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            String sql = "SELECT userId, fullName, username, email, role, phone, createdAt " +
                    "FROM Users WHERE role = ? ORDER BY createdAt DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "AdminAssistant");

            rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("userId"));
                user.setFullName(rs.getString("fullName"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                adminAssistants.add(user);
            }

            // ✅ Store in session
            HttpSession session = request.getSession();
            session.setAttribute("users", adminAssistants);
            session.setAttribute("selectedRole", "AdminAssistant");
            session.setAttribute("totalUsers", adminAssistants.size());

            // ✅ Debug logging (remove in production)
            System.out.println("Fetched " + adminAssistants.size() + " admin assistants");

            // ✅ Redirect to JSP
            response.sendRedirect(request.getContextPath() + "/admin/Aadminassistants.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error fetching admin assistants: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        } finally {
            closeResources(conn, pstmt, rs);
        }
    }

    private void deleteAdminAssistant(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");

        if (userId == null || userId.isEmpty()) {
            request.getSession().setAttribute("errorMessage", "User ID is required for deletion.");
            fetchAdminAssistants(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Check if user exists and is an AdminAssistant
            String checkSql = "SELECT role FROM Users WHERE userId = ? AND role = 'AdminAssistant'";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, userId);  // ✅ Changed from setInt to setString
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                request.getSession().setAttribute("errorMessage", "Admin Assistant not found.");
                conn.rollback();
                fetchAdminAssistants(request, response);
                return;
            }

            rs.close();
            pstmt.close();

            // Delete the admin assistant
            String deleteUserSql = "DELETE FROM Users WHERE userId = ? AND role = 'AdminAssistant'";
            pstmt = conn.prepareStatement(deleteUserSql);
            pstmt.setString(1, userId);  // ✅ Changed from setInt to setString
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                conn.commit();
                request.getSession().setAttribute("successMessage", "Admin Assistant deleted successfully.");
            } else {
                conn.rollback();
                request.getSession().setAttribute("errorMessage", "Failed to delete Admin Assistant.");
            }

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error deleting Admin Assistant: " + e.getMessage());
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResources(conn, pstmt, rs);
        }

        fetchAdminAssistants(request, response);
    }

    private void addAdminAssistant(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            // Validation
            if (fullName == null || fullName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty()) {

                request.getSession().setAttribute("errorMessage", "Required fields are missing.");
                fetchAdminAssistants(request, response);
                return;
            }

            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Check if email already exists
            String checkEmailSql = "SELECT COUNT(*) FROM Users WHERE email = ?";
            pstmt = conn.prepareStatement(checkEmailSql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                request.getSession().setAttribute("errorMessage", "Email already exists!");
                conn.rollback();
                fetchAdminAssistants(request, response);
                return;
            }
            rs.close();
            pstmt.close();

            // Hash password
            String hashedPassword = hashPassword(password);

            // Generate a unique string ID for Admin Assistant
            String userId = generateUserId(conn);

            // Insert new admin assistant with userId
            String insertSql = "INSERT INTO Users (userId, fullName, username, email, phone, password, role) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, userId);
            pstmt.setString(2, fullName);
            pstmt.setString(3, email.split("@")[0]); // username
            pstmt.setString(4, email);
            pstmt.setString(5, phone);
            pstmt.setString(6, hashedPassword);
            pstmt.setString(7, "AdminAssistant");

            int rowsInserted = pstmt.executeUpdate();

            if (rowsInserted > 0) {
                conn.commit();
                request.getSession().setAttribute("successMessage", "Admin Assistant added successfully.");
            } else {
                conn.rollback();
                request.getSession().setAttribute("errorMessage", "Failed to add Admin Assistant.");
            }

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error adding Admin Assistant: " + e.getMessage());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error encrypting password.");
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResources(conn, pstmt, null);
        }

        fetchAdminAssistants(request, response);
    }
    private String generateUserId(Connection conn) throws SQLException {
        String prefix = "U";
        String query = "SELECT userId FROM Users ORDER BY userId DESC";

        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("userId");
                int num = Integer.parseInt(lastId.substring(1)); // Remove prefix U
                return prefix + String.format("%03d", num + 1);  // e.g., U002, U003
            } else {
                return "U001"; // First user
            }
        }
    }


    private String hashPassword(String password) throws NoSuchAlgorithmException {
        try {
            // Generate random salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);

            // Hash password with salt
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes(StandardCharsets.UTF_8));

            // Encode salt and hash to Base64
            String saltStr = Base64.getEncoder().encodeToString(salt);
            String hashStr = Base64.getEncoder().encodeToString(hashedPassword);

            // Return in format: salt:hash
            return saltStr + ":" + hashStr;
        } catch (Exception e) {
            throw new NoSuchAlgorithmException("Error hashing password", e);
        }
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