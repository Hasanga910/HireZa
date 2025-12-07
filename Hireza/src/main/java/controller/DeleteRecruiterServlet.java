package controller;

import dao.CompanyDAO;
import dao.RecruiterDAO;
import dao.UserDAO;
import model.Company;
import model.Recruiter;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/company/delete-recruiter")
public class DeleteRecruiterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();
    private CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("\n=== DELETE RECRUITER SERVLET CALLED ===");

        HttpSession session = request.getSession();
        User employer = (User) session.getAttribute("user");

        System.out.println("Employer from session: " + (employer != null ? employer.getId() : "null"));

        if (employer == null || !"Employer".equals(employer.getRole())) {
            System.out.println("❌ Unauthorized access - redirecting to signin");
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        String recruiterUserId = request.getParameter("userId");
        System.out.println("Received userId parameter: '" + recruiterUserId + "'");

        if (recruiterUserId == null || recruiterUserId.trim().isEmpty()) {
            System.err.println("❌ No userId provided or empty");
            response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp?error=invalid");
            return;
        }

        System.out.println("Looking up recruiter with userId: " + recruiterUserId);
        Recruiter recruiter = recruiterDAO.getRecruiterByUserId(recruiterUserId);

        if (recruiter == null) {
            System.err.println("❌ Recruiter not found for userId: " + recruiterUserId);
            response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp?error=notfound");
            return;
        }

        System.out.println("✅ Recruiter found: " + recruiter.getRecruiterId());
        System.out.println("   Recruiter's companyId: " + recruiter.getCompanyId());

        Company company = companyDAO.getCompanyByUserId(employer.getId());

        if (company == null) {
            System.err.println("❌ Company not found for employer: " + employer.getId());
            response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp?error=nocompany");
            return;
        }

        System.out.println("   Employer's companyId: " + company.getCompanyId());

        // Verify the recruiter belongs to the employer's company
        if (!company.getCompanyId().equals(recruiter.getCompanyId())) {
            System.err.println("❌ Unauthorized: Recruiter doesn't belong to employer's company");
            response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp?error=unauthorized");
            return;
        }

        System.out.println("✅ Authorization check passed");
        System.out.println("Attempting to delete recruiter record...");

        // Delete recruiter record first (to avoid foreign key constraint)
        boolean recruiterDeleted = recruiterDAO.deleteRecruiterByUserId(recruiterUserId);

        if (!recruiterDeleted) {
            System.err.println("❌ Failed to delete recruiter record");
            response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp?error=recruiter_delete_failed");
            return;
        }

        System.out.println("✅ Recruiter record deleted");
        System.out.println("Attempting to delete user account...");

        // Then delete the user account
        boolean userDeleted = userDAO.deleteUser(recruiterUserId);

        if (!userDeleted) {
            System.err.println("❌ Failed to delete user account");
            response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp?error=user_delete_failed");
            return;
        }

        System.out.println("✅ User account deleted successfully");
        System.out.println("=== DELETE COMPLETE ===\n");

        response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp?success=deleted");
    }
}


//@WebServlet("/company/delete-recruiter")
//public class DeleteRecruiterServlet extends HttpServlet {
//    private UserDAO userDAO = new UserDAO();
//    private RecruiterDAO recruiterDAO = new RecruiterDAO();
//    private CompanyDAO companyDAO = new CompanyDAO();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User employer = (User) session.getAttribute("user");
//        if (employer == null || !"Employer".equals(employer.getRole())) {
//            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
//            return;
//        }
//
//        int recruiterUserId = Integer.parseInt(request.getParameter("userId"));
//        Recruiter recruiter = recruiterDAO.getRecruiterByUserId(recruiterUserId);
//        if (recruiter != null) {
//            Company company = companyDAO.getCompanyByUserId(employer.getId());
//            if (company != null && company.getCompanyId().equals(recruiter.getCompanyId())) {
//                userDAO.deleteUser(recruiterUserId);  // Cascades to Recruiter table
//            }
//        }
//
//        response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp");
//    }
//}