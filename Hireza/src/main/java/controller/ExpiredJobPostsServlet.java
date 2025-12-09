package controller;

import dao.JobPostDAO;
import model.JobPost;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/ExpiredJobPostsServlet")
public class ExpiredJobPostsServlet extends HttpServlet {
    private JobPostDAO jobPostDAO = new JobPostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and has Admin Assistant role
        User loggedInUser = (User) request.getSession().getAttribute("user");
        if (loggedInUser == null || !"AdminAssistant".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        try {
            // Fetch expired job posts
            List<JobPost> expiredJobs = jobPostDAO.getAllExpiredJobPosts();
            request.setAttribute("expiredJobs", expiredJobs);

            // Forward to JSP
            request.getRequestDispatcher("/Assistant/ExpiredJobPosts.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error fetching expired job posts: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading expired job posts. Please try again later.");
            request.getRequestDispatcher("/Assistant/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and has Admin Assistant role
        User loggedInUser = (User) request.getSession().getAttribute("user");
        if (loggedInUser == null || !"AdminAssistant".equals(loggedInUser.getRole())) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"message\": \"Unauthorized access\"}");
            out.flush();
            return;
        }

        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("delete".equals(action)) {
            String jobId = request.getParameter("jobId");
            String notes = request.getParameter("notes");

            if (jobId == null || jobId.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"Job ID is required\"}");
                out.flush();
                return;
            }

            try {
                // Delegate deletion to DeleteRejectJobPostServlet's logic
                JobPostDAO jobPostDAO = new JobPostDAO();
                boolean success = jobPostDAO.deleteJobPostById(jobId.trim());

                if (success) {
                    out.print("{\"success\": true, \"message\": \"Job post deleted successfully\"}");
                    System.out.println("Expired job post with ID " + jobId + " deleted successfully");
                } else {
                    out.print("{\"success\": false, \"message\": \"Job post not found or already deleted\"}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("{\"success\": false, \"message\": \"System error: " + e.getMessage() + "\"}");
            }
            out.flush();
        } else {
            // Fallback to GET behavior for other POST requests
            doGet(request, response);
        }
    }
}