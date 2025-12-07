//package dao;
//
//import model.JobSeekerProfile;
//import util.DBConnection;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//public class JobSeekerProfileDAO {
//
//    // Fetch profile by seekerId
//    public JobSeekerProfile getProfileBySeekerId(String seekerId) {
//        String sql = "SELECT * FROM JobSeekerProfile WHERE seekerId = ?";
//        try (Connection con = DBConnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(sql)) {
//
//            ps.setString(1, seekerId);  // use setString
//            ResultSet rs = ps.executeQuery();
//
//            if(rs.next()) {
//                JobSeekerProfile profile = new JobSeekerProfile();
//                profile.setProfileId(rs.getString("profileId"));   // String
//                profile.setSeekerId(rs.getString("seekerId"));     // String
//                profile.setTitle(rs.getString("title"));
//                profile.setLocation(rs.getString("location"));
//                profile.setAbout(rs.getString("about"));
//                profile.setExperience(rs.getString("experience"));
//                profile.setEducation(rs.getString("education"));
//                profile.setSkills(rs.getString("skills"));
//                profile.setProfilePic(rs.getString("profilePic"));
//                return profile;
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null; // no profile found
//    }
//
//
//    // Save new CV/Profile
//    public void saveProfile(JobSeekerProfile profile) {
//        String sql = "INSERT INTO JobSeekerProfile(seekerId, title, location, about, experience, education, skills, profilePic) " +
//                "VALUES (?,?,?,?,?,?,?,?)";
//        try (Connection con = DBConnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(sql)) {
//
//            ps.setString(1, profile.getSeekerId());
//            ps.setString(2, profile.getTitle());
//            ps.setString(3, profile.getLocation());
//            ps.setString(4, profile.getAbout());
//            ps.setString(5, profile.getExperience());
//            ps.setString(6, profile.getEducation());
//            ps.setString(7, profile.getSkills());
//            ps.setString(8, profile.getProfilePic());
//
//            ps.executeUpdate();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    public static int getJobSeekersCount() {
//        String sql = "SELECT COUNT(*) FROM Users WHERE role = 'JobSeeker'";
//        int count = 0;
//
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql);
//             ResultSet rs = stmt.executeQuery()) {
//
//            if (rs.next()) {
//                count = rs.getInt(1);
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return count;
//    }
//
//}

package dao;

import model.JobSeekerProfile;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JobSeekerProfileDAO {

    // ✅ Generate next profile ID like J001, J002, J003...
    private String generateNextProfileId(Connection con) throws SQLException {
        String sql = "SELECT TOP 1 profileId FROM JobSeekerProfile ORDER BY profileId DESC";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("profileId"); // e.g., "J005"
                int number = Integer.parseInt(lastId.substring(1)); // remove "J"
                number++;
                return String.format("J%03d", number); // J006
            } else {
                return "J001"; // first record
            }
        }
    }

    // ✅ Fetch profile by seekerId
    public JobSeekerProfile getProfileBySeekerId(String seekerId) {
        String sql = "SELECT * FROM JobSeekerProfile WHERE seekerId = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, seekerId);
            ResultSet rs = ps.executeQuery();

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

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Save new profile (with custom ID)
    public void saveProfile(JobSeekerProfile profile) {
        String sql = "INSERT INTO JobSeekerProfile(profileId, seekerId, title, location, about, experience, education, skills, profilePic) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection()) {

            // Generate custom ID
            String newId = generateNextProfileId(con);
            profile.setProfileId(newId);

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, profile.getProfileId());
                ps.setString(2, profile.getSeekerId());
                ps.setString(3, profile.getTitle());
                ps.setString(4, profile.getLocation());
                ps.setString(5, profile.getAbout());
                ps.setString(6, profile.getExperience());
                ps.setString(7, profile.getEducation());
                ps.setString(8, profile.getSkills());
                ps.setString(9, profile.getProfilePic());

                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Count job seekers
    public static int getJobSeekersCount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE role = 'JobSeeker'";
        int count = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
    // ✅ Update existing profile
    public void updateProfile(JobSeekerProfile profile) {
        String sql = "UPDATE JobSeekerProfile SET title=?, location=?, about=?, experience=?, education=?, skills=?, profilePic=? WHERE seekerId=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, profile.getTitle());
            ps.setString(2, profile.getLocation());
            ps.setString(3, profile.getAbout());
            ps.setString(4, profile.getExperience());
            ps.setString(5, profile.getEducation());
            ps.setString(6, profile.getSkills());
            ps.setString(7, profile.getProfilePic());
            ps.setString(8, profile.getSeekerId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

