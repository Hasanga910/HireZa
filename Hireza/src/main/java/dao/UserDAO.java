package dao;

import controller.RegisterServlet;
import model.JobSeekerProfile;
import model.User;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public String registerUser(User user) {
        // Include userId in INSERT because we generate it manually
        String newUserId = generateNextUserId(); // e.g., "U005"
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
//            if (rowsInserted > 0) {
//                user.setId(newUserId); // save the generated ID in the object
//                System.out.println("✅ User registered successfully with ID: " + newUserId);
//                return String.valueOf(1);
//            }
            if (rowsInserted > 0) {
                user.setId(newUserId);
                System.out.println("✅ User registered successfully with ID: " + newUserId);
                return newUserId; // ✅ return actual ID
            }


//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return String.valueOf(-1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    /**
     * Generate next user ID in format U001, U002, etc.
     */
    private String generateNextUserId() {
        // SQL Server uses TOP 1, not LIMIT
        String sql = "SELECT TOP 1 userId FROM Users ORDER BY userId DESC";
        String prefix = "U";
        String newId = "U001";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("userId"); // e.g., "U012"
                int numericPart = Integer.parseInt(lastId.substring(1)) + 1;
                newId = String.format(prefix + "%03d", numericPart);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return newId;
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

                // Verify the password using the RegisterServlet's verifyPassword method
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

                // Verify the password using the RegisterServlet's verifyPassword method
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

    public boolean deleteUser(String userId) {
        String sql = "DELETE FROM Users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserById(String userId) {
        String sql = "SELECT * FROM Users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
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
        // First, get the user's current hashed password
        String selectSql = "SELECT password FROM Users WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {

            selectStmt.setInt(1, userId);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");

                // Verify the current password
                if (RegisterServlet.verifyPassword(currentPassword, storedHashedPassword)) {
                    // Current password is correct, update to new password
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

//    public boolean deleteUserWithProfile(String userId) {
//        String deleteApplications = "DELETE FROM JobApplications WHERE seekerId = ?";
//        String deleteProfile = "DELETE FROM JobSeekerProfile WHERE seekerId = ?";
//        String deleteCV = "DELETE FROM CV WHERE seekerId = ?";
//        String deleteUser = "DELETE FROM Users WHERE userId = ?";
//
//        try (Connection conn = DBConnection.getConnection()) {
//            conn.setAutoCommit(false); //  Start transaction
//
//            try (
//                    PreparedStatement stmtApps = conn.prepareStatement(deleteApplications);
//                    PreparedStatement stmtProfile = conn.prepareStatement(deleteProfile);
//                    PreparedStatement stmtCV = conn.prepareStatement(deleteCV);
//                    PreparedStatement stmtUser = conn.prepareStatement(deleteUser)
//            ) {
//                // Step 1: Delete from dependent tables first
//                stmtApps.setString(1, userId);
//                stmtApps.executeUpdate();
//
//                stmtProfile.setString(1, userId);
//                stmtProfile.executeUpdate();
//
//                stmtCV.setString(1, userId);
//                stmtCV.executeUpdate();
//
//                // Step 2: Delete from main Users table
//                stmtUser.setString(1, userId);
//                int rowsDeleted = stmtUser.executeUpdate();
//
//                conn.commit(); //  Commit all if successful
//                return rowsDeleted > 0;
//
//            } catch (SQLException e) {
//                conn.rollback(); // Rollback on error
//                e.printStackTrace();
//                return false;
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }

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


    public boolean deleteUserWithProfile(String userId) {
        String deleteActivityLog = "DELETE FROM RecruiterActivityLog WHERE applicationId IN (SELECT applicationId FROM JobApplications WHERE seekerId = ?)";
        String deleteInterview = "DELETE FROM Interview WHERE applicationId IN (SELECT applicationId FROM JobApplications WHERE seekerId = ?)";
        String deleteJobNotifications = "DELETE FROM JobNotifications WHERE applicationId IN (SELECT applicationId FROM JobApplications WHERE seekerId = ?)";
        String deleteApplications = "DELETE FROM JobApplications WHERE seekerId = ?";
        String deleteProfile = "DELETE FROM JobSeekerProfile WHERE seekerId = ?";
        String deleteCV = "DELETE FROM CV WHERE seekerId = ?";
        String deleteUser = "DELETE FROM Users WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement ps1 = conn.prepareStatement(deleteActivityLog);
                 PreparedStatement ps2 = conn.prepareStatement(deleteInterview);
                 PreparedStatement ps3 = conn.prepareStatement(deleteJobNotifications);
                 PreparedStatement ps4 = conn.prepareStatement(deleteApplications);
                 PreparedStatement ps5 = conn.prepareStatement(deleteProfile);
                 PreparedStatement ps6 = conn.prepareStatement(deleteCV);
                 PreparedStatement ps7 = conn.prepareStatement(deleteUser)) {

                ps1.setString(1, userId); ps1.executeUpdate();
                ps2.setString(1, userId); ps2.executeUpdate();
                ps3.setString(1, userId); ps3.executeUpdate();
                ps4.setString(1, userId); ps4.executeUpdate();
                ps5.setString(1, userId); ps5.executeUpdate();
                ps6.setString(1, userId); ps6.executeUpdate();
                ps7.setString(1, userId); ps7.executeUpdate();

                conn.commit();
                return true;

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
}