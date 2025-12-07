package controller;

import dao.CompanyDAO;
import dao.JobApplicationDAO;
import dao.JobPostDAO;
import dao.RecruiterDAO;
import model.Company;
import model.JobApplication;
import model.JobPost;
import model.Recruiter;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/company/dashboard/charts")
public class CompanyDashboardChartsServlet extends HttpServlet {

    private JobPostDAO jobPostDAO = new JobPostDAO();
    private JobApplicationDAO jobApplicationDAO = new JobApplicationDAO();
    private CompanyDAO companyDAO = new CompanyDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"Employer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Get company
        Company company = companyDAO.getCompanyByUserId(user.getId());
        if (company == null) {
            response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");
            return;
        }

        String companyId = company.getCompanyId();

        // Fetch data for charts
        List<JobPost> posts = jobPostDAO.getAllJobPostsByCompanyId(companyId);
        List<JobApplication> applications = jobApplicationDAO.getApplicationsByCompanyId(companyId);
        List<Recruiter> recruiters = recruiterDAO.getRecruitersByCompanyId(companyId);

        // Set as request attributes
        request.setAttribute("posts", posts);
        request.setAttribute("applications", applications);
        request.setAttribute("recruiters", recruiters);
        request.setAttribute("company", company);

        request.getRequestDispatcher("/Employer/company_dashboard_charts.jsp")
                .forward(request, response);
    }
}
