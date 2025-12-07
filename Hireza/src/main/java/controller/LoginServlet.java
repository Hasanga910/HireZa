package controller;

import dao.UserDAO;
import dao.CompanyDAO;
import dao.RecruiterDAO;
import dao.AdminDAO;
import model.User;
import model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();
    private final RecruiterDAO recruiterDAO = new RecruiterDAO();
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = null;

        // 1️⃣ Try admin authentication first
        Admin admin = adminDAO.getAdminByUsername(username);
        if (admin != null && adminDAO.verifyAdminPassword(admin.getId(), password)) {
            user = new User();
            user.setId(admin.getId()); // already string
            user.setFullName(admin.getFullName());
            user.setUsername(admin.getUsername());
            user.setEmail(admin.getEmail());
            user.setPhone(admin.getPhone());
            user.setRole("Admin");
        } else {
            // 2️⃣ If not admin, try regular user authentication
            user = userDAO.loginUser(username, password);
        }

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("seekerId", user.getId());

            String userRole = user.getRole().toLowerCase();

            switch (userRole) {
                case "admin":
                    session.setAttribute("adminId", user.getId());
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                    break;

                case "adminassistant":
                    response.sendRedirect(request.getContextPath() + "/Assistant/Dashboard.jsp");
                    break;

                case "recruiter":
                    boolean recruiterProfileCompleted = recruiterDAO.isRecruiterProfileCompleted(user.getId());
                    if (!recruiterProfileCompleted) {
                        response.sendRedirect(request.getContextPath() + "/recruiter/profile");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp");
                    }
                    break;

                case "employer":
                    boolean companyProfileCompleted = companyDAO.isCompanyProfileCompleted(user.getId());
                    if (!companyProfileCompleted) {
                        // Redirect to new step-by-step setup page
                        response.sendRedirect(request.getContextPath() + "/company/profile/setup");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");
                    }
                    break;

                case "jobcounsellor":
                    response.sendRedirect(request.getContextPath() + "/Counselor/Counselor_dashboard.jsp");
                    break;

                default: // Job Seeker
                    response.sendRedirect(request.getContextPath() + "/jobseeker/home.jsp");
                    break;
            }

        } else {
            // Login failed
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp?error=1");
        }
    }
}

//package controller;
//
//import dao.UserDAO;
//import dao.CompanyDAO;
//import dao.RecruiterDAO;
//import dao.AdminDAO;
//import model.User;
//import model.Admin;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//
//@WebServlet("/LoginServlet")
//public class LoginServlet extends HttpServlet {
//
//    private final UserDAO userDAO = new UserDAO();
//    private final CompanyDAO companyDAO = new CompanyDAO();
//    private final RecruiterDAO recruiterDAO = new RecruiterDAO();
//    private final AdminDAO adminDAO = new AdminDAO();
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
////        String role = request.getParameter("role");
//
//        User user = null;
//
//        // 1️⃣ Try admin authentication first
//        Admin admin = adminDAO.getAdminByUsername(username);
//        if (admin != null && adminDAO.verifyAdminPassword(admin.getId(), password)) {
//            user = new User();
//            user.setId(admin.getId()); // already string
//            user.setFullName(admin.getFullName());
//            user.setUsername(admin.getUsername());
//            user.setEmail(admin.getEmail());
//            user.setPhone(admin.getPhone());
//            user.setRole("Admin");
//        } else {
//            // 2️⃣ If not admin, try regular user authentication
//            user = userDAO.loginUser(username, password);
//
////            user = userDAO.loginUser(username, password, role);
//        }
//
//        if (user != null) {
//            HttpSession session = request.getSession();
//            session.setAttribute("user", user);
//            session.setAttribute("seekerId", user.getId());
//
//            String userRole = user.getRole().toLowerCase();
//
//            switch (userRole) {
//                case "admin":
//                    session.setAttribute("adminId", user.getId());
//                    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
//                    break;
//
//                case "adminassistant":
//                    response.sendRedirect(request.getContextPath() + "/Assistant/Dashboard.jsp");
//                    break;
//
//                case "recruiter":
//                    boolean recruiterProfileCompleted = recruiterDAO.isRecruiterProfileCompleted(user.getId());
//                    if (!recruiterProfileCompleted) {
//                        response.sendRedirect(request.getContextPath() + "/recruiter/profile");
//                    } else {
//                        response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp");
//                    }
//                    break;
//
//                case "employer":
//                    boolean companyProfileCompleted = companyDAO.isCompanyProfileCompleted(user.getId());
//                    if (!companyProfileCompleted) {
//                        response.sendRedirect(request.getContextPath() + "/Employer/company_profile.jsp");
//                    } else {
//                        response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");
//                    }
//                    break;
//
//                case "jobcounsellor":
//                    response.sendRedirect(request.getContextPath() + "/Counselor/Counselor_dashboard.jsp");
//                    break;
//
//                default: // Job Seeker
//                    response.sendRedirect(request.getContextPath() + "/jobseeker/home.jsp");
//                    break;
//            }
//
//        } else {
//            // Login failed
//            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp?error=1");
//        }
//    }
//}
