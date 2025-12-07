
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/company/jobs/post")
public class PostJobServlet extends HttpServlet {

    private JobPostDAO jobPostDAO = new JobPostDAO();
    private CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"Employer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Fetch company to check if profile is completed
        Company company = companyDAO.getCompanyByUserId(user.getId());
        if (company == null || !company.isProfileCompleted()) {
            response.sendRedirect(request.getContextPath() + "/company/profile?error=complete_profile");
            return;
        }

        request.setAttribute("company", company);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Employer/post_job.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"Employer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        Company company = companyDAO.getCompanyByUserId(user.getId());
        if (company == null) {
            response.sendRedirect(request.getContextPath() + "/company/jobs/post?error=1");
            return;
        }

        // Retrieve form parameters
        String jobTitle = request.getParameter("jobTitle");
        String workMode = request.getParameter("workMode");
        String location = request.getParameter("location");
        String employmentType = request.getParameter("employmentType");
        String jobDescription = request.getParameter("jobDescription");
        String requiredSkills = request.getParameter("requiredSkills");
        String experienceLevel = request.getParameter("experienceLevel");
        String applicationDeadlineStr = request.getParameter("applicationDeadline");
        Date applicationDeadline = null;
        if (applicationDeadlineStr != null && !applicationDeadlineStr.isEmpty()) {
            try {
                applicationDeadline = new SimpleDateFormat("yyyy-MM-dd").parse(applicationDeadlineStr);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        String salaryRange = request.getParameter("salaryRange");
        String workingHoursShifts = request.getParameter("workingHoursShifts");

        // Create JobPost object
        JobPost post = new JobPost(company.getCompanyId(), company.getCompanyName(), jobTitle, workMode, location,
                employmentType, jobDescription, requiredSkills, experienceLevel, applicationDeadline, salaryRange, workingHoursShifts);

        // Save to database
        boolean isSaved = jobPostDAO.saveJobPost(post);

        if (isSaved) {
            response.sendRedirect(request.getContextPath() + "/company/jobs");
        } else {
            response.sendRedirect(request.getContextPath() + "/company/jobs/post?error=1");
        }
    }
}