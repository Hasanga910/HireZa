package controller;

import dao.CompanyDAO;
import dao.JobApplicationDAO;
import dao.JobPostDAO;
import model.Company;
import model.JobApplication;
import model.JobPost;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/company/employer/applications")
public class EmployerViewApplicationsServlet extends HttpServlet {
    private JobApplicationDAO applicationDAO = new JobApplicationDAO();
    private JobPostDAO jobPostDAO = new JobPostDAO();
    private CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String jobId = request.getParameter("jobId");

        if (jobId == null || jobId.trim().isEmpty()) {
            // If no jobId provided, show all jobs to select
            List<?> posts = jobPostDAO.getAllJobPostsByCompanyId(company.getCompanyId());
            request.setAttribute("posts", posts);
            request.getRequestDispatcher("/Employer/select_job.jsp").forward(request, response);
            return;
        }

        // Check if the job exists and belongs to this company
        JobPost jobPost = jobPostDAO.getJobPostById(jobId);
        if (jobPost == null || !jobPost.getCompanyId().equals(company.getCompanyId())) {
            // If job doesn't exist or doesn't belong to this company, show all jobs to select
            List<?> posts = jobPostDAO.getAllJobPostsByCompanyId(company.getCompanyId());
            request.setAttribute("posts", posts);
            request.getRequestDispatcher("/Employer/select_job.jsp").forward(request, response);
            return;
        }

        // Fetch applications for this job (String IDs)
        List<JobApplication> applications = applicationDAO.getApplicationsByJobId(jobId);
        request.setAttribute("applications", applications);
        request.setAttribute("jobId", jobId);
        request.getRequestDispatcher("/Employer/employer_view_applications.jsp").forward(request, response);
    }
}