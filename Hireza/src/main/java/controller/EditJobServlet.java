//// package controller;
//// Add this new class: EditJobServlet.java
//// This servlet handles displaying the edit form (GET) and updating the post (POST).
//// Mapped to /company/jobs/edit
//// Forwards to /Employer/edit_post.jsp (note: used "post" in filename).
//
//package controller;
//
//import dao.CompanyDAO;
//import dao.JobPostDAO;
//import model.Company;
//import model.JobPost;
//import model.User;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//
//@WebServlet("/company/jobs/edit")
//public class EditJobServlet extends HttpServlet {
//
//    private JobPostDAO jobPostDAO = new JobPostDAO();
//    private CompanyDAO companyDAO = new CompanyDAO();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user == null || !"Employer".equals(user.getRole())) {
//            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
//            return;
//        }
//
//        Company company = companyDAO.getCompanyByUserId(user.getId());
//        if (company == null) {
//            response.sendRedirect(request.getContextPath() + "/company/jobs");
//            return;
//        }
//
//        int jobId = Integer.parseInt(request.getParameter("id"));
//        JobPost post = jobPostDAO.getJobPostById(jobId, company.getCompanyId());
//        if (post == null) {
//            response.sendRedirect(request.getContextPath() + "/company/jobs");
//            return;
//        }
//
//        request.setAttribute("post", post);
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/Employer/edit_post.jsp");
//        dispatcher.forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user == null || !"Employer".equals(user.getRole())) {
//            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
//            return;
//        }
//
//        Company company = companyDAO.getCompanyByUserId(user.getId());
//        if (company == null) {
//            response.sendRedirect(request.getContextPath() + "/company/jobs/edit?error=1");
//            return;
//        }
//
//        int jobId = Integer.parseInt(request.getParameter("jobId"));
//        String jobTitle = request.getParameter("jobTitle");
//        String workMode = request.getParameter("workMode");
//        String location = request.getParameter("location");
//        String employmentType = request.getParameter("employmentType");
//        String jobDescription = request.getParameter("jobDescription");
//        String requiredSkills = request.getParameter("requiredSkills");
//        String experienceLevel = request.getParameter("experienceLevel");
//        String applicationDeadlineStr = request.getParameter("applicationDeadline");
//        Date applicationDeadline = null;
//        if (applicationDeadlineStr != null && !applicationDeadlineStr.isEmpty()) {
//            try {
//                applicationDeadline = new SimpleDateFormat("yyyy-MM-dd").parse(applicationDeadlineStr);
//            } catch (ParseException e) {
//                e.printStackTrace();
//            }
//        }
//        String salaryRange = request.getParameter("salaryRange");
//        String workingHoursShifts = request.getParameter("workingHoursShifts");
//
//        JobPost post = new JobPost();
//        post.setJobId(jobId);
//        post.setCompanyId(company.getCompanyId());
//        post.setJobTitle(jobTitle);
//        post.setWorkMode(workMode);
//        post.setLocation(location);
//        post.setEmploymentType(employmentType);
//        post.setJobDescription(jobDescription);
//        post.setRequiredSkills(requiredSkills);
//        post.setExperienceLevel(experienceLevel);
//        post.setApplicationDeadline(applicationDeadline);
//        post.setSalaryRange(salaryRange);
//        post.setWorkingHoursShifts(workingHoursShifts);
//
//        boolean isUpdated = jobPostDAO.updateJobPost(post);
//
//        if (isUpdated) {
//            response.sendRedirect(request.getContextPath() + "/company/jobs");
//        } else {
//            response.sendRedirect(request.getContextPath() + "/company/jobs/edit?id=" + jobId + "&error=1");
//        }
//    }
//}

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

@WebServlet("/company/jobs/edit")
public class EditJobServlet extends HttpServlet {

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
        JobPost post = jobPostDAO.getJobPostById(jobId, company.getCompanyId());
        if (post == null) {
            response.sendRedirect(request.getContextPath() + "/company/jobs");
            return;
        }

        request.setAttribute("post", post);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Employer/edit_post.jsp");
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
            response.sendRedirect(request.getContextPath() + "/company/jobs/edit?error=1");
            return;
        }

        String jobId = request.getParameter("jobId");
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

        JobPost post = new JobPost();
        post.setJobId(jobId);
        post.setCompanyId(company.getCompanyId());
        post.setJobTitle(jobTitle);
        post.setWorkMode(workMode);
        post.setLocation(location);
        post.setEmploymentType(employmentType);
        post.setJobDescription(jobDescription);
        post.setRequiredSkills(requiredSkills);
        post.setExperienceLevel(experienceLevel);
        post.setApplicationDeadline(applicationDeadline);
        post.setSalaryRange(salaryRange);
        post.setWorkingHoursShifts(workingHoursShifts);

        boolean isUpdated = jobPostDAO.updateJobPost(post);

        if (isUpdated) {
            response.sendRedirect(request.getContextPath() + "/company/jobs");
        } else {
            response.sendRedirect(request.getContextPath() + "/company/jobs/edit?id=" + jobId + "&error=1");
        }
    }
}