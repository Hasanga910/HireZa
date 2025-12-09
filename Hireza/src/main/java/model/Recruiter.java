package model;

public class Recruiter {
    private String recruiterId;
    private String userId;
    private String companyId;
    private String position;
    private String bio;
    private boolean profileCompleted;
    private String profileImage;  // NEW FIELD

    public Recruiter() {}

    public String getRecruiterId() {
        return recruiterId;
    }
    public void setRecruiterId(String recruiterId) {
        this.recruiterId = recruiterId;
    }

    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCompanyId() {
        return companyId;
    }
    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getPosition() {
        return position;
    }
    public void setPosition(String position) {
        this.position = position;
    }

    public String getBio() {
        return bio;
    }
    public void setBio(String bio) {
        this.bio = bio;
    }

    public boolean isProfileCompleted() {
        return profileCompleted;
    }
    public void setProfileCompleted(boolean profileCompleted) {
        this.profileCompleted = profileCompleted;
    }

    // NEW METHODS FOR IMAGE
    public String getProfileImage() {
        return profileImage;
    }
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }
}