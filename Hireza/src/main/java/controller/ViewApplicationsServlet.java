//package controller;
//
//import dao.JobApplicationDAO;
//import dao.JobPostDAO;
//import dao.RecruiterDAO;
//import model.JobApplication;
//import model.Recruiter;
//import model.User;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import java.util.List;
//
//@WebServlet("/company/applications")
//public class ViewApplicationsServlet extends HttpServlet {
//    private JobApplicationDAO applicationDAO = new JobApplicationDAO();
//    private JobPostDAO jobPostDAO = new JobPostDAO();
//    private RecruiterDAO recruiterDAO = new RecruiterDAO();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user == null || !"Recruiter".equals(user.getRole())) {
//            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
//            return;
//        }
//
//        int jobId;
//        try {
//            jobId = Integer.parseInt(request.getParameter("jobId"));
//        } catch (NumberFormatException e) {
//            response.sendRedirect(request.getContextPath() + "/Recruiter/select_job.jsp");
//            return;
//        }
//
//        Recruiter recruiter = recruiterDAO.getRecruiterByUserId(user.getId());
//        if (recruiter == null || jobPostDAO.getJobPostById(jobId) == null ||
//                jobPostDAO.getJobPostById(jobId).getCompanyId() != recruiter.getCompanyId()) {
//            response.sendRedirect(request.getContextPath() + "/Recruiter/select_job.jsp?error=invalidRecruiterOrJob");
//            return;
//        }
//
//        List<JobApplication> applications = applicationDAO.getApplicationsByJobId(jobId);
//        request.setAttribute("applications", applications);
//        request.setAttribute("jobId", jobId);
//        request.getRequestDispatcher("/Recruiter/view_applications.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user == null || !"Recruiter".equals(user.getRole())) {
//            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
//            return;
//        }
//
//        int applicationId;
//        int jobId;
//        try {
//            applicationId = Integer.parseInt(request.getParameter("applicationId"));
//            jobId = Integer.parseInt(request.getParameter("jobId"));
//        } catch (NumberFormatException e) {
//            response.sendRedirect(request.getContextPath() + "/company/applications?jobId=" +
//                    request.getParameter("jobId") + "&error=invalid");
//            return;
//        }
//
//        String status = request.getParameter("status");
//        if (status == null || !List.of("Pending", "Shortlisted", "Interview", "Rejected").contains(status)) {
//            response.sendRedirect(request.getContextPath() + "/company/applications?jobId=" +
//                    jobId + "&error=invalidStatus");
//            return;
//        }
//
//        Recruiter recruiter = recruiterDAO.getRecruiterByUserId(user.getId());
//        if (recruiter == null) {
//            response.sendRedirect(request.getContextPath() + "/company/applications?jobId=" +
//                    jobId + "&error=invalidRecruiter");
//            return;
//        }
//
//        if (jobPostDAO.getJobPostById(jobId) == null ||
//                jobPostDAO.getJobPostById(jobId).getCompanyId() != recruiter.getCompanyId()) {
//            response.sendRedirect(request.getContextPath() + "/Recruiter/select_job.jsp?error=invalidJob");
//            return;
//        }
//
//        System.out.println("Attempting to update applicationId: " + applicationId +
//                ", jobId: " + jobId + ", status: " + status +
//                ", recruiterId: " + recruiter.getRecruiterId());
//
//        boolean updated = applicationDAO.updateApplicationStatus(applicationId, status, recruiter.getRecruiterId());
//        if (updated) {
//            // Log the action
//            logRecruiterAction(recruiter.getRecruiterId(), applicationId, "Status Changed to " + status);
//            response.sendRedirect(request.getContextPath() + "/company/applications?jobId=" + jobId);
//        } else {
//            response.sendRedirect(request.getContextPath() + "/company/applications?jobId=" +
//                    jobId + "&error=updateFailed");
//        }
//    }
//
//    private void logRecruiterAction(int recruiterId, int applicationId, String action) {
//        String sql = "INSERT INTO RecruiterActivityLog (recruiterId, applicationId, action) VALUES (?, ?, ?)";
//        try (Connection conn = util.DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setInt(1, recruiterId);
//            stmt.setInt(2, applicationId);
//            stmt.setString(3, action);
//            stmt.executeUpdate();
//        } catch (SQLException e) {
//            System.err.println("SQLException in logRecruiterAction: " + e.getMessage());
//            e.printStackTrace();
//        }
//    }
//}