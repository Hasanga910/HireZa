/*package model;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JobSeekerProfile extends User {
    private int profileId;
    private int seekerId;
    private String title;
    private String location;
    private String about;
    private String experience;
    private String education;
    private String skills;
    private String profilePic;

    // Getters and Setters
    public int getProfileId() {
        return profileId;
    }
    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }
    public int getSeekerId() {
        return seekerId;
    }
    public void setSeekerId(int seekerId) {
        this.seekerId = seekerId;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public String getAbout() {
        return about;
    }
    public void setAbout(String about) {
        this.about = about;
    }
    public String getExperience() {
        return experience;
    }
    public void setExperience(String experience) {
        this.experience = experience;
    }
    public String getEducation() {
        return education;
    }
    public void setEducation(String education) {
        this.education = education;
    }
    public String getSkills() {
        return skills;
    }
    public void setSkills(String skills) {
        this.skills = skills;
    }
    public String getProfilePic() {
        return profilePic;
    }
    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }


    public JobSeekerProfile getProfileBySeekerId(int seekerId) {
        String sql = "SELECT * FROM JobSeekerProfile WHERE seekerId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, seekerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                JobSeekerProfile profile = new JobSeekerProfile();
                profile.setProfileId(rs.getInt("profileId"));
                profile.setSeekerId(rs.getInt("seekerId"));
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
}*/

package model;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JobSeekerProfile extends User {
    private String profileId;
    private String seekerId;
    private String title;
    private String location;
    private String about;
    private String experience;
    private String education;
    private String skills;
    private String profilePic;

    public JobSeekerProfile() {
        super();
        this.setRole("JobSeeker");  // automatically set role
    }

    public JobSeekerProfile(String fullName, String username, String email, String password, String phone) {
        super(fullName, username, email, password, "JobSeeker", phone);
    }

    // Getters and Setters
    public String getProfileId() { return profileId; }
    public void setProfileId(String profileId) { this.profileId = profileId; }

    public String getSeekerId() { return seekerId; }
    public void setSeekerId(String seekerId) { this.seekerId = seekerId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getAbout() { return about; }
    public void setAbout(String about) { this.about = about; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getEducation() { return education; }
    public void setEducation(String education) { this.education = education; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getProfilePic() { return profilePic; }
    public void setProfilePic(String profilePic) { this.profilePic = profilePic; }

    // Load profile from DB
    public JobSeekerProfile getProfileBySeekerId(int seekerId) {
        String sql = "SELECT * FROM JobSeekerProfile WHERE seekerId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, seekerId);
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
}
