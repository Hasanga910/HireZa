package controller;

import dao.JobPostDAO;
import model.JobPost;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class JobSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("JobSearchServlet doGet() called");

            // Fetch only approved job posts
            JobPostDAO dao = new JobPostDAO();
            List<JobPost> jobs = dao.getApprovedJobPosts();

            request.setAttribute("jobList", jobs);
            request.getRequestDispatcher("/jobseeker/Searchjobs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error retrieving job posts: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("JobSearchServlet doPost() called");

            // Handle search form submission
            String keyword = request.getParameter("keyword");
            String location = request.getParameter("location");

            JobPostDAO dao = new JobPostDAO();
            List<JobPost> jobs;

            if ((keyword != null && !keyword.trim().isEmpty()) ||
                    (location != null && !location.trim().isEmpty())) {
                // Search only in approved jobs
                jobs = dao.searchApprovedJobs(keyword, location);
                request.setAttribute("searchPerformed", true);
                request.setAttribute("searchKeyword", keyword);
                request.setAttribute("searchLocation", location);
            } else {
                // Get only approved jobs
                jobs = dao.getApprovedJobPosts();
                request.setAttribute("searchPerformed", false);
            }

            request.setAttribute("jobList", jobs);
            request.getRequestDispatcher("/jobseeker/Searchjobs.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error processing search: " + e.getMessage());
        }
    }
}