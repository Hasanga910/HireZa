package dao;

import util.DBConnection;
import model.JobApplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JobApplicationDAO {

    // ✅ Insert new job application
    public boolean insert(String jobId, String seekerId, String fullName, String email,
                          String phone, String coverLetter, String resumeFile) {
        String applicationId = generateApplicationId(); // unique application ID

        String sql = "INSERT INTO JobApplications "
                + "(applicationId, jobId, seekerId, fullName, email, phone, coverLetter, resumeFile) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, applicationId);
            ps.setString(2, jobId);
            ps.setString(3, seekerId);
            ps.setString(4, fullName);
            ps.setString(5, email);
            ps.setString(6, phone);
            ps.setString(7, coverLetter);
            ps.setString(8, resumeFile);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Generate next unique ID for JobApplications (e.g., A001, A002, ...)
    public String generateApplicationId() {
        // Example: A001, A002, ...
        String sql = "SELECT TOP 1 applicationId FROM JobApplications ORDER BY applicationId DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("applicationId"); // e.g., A012
                int num = Integer.parseInt(lastId.substring(1)) + 1;
                return "A" + String.format("%03d", num); // A013
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "A001"; // first ID if table is empty
    }

    // ✅ FIXED: Fetch applied jobs for a seeker
    public List<JobApplication> getApplicationsBySeeker(String seekerId) {
        List<JobApplication> applications = new ArrayList<>();

        // Fixed query matching your exact database schema
        String sql = "SELECT a.applicationId, a.jobId, p.JobTitle, a.seekerId, a.fullName, " +
                "a.email, a.phone, a.coverLetter, a.resumeFile, a.appliedAt, a.status " +
                "FROM JobApplications a " +
                "INNER JOIN Posts p ON a.jobId = p.JobID " +
                "WHERE a.seekerId = ? " +
                "ORDER BY a.appliedAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, seekerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JobApplication app = new JobApplication();
                app.setApplicationId(rs.getString("applicationId"));
                app.setJobId(rs.getString("jobId"));
                app.setSeekerId(rs.getString("seekerId"));
                app.setJobTitle(rs.getString("JobTitle"));
                app.setFullName(rs.getString("fullName"));
                app.setEmail(rs.getString("email"));
                app.setPhone(rs.getString("phone"));
                app.setCoverLetter(rs.getString("coverLetter"));
                app.setResumeFile(rs.getString("resumeFile"));
                app.setAppliedAt(rs.getTimestamp("appliedAt"));
                app.setStatus(rs.getString("status"));
                applications.add(app);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return applications;
    }

    // ✅ Fetch applications by job ID
    public List<JobApplication> getApplicationsByJobId(String jobId) {
        List<JobApplication> applications = new ArrayList<>();
        String sql = "SELECT a.applicationId, a.jobId, p.JobTitle, a.seekerId, a.fullName, a.email, a.phone, " +
                "a.coverLetter, a.resumeFile, a.appliedAt, a.status " +
                "FROM JobApplications a " +
                "JOIN Posts p ON a.jobId = p.JobID " +
                "WHERE a.jobId = ? " +
                "ORDER BY a.appliedAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, jobId);  // Use String ID
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobApplication app = new JobApplication();
                app.setApplicationId(rs.getString("applicationId"));
                app.setJobId(rs.getString("jobId"));
                app.setSeekerId(rs.getString("seekerId"));
                app.setJobTitle(rs.getString("JobTitle"));
                app.setFullName(rs.getString("fullName"));
                app.setEmail(rs.getString("email"));
                app.setPhone(rs.getString("phone"));
                app.setCoverLetter(rs.getString("coverLetter"));
                app.setResumeFile(rs.getString("resumeFile"));
                app.setAppliedAt(rs.getTimestamp("appliedAt")); // maps to java.util.Date
                app.setStatus(rs.getString("status"));
                applications.add(app);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return applications;
    }

    // ✅ Update application status
    public boolean updateApplicationStatus(String applicationId, String status) {
        String sql = "UPDATE JobApplications SET status = ? WHERE applicationId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setString(2, applicationId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Fetch a single application by ID
    public JobApplication getApplicationById(String applicationId) {
        String sql = "SELECT a.applicationId, a.jobId, p.JobTitle, a.seekerId, a.fullName, a.email, a.phone, " +
                "a.coverLetter, a.resumeFile, a.appliedAt, a.status " +
                "FROM JobApplications a " +
                "JOIN Posts p ON a.jobId = p.JobID " +
                "WHERE a.applicationId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, applicationId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                JobApplication app = new JobApplication();
                app.setApplicationId(rs.getString("applicationId"));
                app.setJobId(rs.getString("jobId"));
                app.setSeekerId(rs.getString("seekerId"));
                app.setJobTitle(rs.getString("JobTitle"));
                app.setFullName(rs.getString("fullName"));
                app.setEmail(rs.getString("email"));
                app.setPhone(rs.getString("phone"));
                app.setCoverLetter(rs.getString("coverLetter"));
                app.setResumeFile(rs.getString("resumeFile"));
                app.setAppliedAt(rs.getTimestamp("appliedAt"));
                app.setStatus(rs.getString("status"));
                return app;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get total applications count for a company
    public int getTotalApplicationsCount(String companyId) {
        String sql = "SELECT COUNT(*) FROM JobApplications ja JOIN Posts p ON ja.jobId = p.JobID WHERE p.CompanyID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ✅ Get new (pending) applications count for a company
    public int getNewApplicationsCount(String companyId) {
        String sql = "SELECT COUNT(*) FROM JobApplications ja JOIN Posts p ON ja.jobId = p.JobID WHERE p.CompanyID = ? AND ja.status = 'Pending'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ✅ Delete application
    public boolean deleteApplication(String applicationId) {
        String sql = "DELETE FROM JobApplications WHERE applicationId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, applicationId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Get all applications for a company
    public List<JobApplication> getApplicationsByCompanyId(String companyId) {
        List<JobApplication> applications = new ArrayList<>();
        String sql = "SELECT ja.applicationId, ja.jobId, ja.seekerId, ja.status " +
                "FROM JobApplications ja " +
                "JOIN Posts p ON ja.jobId = p.JobID " +
                "WHERE p.companyId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobApplication app = new JobApplication();
                app.setApplicationId(rs.getString("applicationId"));
                app.setJobId(rs.getString("jobId"));
                app.setSeekerId(rs.getString("seekerId"));
                app.setStatus(rs.getString("status"));
                applications.add(app);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applications;
    }

    // ✅ Update application details with updatedAt timestamp
    public boolean updateApplication(JobApplication app) {
        String sql = "UPDATE JobApplications SET fullName = ?, email = ?, phone = ?, coverLetter = ?, resumeFile = ?, updatedAt = GETDATE() WHERE applicationId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, app.getFullName());
            ps.setString(2, app.getEmail());
            ps.setString(3, app.getPhone());
            ps.setString(4, app.getCoverLetter());
            ps.setString(5, app.getResumeFile());
            ps.setString(6, app.getApplicationId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error updating application:");
            e.printStackTrace();
            return false;
        }
    }

}