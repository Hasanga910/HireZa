package controller;

import dao.CompanyDAO;
import dao.RecruiterActivityDAO;
import model.Company;
import model.RecruiterActivityLog;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/company/recruiter-activity")
public class RecruiterActivityServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User employer = (User) request.getSession().getAttribute("user");
            if (employer == null || !"Employer".equals(employer.getRole())) {
                response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
                return;
            }

            CompanyDAO companyDAO = new CompanyDAO();
            Company company = companyDAO.getCompanyByUserId(employer.getId());
            if (company == null) {
                response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp?error=Company not found");
                return;
            }

            RecruiterActivityDAO activityDAO = new RecruiterActivityDAO();
            List<RecruiterActivityLog> activities = activityDAO.getActivitiesByCompanyId(company.getCompanyId());

            request.setAttribute("activities", activities);
            request.getRequestDispatcher("/Employer/recruiter_activity.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp?error=An error occurred: " + e.getMessage());
        }
    }
}