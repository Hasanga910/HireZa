package dao;

import controller.RegisterServlet;
import model.JobSeekerProfile;
import model.User;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserDAO {

    public int registerUser(User user) {
        // Generate role-specific userId
        String newUserId = generateNextUserId(user.getRole());
        String sql = "INSERT INTO Users (userId, fullName, username, email, password, role, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newUserId);
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getUsername());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getPhone());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                user.setId(newUserId);
                System.out.println("✅ User registered successfully with ID: " + newUserId);
                return 1;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Generate next user ID based on role
     * JobSeeker: JB001, JB002, ...
     * Employer: EMP001, EMP002, ...
     * Recruiter: REC001, REC002, ...
     * Assistant: ADS001, ADS002, ...
     */
    private String generateNextUserId(String role) {
        String prefix = getRolePrefix(role);
        String sql = "SELECT TOP 1 userId FROM Users WHERE userId LIKE ? ORDER BY userId DESC";
        String newId = prefix + "001";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, prefix + "%");
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String lastId = rs.getString("userId"); // e.g., "JB012"
                int numericPart = Integer.parseInt(lastId.substring(prefix.length())) + 1;
                newId = String.format(prefix + "%03d", numericPart);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return newId;
    }

    /**
     * Get prefix based on user role
     */
    private String getRolePrefix(String role) {
        if (role == null) {
            return "U";
        }

        switch (role.toLowerCase()) {
            case "jobseeker":
                return "JB";
            case "employer":
                return "EMP";
            case "recruiter":
                return "REC";
            case "assistant":
                return "ADS";
            case "JobCounsellor":
                return "JC";
            default:
                return "U";
        }

    }

    /**
     * FIXED: Login user with username and password (hashed password verification)
     */
    public User loginUser(String username, String password) {
        String sql = "SELECT * FROM dbo.Users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");

                if (RegisterServlet.verifyPassword(password, storedHashedPassword)) {
                    User user = new User();
                    user.setId(rs.getString("userId"));
                    user.setFullName(rs.getString("fullName"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setPhone(rs.getString("phone"));
                    return user;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * FIXED: Login user with username, password, and role (hashed password verification)
     */
    public User loginUser(String username, String password, String role) {
        String sql = "SELECT * FROM dbo.Users WHERE username = ? AND role = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, role);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");

                if (RegisterServlet.verifyPassword(password, storedHashedPassword)) {
                    User user = new User();
                    user.setId(rs.getString("userId"));
                    user.setFullName(rs.getString("fullName"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setPhone(rs.getString("phone"));
                    return user;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getString("userId"));
                user.setFullName(rs.getString("fullName"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * FIXED: Change password with hashed password verification
     */
    public boolean changePassword(int userId, String currentPassword, String newHashedPassword) {
        String selectSql = "SELECT password FROM Users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {

            selectStmt.setInt(1, userId);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");

                if (RegisterServlet.verifyPassword(currentPassword, storedHashedPassword)) {
                    String updateSql = "UPDATE Users SET password = ? WHERE userId = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setString(1, newHashedPassword);
                        updateStmt.setInt(2, userId);
                        int rowsUpdated = updateStmt.executeUpdate();
                        return rowsUpdated > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET fullName = ?, username = ?, email = ?, phone = ?, password = ? WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public JobSeekerProfile getProfileBySeekerId(String seekerId) {
        String sql = "SELECT * FROM JobSeekerProfile WHERE seekerId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, seekerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                JobSeekerProfile profile = new JobSeekerProfile();
                profile.setProfileId(rs.getString("profileId"));
                profile.setSeekerId(rs.getString("seekerId"));
                profile.setTitle(rs.getString("title"));
                profile.setLocation(rs.getString("location"));
                profile.setAbout(rs.getString("about"));
                profile.setExperience(rs.getString("experience"));
                profile.setEducation(rs.getString("education"));
                profile.setSkills(rs.getString("skills"));
                profile.setProfilePic(rs.getString("profilePic"));
                return profile;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePassword(String userId, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword);
            stmt.setString(2, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUserWithProfile(String userId) {
        String deleteApplications = "DELETE FROM JobApplications WHERE seekerId = ?";
        String deleteProfile = "DELETE FROM JobSeekerProfile WHERE seekerId = ?";
        String deleteCV = "DELETE FROM CV WHERE seekerId = ?";
        String deleteUser = "DELETE FROM Users WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (
                    PreparedStatement stmtApps = conn.prepareStatement(deleteApplications);
                    PreparedStatement stmtProfile = conn.prepareStatement(deleteProfile);
                    PreparedStatement stmtCV = conn.prepareStatement(deleteCV);
                    PreparedStatement stmtUser = conn.prepareStatement(deleteUser)
            ) {
                stmtApps.setString(1, userId);
                stmtApps.executeUpdate();

                stmtProfile.setString(1, userId);
                stmtProfile.executeUpdate();

                stmtCV.setString(1, userId);
                stmtCV.executeUpdate();

                stmtUser.setString(1, userId);
                int rowsDeleted = stmtUser.executeUpdate();

                conn.commit();
                return rowsDeleted > 0;

            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getJobSeekersCount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE role = 'JobSeeker'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}