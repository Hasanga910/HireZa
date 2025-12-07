package dao;

import model.Admin;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static util.DBConnection.getConnection;

public class AdminDAO {

    // Fetch the only Admin (Singleton approach in DB)
    public Admin getAdminById(String id) {  // Changed from int to String
        String sql = "SELECT * FROM Users WHERE userId = ? AND role = 'admin'";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id); // Changed to setString
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getString("userId")); // Get as String
                admin.setFullName(rs.getString("fullName"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
                admin.setPhone(rs.getString("phone"));
                admin.setRole("admin");
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    // Get admin by username (for login purposes)
    public Admin getAdminByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username = ? AND role = 'admin'";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getString("userId"));
                admin.setFullName(rs.getString("fullName"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
                admin.setPhone(rs.getString("phone"));
                admin.setRole("admin");
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update admin profile
    public boolean updateAdminProfile(String userId, String fullName, String username, String email, String phone) {  // Changed from int to String
        String sql = "UPDATE Users SET fullName = ?, username = ?, email = ?, phone = ? WHERE userId = ? AND role = 'admin'";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, fullName);
            stmt.setString(2, username);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, userId); // Changed to setString

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates admin password after verifying current password
     * @param adminId The ID of the admin (String format like U001)
     * @param currentPassword Current password to verify
     * @param newPassword New password to set
     * @return true if password was updated successfully, false otherwise
     */
    public boolean updateAdminPassword(String adminId, String currentPassword, String newPassword) {  // Changed from int to String
        String verifyPasswordQuery = "SELECT password FROM Users WHERE userId = ? AND role = 'admin'";
        String updatePasswordQuery = "UPDATE Users SET password = ? WHERE userId = ? AND role = 'admin'";

        Connection conn = null;
        PreparedStatement verifyStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();

            // First, verify the current password
            verifyStmt = conn.prepareStatement(verifyPasswordQuery);
            verifyStmt.setString(1, adminId); // Changed to setString
            rs = verifyStmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // Verify current password
                if (!verifyPassword(currentPassword, storedPassword)) {
                    System.out.println("Current password verification failed for admin ID: " + adminId);
                    return false;
                }

                // If current password is correct, update with new password
                updateStmt = conn.prepareStatement(updatePasswordQuery);
                updateStmt.setString(1, hashPassword(newPassword)); // Hash the new password
                updateStmt.setString(2, adminId); // Changed to setString

                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    System.out.println("Password updated successfully for admin ID: " + adminId);
                    return true;
                } else {
                    System.out.println("No rows updated for admin ID: " + adminId);
                    return false;
                }

            } else {
                System.out.println("Admin not found with ID: " + adminId);
                return false;
            }

        } catch (SQLException e) {
            System.err.println("Database error in updateAdminPassword: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (verifyStmt != null) verifyStmt.close();
                if (updateStmt != null) updateStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
            }
        }
    }

    /**
     * Hash a password using SHA-256 (replace with BCrypt in production)
     */
    private String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    /**
     * Verify a password against its hash
     */
    private boolean verifyPassword(String password, String hash) {
        // For plain text passwords (current implementation)
        // This checks if it's already hashed or plain text
        if (hash.length() == 64) { // SHA-256 hash length
            // It's hashed, compare with hashed input
            String hashedInput = hashPassword(password);
            return hashedInput.equals(hash);
        } else {
            // It's plain text, compare directly
            return password.equals(hash);
        }
    }

    // Legacy method - keeping for backward compatibility but now unused
    public boolean updateAdminPassword(String adminId, String hashedPassword) {  // Changed from int to String
        String sql = "UPDATE Users SET password = ? WHERE userId = ? AND role = 'admin'";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, hashedPassword);
            statement.setString(2, adminId); // Changed to setString

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Verify admin password
    public boolean verifyAdminPassword(String userId, String password) {
        String sql = "SELECT password FROM Users WHERE userId = ? AND role = 'admin'";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return verifyPassword(password, storedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Add Admin Assistant
    public boolean addAssistant(User assistant) {
        String sql = "INSERT INTO Users (userId, fullName, username, email, password, role, phone) VALUES (?, ?, ?, ?, ?, 'AdminAssistant', ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Generate a string ID before inserting
            String newId = generateUserId(conn);  // U001, U002, etc.

            stmt.setString(1, newId);
            stmt.setString(2, assistant.getFullName());
            stmt.setString(3, assistant.getUsername());
            stmt.setString(4, assistant.getEmail());
            stmt.setString(5, hashPassword(assistant.getPassword()));
            stmt.setString(6, assistant.getPhone());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    private String generateUserId(Connection conn) throws SQLException {
        String prefix = "U";
        String query = "SELECT userId FROM Users ORDER BY userId DESC LIMIT 1";

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



    // Remove user (cannot delete Admin itself)
    public boolean removeUser(String userId) {  // Changed from int to String
        String sql = "DELETE FROM Users WHERE userId = ? AND role != 'admin'";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId); // Changed to setString
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // View all users (for reports)
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE role != 'admin'"; // exclude admin from reports

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("userId"));
                user.setFullName(rs.getString("fullName"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Get users by role (optional: assistants, recruiters, etc.)
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE role = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("userId"));
                user.setFullName(rs.getString("fullName"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}