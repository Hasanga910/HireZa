package controller;

import dao.CompanyDAO;
import dao.JobPostDAO;
import model.Company;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/company/jobs/delete")
public class DeleteJobServlet extends HttpServlet {

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

        Company company = companyDAO.getCompanyByUserId(user.getId());
        if (company == null) {
            response.sendRedirect(request.getContextPath() + "/company/jobs");
            return;
        }

        String jobId = request.getParameter("id");
        boolean isDeleted = jobPostDAO.deleteJobPost(jobId, company.getCompanyId());

        response.sendRedirect(request.getContextPath() + "/company/jobs");
    }
}