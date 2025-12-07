package controller;

import dao.JobApplicationDAO;
import model.JobApplication;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class MyApplicationsServlet extends HttpServlet {

    private final JobApplicationDAO applicationDAO = new JobApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp?error=sessionExpired");
            return;
        }

        Object seekerIdObj = session.getAttribute("seekerId");
        if (seekerIdObj == null) {
            seekerIdObj = session.getAttribute("userId");
        }

        String seekerId = (seekerIdObj != null) ? seekerIdObj.toString() : null;

        if (seekerId == null || seekerId.trim().isEmpty() || seekerId.equals("null")) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp?error=loginRequired");
            return;
        }

        List<JobApplication> appliedJobs = applicationDAO.getApplicationsBySeeker(seekerId);

        int totalApplications = appliedJobs != null ? appliedJobs.size() : 0;
        int pendingCount = 0;
        int approvedCount = 0;
        int rejectedCount = 0;

        if (appliedJobs != null) {
            for (JobApplication app : appliedJobs) {
                String status = app.getStatus();
                if (status != null) {
                    switch (status.toLowerCase()) {
                        case "pending":
                            pendingCount++;
                            break;
                        case "approved":
                        case "accepted":
                            approvedCount++;
                            break;
                        case "rejected":
                            rejectedCount++;
                            break;
                    }
                }
            }
        }

        request.setAttribute("appliedJobs", appliedJobs);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);

        request.getRequestDispatcher("/jobseeker/Myapplication.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}