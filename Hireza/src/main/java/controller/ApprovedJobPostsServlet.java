package controller;

import dao.JobPostDAO;
import model.JobPost;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/approved-job-posts")
public class ApprovedJobPostsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private JobPostDAO jobPostDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        jobPostDAO = new JobPostDAO();
        gson = new Gson();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            if ("getStatistics".equals(action)) {
                getStatistics(response, out);
            } else if ("getJobDetails".equals(action)) {
                getJobDetails(request, response, out);
            } else {
                getAllApprovedJobs(request, response, out);
            }
        } catch (Exception e) {
            sendErrorResponse(response, out, "Error processing request: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            if ("sendReminder".equals(action)) {
                sendReminder(request, response, out);
            } else if ("sendBulkReminders".equals(action)) {
                sendBulkReminders(request, response, out);
            } else if ("exportData".equals(action)) {
                exportData(request, response, out);
            } else {
                sendErrorResponse(response, out, "Invalid action specified");
            }
        } catch (Exception e) {
            sendErrorResponse(response, out, "Error processing request: " + e.getMessage());
        }
    }

    private void getAllApprovedJobs(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        try {
            // Get pagination parameters
            int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
            int limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "10");
            int offset = (page - 1) * limit;

            // Get filter parameters
            String category = request.getParameter("category");
            String company = request.getParameter("company");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");

            // Get only approved job posts directly from DAO
            List<JobPost> approvedJobs = jobPostDAO.getApprovedJobPosts();

            // Apply filters
            List<JobPost> filteredJobs = applyFilters(approvedJobs, category, company, dateFrom, dateTo);

            // Apply pagination
            int total = filteredJobs.size();
            int start = Math.min(offset, total);
            int end = Math.min(offset + limit, total);
            List<JobPost> paginatedJobs = filteredJobs.subList(start, end);

            // Prepare response
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("jobs", paginatedJobs);
            responseData.put("total", total);
            responseData.put("page", page);
            responseData.put("limit", limit);
            responseData.put("totalPages", (int) Math.ceil((double) total / limit));

            out.print(gson.toJson(responseData));
            out.flush();

        } catch (Exception e) {
            sendErrorResponse(response, out, "Error retrieving approved jobs: " + e.getMessage());
        }
    }

    private List<JobPost> applyFilters(List<JobPost> jobs, String category, String company, String dateFrom, String dateTo) {
        // Filter by category (based on job title keywords)
        if (category != null && !category.isEmpty() && !"all".equals(category)) {
            jobs.removeIf(post -> !getCategoryFromJobTitle(post.getJobTitle()).equalsIgnoreCase(category));
        }

        // Filter by company
        if (company != null && !company.isEmpty()) {
            jobs.removeIf(post -> !post.getCompanyName().toLowerCase().contains(company.toLowerCase()));
        }

        // Filter by date range - SIMPLIFIED VERSION
        if (dateFrom != null && !dateFrom.isEmpty()) {
            java.sql.Date fromDate = java.sql.Date.valueOf(dateFrom);
            jobs.removeIf(post -> post.getCreatedAt() == null ||
                    post.getCreatedAt().before(fromDate));
        }

        if (dateTo != null && !dateTo.isEmpty()) {
            java.sql.Date toDate = java.sql.Date.valueOf(dateTo);
            jobs.removeIf(post -> post.getCreatedAt() == null ||
                    post.getCreatedAt().after(toDate));
        }

        return jobs;
    }

    private String getCategoryFromJobTitle(String jobTitle) {
        if (jobTitle == null) return "General";

        String title = jobTitle.toLowerCase();
        if (title.contains("java") || title.contains("developer") ||
                title.contains("software") || title.contains("engineer") ||
                title.contains("programmer") || title.contains("it")) {
            return "Technology";
        } else if (title.contains("marketing") || title.contains("sales") ||
                title.contains("advertising") || title.contains("brand")) {
            return "Marketing";
        } else if (title.contains("finance") || title.contains("account") ||
                title.contains("audit") || title.contains("tax")) {
            return "Finance";
        } else if (title.contains("health") || title.contains("nurse") ||
                title.contains("doctor") || title.contains("medical") ||
                title.contains("care") || title.contains("hospital")) {
            return "Healthcare";
        } else if (title.contains("teacher") || title.contains("professor") ||
                title.contains("educator") || title.contains("instructor")) {
            return "Education";
        } else if (title.contains("manager") || title.contains("director") ||
                title.contains("executive") || title.contains("lead")) {
            return "Management";
        } else {
            return "General";
        }
    }

    private void getStatistics(HttpServletResponse response, PrintWriter out) {
        try {
            // Get only approved jobs directly
            List<JobPost> approvedJobs = jobPostDAO.getApprovedJobPosts();

            int totalApproved = approvedJobs.size();

            // Count today's approved posts - SIMPLIFIED
            long todayApproved = approvedJobs.stream()
                    .filter(post -> post.getCreatedAt() != null)
                    .filter(post -> {
                        java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
                        java.sql.Date postDate = new java.sql.Date(post.getCreatedAt().getTime());
                        return postDate.equals(today);
                    })
                    .count();

            // Count by category
            Map<String, Integer> categoryCounts = new HashMap<>();
            for (JobPost post : approvedJobs) {
                String category = getCategoryFromJobTitle(post.getJobTitle());
                categoryCounts.put(category, categoryCounts.getOrDefault(category, 0) + 1);
            }

            Map<String, Object> stats = new HashMap<>();
            stats.put("totalApproved", totalApproved);
            stats.put("todayApproved", todayApproved);
            stats.put("categoryCounts", categoryCounts);

            out.print(gson.toJson(stats));
            out.flush();

        } catch (Exception e) {
            sendErrorResponse(response, out, "Error retrieving statistics: " + e.getMessage());
        }
    }

    private void getJobDetails(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        try {
            String jobId = request.getParameter("jobId"); // keep as String
            if (jobId == null || jobId.isEmpty()) {
                sendErrorResponse(response, out, "Job ID is missing");
                return;
            }

            JobPost job = jobPostDAO.getJobPostById(jobId); // getJobPostById(String jobId)

            if (job != null && "approved".equals(job.getStatus())) {
                Map<String, Object> jobDetails = new HashMap<>();
                jobDetails.put("jobId", job.getJobId());
                jobDetails.put("jobTitle", job.getJobTitle());
                jobDetails.put("companyName", job.getCompanyName());
                jobDetails.put("workMode", job.getWorkMode());
                jobDetails.put("location", job.getLocation());
                jobDetails.put("employmentType", job.getEmploymentType());
                jobDetails.put("jobDescription", job.getJobDescription());
                jobDetails.put("requiredSkills", job.getRequiredSkills());
                jobDetails.put("experienceLevel", job.getExperienceLevel());
                jobDetails.put("applicationDeadline", job.getApplicationDeadline());
                jobDetails.put("salaryRange", job.getSalaryRange());
                jobDetails.put("workingHoursShifts", job.getWorkingHoursShifts());
                jobDetails.put("createdAt", job.getCreatedAt());
                jobDetails.put("category", getCategoryFromJobTitle(job.getJobTitle()));

                out.print(gson.toJson(jobDetails));
            } else {
                sendErrorResponse(response, out, "Job not found or not approved");
            }
            out.flush();

        } catch (Exception e) {
            sendErrorResponse(response, out, "Error retrieving job details: " + e.getMessage());
        }
    }


    private void sendReminder(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        try {
            String jobId = request.getParameter("jobId"); // keep as String
            String reminderType = request.getParameter("reminderType");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            // Validate job exists and is approved
            if (jobId == null || jobId.isEmpty()) {
                sendErrorResponse(response, out, "Job ID is missing");
                return;
            }

            JobPost job = jobPostDAO.getJobPostById(jobId); // use String version
            if (job == null || !"approved".equals(job.getStatus())) {
                sendErrorResponse(response, out, "Job not found or not approved");
                return;
            }

            // Integrate with your email service
            boolean sent = sendEmailNotification(job, reminderType, subject, message);

            Map<String, Object> result = new HashMap<>();
            if (sent) {
                result.put("success", true);
                result.put("message", "Reminder sent successfully");
                // Log the reminder in database if needed
                logReminder(jobId, reminderType, subject, message);
            } else {
                result.put("success", false);
                result.put("message", "Failed to send reminder");
            }

            out.print(gson.toJson(result));
            out.flush();

        } catch (Exception e) {
            sendErrorResponse(response, out, "Error sending reminder: " + e.getMessage());
        }
    }


    private void sendBulkReminders(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        try {
            String[] jobIds = request.getParameterValues("jobIds");
            String reminderType = request.getParameter("reminderType");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            if (jobIds == null || jobIds.length == 0) {
                sendErrorResponse(response, out, "No jobs selected");
                return;
            }

            int successCount = 0;
            int failCount = 0;

            for (String jobIdStr : jobIds) {
                try {
                    // Use jobIdStr directly as String
                    JobPost job = jobPostDAO.getJobPostById(jobIdStr);

                    if (job != null && "approved".equals(job.getStatus())) {
                        if (sendEmailNotification(job, reminderType, subject, message)) {
                            successCount++;
                            logReminder(jobIdStr, reminderType, subject, message); // logReminder should also accept String
                        } else {
                            failCount++;
                        }
                    } else {
                        failCount++;
                    }
                } catch (Exception e) {
                    failCount++;
                }
            }


            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("message", String.format("Reminders sent: %d successful, %d failed", successCount, failCount));
            result.put("successCount", successCount);
            result.put("failCount", failCount);

            out.print(gson.toJson(result));
            out.flush();

        } catch (Exception e) {
            sendErrorResponse(response, out, "Error sending bulk reminders: " + e.getMessage());
        }
    }

    private void exportData(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        try {
            String format = request.getParameter("format");
            // Get only approved jobs directly
            List<JobPost> approvedJobs = jobPostDAO.getApprovedJobPosts();

            // Prepare export data
            Map<String, Object> exportData = new HashMap<>();
            exportData.put("format", format);
            exportData.put("totalRecords", approvedJobs.size());
            exportData.put("exportDate", new java.util.Date());
            exportData.put("jobs", approvedJobs);

            // In a real implementation, you would generate the file here
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("message", String.format("Export prepared: %d records for %s format",
                    approvedJobs.size(), format.toUpperCase()));
            result.put("downloadUrl", "/downloads/approved-jobs." + format.toLowerCase());

            out.print(gson.toJson(result));
            out.flush();

        } catch (Exception e) {
            sendErrorResponse(response, out, "Error exporting data: " + e.getMessage());
        }
    }

    private boolean sendEmailNotification(JobPost job, String reminderType, String subject, String message) {
        // Implement your email sending logic here
        try {
            // Simulate email sending
            System.out.println("Sending email to company: " + job.getCompanyName());
            System.out.println("Subject: " + subject);
            System.out.println("Message: " + message);
            System.out.println("Job: " + job.getJobTitle());

            return true;
        } catch (Exception e) {
            System.err.println("Error sending email: " + e.getMessage());
            return false;
        }
    }

    private void logReminder(String jobId, String reminderType, String subject, String message) {
        // Implement reminder logging to database if needed
        System.out.println("Logged reminder for job ID: " + jobId + ", type: " + reminderType);
    }

    private void sendErrorResponse(HttpServletResponse response, PrintWriter out, String errorMessage) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        Map<String, Object> error = new HashMap<>();
        error.put("success", false);
        error.put("message", errorMessage);
        out.print(gson.toJson(error));
        out.flush();
    }
}