// package controller;
// Add this new class: ManageJobsServlet.java
// This servlet handles listing jobs (GET) for the manage page.
// Mapped to /company/jobs as per your dashboard link.
// Forwards to /Employer/manage_posts.jsp (note: used "posts" in filename as per your instruction).

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
import java.util.List;

@WebServlet("/company/jobs")
public class ManageJobsServlet extends HttpServlet {

    private JobPostDAO jobPostDAO = new JobPostDAO();
    private CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Ensure the user is an employer
        if (user == null || !"Employer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Get the company linked to the logged-in user
        Company company = companyDAO.getCompanyByUserId(user.getId());
        if (company == null) {
            response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");
            return;
        }

        // Get all job posts for this company
        // Make sure DAO method accepts String companyId now
        List<JobPost> posts = jobPostDAO.getAllJobPostsByCompanyId(company.getCompanyId());

        request.setAttribute("posts", posts);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Employer/manage_posts.jsp");
        dispatcher.forward(request, response);
    }
}

