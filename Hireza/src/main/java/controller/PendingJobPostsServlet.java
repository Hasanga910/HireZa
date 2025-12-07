package controller;

import dao.JobPostDAO;
import model.JobPost;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/PendingJobPostsServlet")
public class PendingJobPostsServlet extends HttpServlet {
    private JobPostDAO jobPostDAO;

    @Override
    public void init() {
        jobPostDAO = new JobPostDAO();
        System.out.println("PendingJobPostsServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<JobPost> pendingJobs = jobPostDAO.getPendingJobPosts();
            request.setAttribute("pendingJobs", pendingJobs);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Assistant/Pending-job-posts.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving pending job posts: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        String jobId = request.getParameter("jobId");

        System.out.println("Action: " + action + ", Job ID: " + jobId);

        if (action == null || action.trim().isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Action parameter is required.\"}");
            return;
        }

        if (jobId == null || jobId.trim().isEmpty()) {
            out.write("{\"success\": false, \"message\": \"Job ID parameter is required.\"}");
            return;
        }

        try {
            jobId = jobId.trim();

            // Verify job exists
            JobPost job = jobPostDAO.getJobPostById(jobId);
            if (job == null) {
                out.write("{\"success\": false, \"message\": \"Job post not found with ID: \" + jobId}");
                return;
            }

            // Verify pending status
            if (!"pending".equalsIgnoreCase(job.getStatus())) {
                out.write("{\"success\": false, \"message\": \"Job post is not in pending status. Current status: \" + job.getStatus()}");
                return;
            }

            // Process approval or rejection
            if ("approve".equalsIgnoreCase(action)) {
                processApproval(request, jobId, out);
            } else if ("reject".equalsIgnoreCase(action)) {
                processRejection(request, jobId, out);
            } else {
                out.write("{\"success\": false, \"message\": \"Invalid action. Use 'approve' or 'reject'\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Internal server error: \" + e.getMessage()}");
        }
    }

    private void processApproval(HttpServletRequest request, String jobId, PrintWriter out) {
        try {
            String notes = request.getParameter("notes");
            if (notes == null) notes = "";

            boolean success = jobPostDAO.updateJobPostStatus(jobId, "approved", notes);

            if (success) {
                out.write("{\"success\": true, \"message\": \"Job post approved successfully!\"}");
            } else {
                out.write("{\"success\": false, \"message\": \"Database update failed. Job was not approved.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Approval process failed: \" + e.getMessage()}");
        }
    }

    private void processRejection(HttpServletRequest request, String jobId, PrintWriter out) {
        try {
            String rejectionDetails = request.getParameter("rejectionDetails");
            if (rejectionDetails == null) rejectionDetails = "";

            // Store the rejection reason directly in AdminNotes
            boolean success = jobPostDAO.updateJobPostStatus(jobId, "rejected", rejectionDetails.trim());

            if (success) {
                out.write("{\"success\": true, \"message\": \"Job post rejected successfully!\"}");
            } else {
                out.write("{\"success\": false, \"message\": \"Database update failed. Job was not rejected.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Rejection process failed: \" + e.getMessage()}");
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}