package dao;

import model.JobPost;
import model.NotificationObserver;
import model.NotificationSubject;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static util.DBConnection.getConnection;

public class JobPostDAO {

    private NotificationSubject notificationSubject = new NotificationSubject();
    private JobPostNotificationObserver notificationObserver;

    public JobPostDAO() {
        this.notificationObserver = new JobPostNotificationObserver();
        addNotificationObserver(notificationObserver);
    }

    public void addNotificationObserver(NotificationObserver observer) {
        notificationSubject.addObserver(observer);
    }

    public boolean saveJobPost(JobPost post) {
        String jobId = generateNextJobId();
        post.setJobId(jobId);

        String sql = "INSERT INTO Posts (JobID, CompanyID, CompanyName, JobTitle, WorkMode, Location, EmploymentType, " +
                "JobDescription, RequiredSkills, ExperienceLevel, ApplicationDeadline, SalaryRange, " +
                "WorkingHoursShifts, Status, CreatedAt, UpdatedAt) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', GETDATE(), GETDATE())";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, post.getJobId());
            stmt.setString(2, post.getCompanyId());
            stmt.setString(3, post.getCompanyName());
            stmt.setString(4, post.getJobTitle());
            stmt.setString(5, post.getWorkMode());
            stmt.setString(6, post.getLocation());
            stmt.setString(7, post.getEmploymentType());
            stmt.setString(8, post.getJobDescription());
            stmt.setString(9, post.getRequiredSkills());
            stmt.setString(10, post.getExperienceLevel());

            if (post.getApplicationDeadline() != null) {
                stmt.setDate(11, new java.sql.Date(post.getApplicationDeadline().getTime()));
            } else {
                stmt.setNull(11, Types.DATE);
            }

            stmt.setString(12, post.getSalaryRange());
            stmt.setString(13, post.getWorkingHoursShifts());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String generateNextJobId() {
        String prefix = "P";
        String sql = "SELECT TOP 1 JobID FROM Posts ORDER BY JobID DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("JobID");
                int num = Integer.parseInt(lastId.substring(1));
                num++;
                return String.format("P%03d", num);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "P001";
    }

    public boolean updateJobPost(JobPost post) {
        String sql = "UPDATE Posts SET JobTitle = ?, WorkMode = ?, Location = ?, EmploymentType = ?, " +
                "JobDescription = ?, RequiredSkills = ?, ExperienceLevel = ?, ApplicationDeadline = ?, " +
                "SalaryRange = ?, WorkingHoursShifts = ?, UpdatedAt = GETDATE() " +
                "WHERE JobID = ? AND CompanyID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, post.getJobTitle());
            stmt.setString(2, post.getWorkMode());
            stmt.setString(3, post.getLocation());
            stmt.setString(4, post.getEmploymentType());
            stmt.setString(5, post.getJobDescription());
            stmt.setString(6, post.getRequiredSkills());
            stmt.setString(7, post.getExperienceLevel());
            if (post.getApplicationDeadline() != null) {
                stmt.setDate(8, new java.sql.Date(post.getApplicationDeadline().getTime()));
            } else {
                stmt.setNull(8, Types.DATE);
            }
            stmt.setString(9, post.getSalaryRange());
            stmt.setString(10, post.getWorkingHoursShifts());
            stmt.setString(11, post.getJobId());
            stmt.setString(12, post.getCompanyId());

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteJobPost(String jobId, String companyId) {
        JobPost post = getJobPostById(jobId, companyId);

        if (post == null) {
            System.err.println("Job post not found: " + jobId);
            return false;
        }


        // Now delete the job post
        String sql = "DELETE FROM Posts WHERE JobID = ? AND CompanyID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, jobId);
            stmt.setString(2, companyId);

            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteJobPostById(String jobId) {
        // First, get the job post details BEFORE deleting
        JobPost post = getJobPostById(jobId);

        if (post == null) {
            System.err.println("Job post not found: " + jobId);
            return false;
        }


        // Now delete the job post
        String sql = "DELETE FROM Posts WHERE JobID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, jobId);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting job post with ID " + jobId + ": " + e.getMessage());
            return false;
        }
    }

    public JobPost getJobPostById(String jobId, String companyId) {
        String sql = "SELECT * FROM Posts WHERE JobID = ? AND CompanyID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, jobId);
            stmt.setString(2, companyId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractJobPost(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public JobPost getJobPostById(String jobId) {
        String sql = "SELECT * FROM Posts WHERE JobID = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, jobId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractJobPost(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<JobPost> getAllJobPostsByCompanyId(String companyId) {
        List<JobPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE CompanyID = ? ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                posts.add(extractJobPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<JobPost> getAllJobPosts() {
        List<JobPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                posts.add(extractJobPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<JobPost> searchApprovedJobs(String keyword, String location) {
        List<JobPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE Status = 'approved' AND " +
                "(JobTitle LIKE ? OR JobDescription LIKE ? OR RequiredSkills LIKE ? OR CompanyName LIKE ?) " +
                "AND Location LIKE ? ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            String locationPattern = "%" + location + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, locationPattern);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                posts.add(extractJobPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<JobPost> getPendingJobPosts() {
        List<JobPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE Status = 'pending' ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                posts.add(extractJobPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving pending job posts: " + e.getMessage());
        }
        return posts;
    }

    public List<JobPost> getApprovedJobPosts() {
        List<JobPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE Status = 'approved' ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                posts.add(extractJobPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving approved job posts: " + e.getMessage());
        }
        return posts;
    }

    public List<JobPost> getRejectedJobPosts() {
        List<JobPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE Status = 'rejected' ORDER BY CreatedAt DESC";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                posts.add(extractJobPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving rejected job posts: " + e.getMessage());
        }
        return posts;
    }

    public int getTotalPendingCount() {
        String sql = "SELECT COUNT(*) AS count FROM Posts WHERE Status = 'pending'";
        return getCount(sql);
    }

    public int getTodaySubmittedCount() {
        String sql = "SELECT COUNT(*) AS count FROM Posts WHERE Status = 'pending' AND CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)";
        return getCount(sql);
    }

    public int getUrgentReviewCount() {
        String sql = "SELECT COUNT(*) AS count FROM Posts WHERE Status = 'pending' AND DATEDIFF(day, CreatedAt, GETDATE()) > 3";
        return getCount(sql);
    }

    public double getAverageReviewTime() {
        String sql = "SELECT AVG(DATEDIFF(day, CreatedAt, UpdatedAt)) AS avgTime FROM Posts WHERE Status != 'pending'";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("avgTime");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public int getActiveJobsCount(String companyId) {
        String sql = "SELECT COUNT(*) FROM Posts WHERE CompanyID = ? AND (ApplicationDeadline IS NULL OR ApplicationDeadline >= GETDATE()) AND Status = 'approved'";
        try (Connection conn = getConnection();
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

    public boolean updateJobPostStatus(String jobId, String status, String notes) {
        String sql = "UPDATE Posts SET Status = ?, AdminNotes = ?, UpdatedAt = GETDATE() WHERE JobID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, notes);
            stmt.setString(3, jobId);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                JobPost jobPost = getJobPostById(jobId);
                if (jobPost != null) {
                    notificationSubject.notifyObservers(jobPost, status);
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating job post status: " + e.getMessage());
            return false;
        }
    }


    public int getJobsCount() {
        String sql = "SELECT COUNT(*) FROM Posts";
        try (Connection conn = getConnection();
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

    private int getCount(String sql) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private String formatForDisplay(String text) {
        if (text == null || text.trim().isEmpty()) {
            return "N/A";
        }
        return text.replace("_", " ");
    }

    private JobPost extractJobPost(ResultSet rs) throws SQLException {
        JobPost post = new JobPost();
        post.setJobId(rs.getString("JobID"));
        post.setCompanyId(rs.getString("CompanyID"));
        post.setCompanyName(rs.getString("CompanyName"));
        post.setJobTitle(rs.getString("JobTitle"));
        post.setWorkMode(rs.getString("WorkMode"));
        post.setLocation(rs.getString("Location"));
        post.setEmploymentType(rs.getString("EmploymentType"));
        post.setJobDescription(rs.getString("JobDescription"));
        post.setRequiredSkills(rs.getString("RequiredSkills"));
        post.setExperienceLevel(rs.getString("ExperienceLevel"));
        post.setApplicationDeadline(rs.getDate("ApplicationDeadline"));
        post.setSalaryRange(rs.getString("SalaryRange"));
        post.setWorkingHoursShifts(rs.getString("WorkingHoursShifts"));
        post.setStatus(rs.getString("Status"));
        post.setAdminNotes(rs.getString("AdminNotes"));
        post.setCreatedAt(rs.getTimestamp("CreatedAt"));
        post.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return post;
    }

    public static void main(String[] args) {
        JobPostDAO dao = new JobPostDAO();
        List<JobPost> jobs = dao.getAllJobPosts();
        System.out.println("Total jobs found: " + jobs.size());
        for (JobPost job : jobs) {
            System.out.println("Job Title: " + job.getJobTitle());
            System.out.println("Company: " + job.getCompanyName());
            System.out.println("Location: " + job.getLocation());
            System.out.println("Work Mode: " + job.getWorkMode());
            System.out.println("Salary: " + job.getSalaryRange());
            System.out.println("Status: " + job.getStatus());
            System.out.println("---------------------------");
        }
    }

    public List<JobPost> getAllExpiredJobPosts() {
        List<JobPost> expiredJobs = new ArrayList<>();
        String sql = "SELECT JobID AS job_id, JobTitle AS job_title, CompanyName AS company_name, Location AS location, " +
                "EmploymentType AS employment_type, WorkMode AS work_mode, SalaryRange AS salary_range, " +
                "ApplicationDeadline AS application_deadline FROM Posts WHERE ApplicationDeadline < GETDATE()";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                JobPost job = new JobPost();
                job.setJobId(rs.getString("job_id"));
                job.setJobTitle(rs.getString("job_title"));
                job.setCompanyName(rs.getString("company_name"));
                job.setLocation(rs.getString("location"));
                job.setEmploymentType(rs.getString("employment_type"));
                job.setWorkMode(rs.getString("work_mode"));
                job.setSalaryRange(rs.getString("salary_range"));
                job.setApplicationDeadline(rs.getDate("application_deadline"));
                expiredJobs.add(job);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching expired job posts: " + e.getMessage());
            e.printStackTrace();
        }

        return expiredJobs;
    }
}