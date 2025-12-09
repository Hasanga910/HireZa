package controller;

import dao.JobApplicationDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/company/update-application") // Changed from /company/applications to avoid conflict
public class JobApplicationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || !"Recruiter".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
                return;
            }

            String applicationId = request.getParameter("applicationId");
            String newStatus = request.getParameter("status");
            String recruiterId = request.getParameter("recruiterId");
            String jobId = request.getParameter("jobId");

            if (applicationId == null || newStatus == null || recruiterId == null || jobId == null) {
                response.sendRedirect(request.getContextPath() + "/Recruiter/view_applications.jsp?jobId=" + jobId + "&error=Invalid parameters");
                return;
            }

            JobApplicationDAO applicationDAO = new JobApplicationDAO();
            boolean success = applicationDAO.updateApplicationStatus(applicationId, newStatus, recruiterId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/Recruiter/view_applications.jsp?jobId=" + jobId + "&success=Status updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/Recruiter/view_applications.jsp?jobId=" + jobId + "&error=updateFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Recruiter/view_applications.jsp?error=An error occurred: " + e.getMessage());
        }
    }
}
