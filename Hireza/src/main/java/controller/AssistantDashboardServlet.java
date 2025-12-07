package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.CompanyDAO;
import dao.JobPostDAO;
import model.Company;
import model.JobPost;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet("/AssistantDashboardServlet")
public class AssistantDashboardServlet extends HttpServlet {
    private JobPostDAO jobPostDAO;
    private CompanyDAO companyDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        jobPostDAO = new JobPostDAO();
        companyDAO = new CompanyDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JsonObject jsonResponse = new JsonObject();

        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "User not logged in");
                out.print(jsonResponse.toString());
                return;
            }

            String action = request.getParameter("action");
            if (action == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Action parameter missing");
                out.print(jsonResponse.toString());
                return;
            }

            switch (action) {
                case "getDashboardStats":
                    getDashboardStats(jsonResponse);
                    break;
                case "getRecentJobPosts":
                    getRecentJobPosts(jsonResponse);
                    break;
                case "getPendingPosts":
                    getPendingPosts(jsonResponse);
                    break;
                case "getApprovedPosts":
                    getApprovedPosts(jsonResponse);
                    break;
                case "getRejectedPosts":
                    getRejectedPosts(jsonResponse);
                    break;
                default:
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Invalid action");
                    break;
            }

            out.print(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JsonObject jsonResponse = new JsonObject();

        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "User not logged in");
                out.print(jsonResponse.toString());
                return;
            }

            String action = request.getParameter("action");
            if (action == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Action parameter missing");
                out.print(jsonResponse.toString());
                return;
            }

            switch (action) {
                case "updateJobPostStatus":
                    updateJobPostStatus(request, jsonResponse);
                    break;
                case "deleteJobPost":
                    deleteJobPost(request, jsonResponse);
                    break;
                default:
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "Invalid action");
                    break;
            }

            out.print(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================== DASHBOARD DATA METHODS ==================

    private void getDashboardStats(JsonObject jsonResponse) {
        try {
            int pendingCount = jobPostDAO.getTotalPendingCount();
            int approvedCount = jobPostDAO.getApprovedJobPosts().size();
            int rejectedCount = jobPostDAO.getRejectedJobPosts().size();
            int todaySubmittedCount = jobPostDAO.getTodaySubmittedCount();
            int urgentReviewCount = jobPostDAO.getUrgentReviewCount();
            double averageReviewTime = jobPostDAO.getAverageReviewTime();

            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("pendingCount", pendingCount);
            jsonResponse.addProperty("approvedCount", approvedCount);
            jsonResponse.addProperty("rejectedCount", rejectedCount);
            jsonResponse.addProperty("todaySubmittedCount", todaySubmittedCount);
            jsonResponse.addProperty("urgentReviewCount", urgentReviewCount);
            jsonResponse.addProperty("averageReviewTime", averageReviewTime);
            jsonResponse.addProperty("remindersSent", todaySubmittedCount); // Example placeholder
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error retrieving dashboard stats");
        }
    }

    private void getRecentJobPosts(JsonObject jsonResponse) {
        try {
            List<JobPost> recentPosts = jobPostDAO.getAllJobPosts();
            if (recentPosts.size() > 10) {
                recentPosts = recentPosts.subList(0, 10);
            }

            List<Map<String, Object>> postsWithIndustry = new ArrayList<>();
            for (JobPost post : recentPosts) {
                Map<String, Object> postData = new HashMap<>();
                postData.put("jobId", post.getJobId());
                postData.put("jobTitle", post.getJobTitle());
                postData.put("companyName", post.getCompanyName());
                postData.put("companyId", post.getCompanyId());
                postData.put("workMode", post.getWorkMode());
                postData.put("location", post.getLocation());
                postData.put("employmentType", post.getEmploymentType());
                postData.put("salaryRange", post.getSalaryRange());
                postData.put("status", post.getStatus());
                postData.put("createdAt", post.getCreatedAt());

                // Get industry from Company table
                String industry = "Not Specified";
                String companyId = String.valueOf(post.getCompanyId()); // get String ID
                if (companyId != null && !companyId.trim().isEmpty()) {
                    Company company = companyDAO.getCompanyByCompanyId(companyId); // pass String
                    if (company != null && company.getIndustry() != null && !company.getIndustry().trim().isEmpty()) {
                        industry = company.getIndustry();
                    }
                }
                postData.put("industry", industry);

                postsWithIndustry.add(postData);
            }

            jsonResponse.addProperty("success", true);
            jsonResponse.add("recentPosts", gson.toJsonTree(postsWithIndustry));

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error retrieving recent job posts: " + e.getMessage());
        }
    }


    private void getPendingPosts(JsonObject jsonResponse) {
        try {
            List<JobPost> pendingPosts = jobPostDAO.getPendingJobPosts();
            jsonResponse.addProperty("success", true);
            jsonResponse.add("posts", gson.toJsonTree(pendingPosts));
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error retrieving pending posts");
        }
    }

    private void getApprovedPosts(JsonObject jsonResponse) {
        try {
            List<JobPost> approvedPosts = jobPostDAO.getApprovedJobPosts();
            jsonResponse.addProperty("success", true);
            jsonResponse.add("posts", gson.toJsonTree(approvedPosts));
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error retrieving approved posts");
        }
    }

    private void getRejectedPosts(JsonObject jsonResponse) {
        try {
            List<JobPost> rejectedPosts = jobPostDAO.getRejectedJobPosts();
            jsonResponse.addProperty("success", true);
            jsonResponse.add("posts", gson.toJsonTree(rejectedPosts));
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error retrieving rejected posts");
        }
    }

    private void updateJobPostStatus(HttpServletRequest request, JsonObject jsonResponse) {
        try {
            // Treat Job ID as String
            String jobId = request.getParameter("jobId");
            String status = request.getParameter("status");
            String notes = request.getParameter("notes");

            // Update the job post status using String jobId
            boolean success = jobPostDAO.updateJobPostStatus(jobId, status, notes);

            jsonResponse.addProperty("success", success);
            jsonResponse.addProperty("message",
                    success ? "Job post status updated successfully" : "Failed to update job post status");

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error updating job post status");
        }
    }

    private void deleteJobPost(HttpServletRequest request, JsonObject jsonResponse) {
        try {
            String jobId = request.getParameter("jobId");

            if (jobId == null || jobId.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Job ID parameter is required");
                return;
            }

            jobId = jobId.trim();
            boolean success = jobPostDAO.deleteJobPostById(jobId);

            jsonResponse.addProperty("success", success);
            jsonResponse.addProperty("message",
                    success ? "Job post deleted successfully" : "Failed to delete job post");

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error deleting job post: " + e.getMessage());
        }
    }
}
