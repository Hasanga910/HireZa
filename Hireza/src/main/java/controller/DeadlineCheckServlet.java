package controller;

import dao.CompanyDAO;
import dao.JobPostDAO;
import model.Company;
import model.JobPost;
import model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

@WebServlet("/company/jobs/deadline-check")
public class DeadlineCheckServlet extends HttpServlet {

    private JobPostDAO jobPostDAO = new JobPostDAO();
    private CompanyDAO companyDAO = new CompanyDAO();

    /**
     * Inner class to hold job post with deadline information
     */
    public static class DeadlineInfo {
        private JobPost jobPost;
        private long daysPassed;

        public DeadlineInfo(JobPost jobPost, long daysPassed) {
            this.jobPost = jobPost;
            this.daysPassed = daysPassed;
        }

        public JobPost getJobPost() {
            return jobPost;
        }

        public void setJobPost(JobPost jobPost) {
            this.jobPost = jobPost;
        }

        public long getDaysPassed() {
            return daysPassed;
        }

        public void setDaysPassed(long daysPassed) {
            this.daysPassed = daysPassed;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"Employer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        Company company = companyDAO.getCompanyByUserId(user.getId());
        if (company == null) {
            response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");
            return;
        }

        // Get all job posts for this company
        List<JobPost> allPosts = jobPostDAO.getAllJobPostsByCompanyId(company.getCompanyId());

        // Separate active and expired posts
        List<JobPost> activePosts = new ArrayList<>();
        List<DeadlineInfo> expiredPosts = new ArrayList<>();

        Date today = new Date();

        for (JobPost post : allPosts) {
            Date deadline = post.getApplicationDeadline();

            if (deadline != null && deadline.before(today)) {
                // Calculate days passed since deadline
                long diffInMillis = today.getTime() - deadline.getTime();
                long daysPassed = TimeUnit.MILLISECONDS.toDays(diffInMillis);

                expiredPosts.add(new DeadlineInfo(post, daysPassed));
            } else {
                // Post is still active (no deadline or deadline not reached)
                activePosts.add(post);
            }
        }

        // Set attributes for JSP
        request.setAttribute("activePosts", activePosts);
        request.setAttribute("expiredPosts", expiredPosts);
        request.setAttribute("company", company);

        // Forward to manage jobs JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Employer/manage_jobs.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST requests to GET
        doGet(request, response);
    }
}