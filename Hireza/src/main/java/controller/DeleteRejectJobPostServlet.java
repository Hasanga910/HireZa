package controller;

import dao.JobPostDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/DeleteRejectJobPostServlet")
public class DeleteRejectJobPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Check if user is logged in and has admin privileges
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            sendErrorResponse(response, "Unauthorized access");
            return;
        }

        PrintWriter out = response.getWriter();

        try {
            // Get job ID from request - as String to match JobPost class
            String jobId = request.getParameter("jobId");

            if (jobId == null || jobId.trim().isEmpty()) {
                sendErrorResponse(out, "Job ID is required");
                return;
            }

            // Remove any whitespace
            jobId = jobId.trim();

            // Validate job ID format (should be like P001, P002, etc.)
            if (!jobId.matches("^P\\d+$")) {
                sendErrorResponse(out, "Invalid Job ID format. Expected format: P001, P002, etc.");
                return;
            }

            JobPostDAO jobPostDAO = new JobPostDAO();
            boolean success = jobPostDAO.deleteJobPostById(jobId);

            if (success) {
                sendSuccessResponse(out, "Job post deleted successfully");
                System.out.println("Job post with ID " + jobId + " deleted successfully");
            } else {
                sendErrorResponse(out, "Job post not found or already deleted");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(out, "System error: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST requests or show error for GET
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        sendErrorResponse(out, "GET method not supported. Use POST.");
    }

    private void sendSuccessResponse(PrintWriter out, String message) {
        out.print("{\"success\": true, \"message\": \"" + message + "\"}");
        out.flush();
    }

    private void sendErrorResponse(PrintWriter out, String message) {
        out.print("{\"success\": false, \"message\": \"" + message + "\"}");
        out.flush();
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        sendErrorResponse(out, message);
    }
}