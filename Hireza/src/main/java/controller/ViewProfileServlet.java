package controller;

import dao.JobSeekerProfileDAO;
import model.JobSeekerProfile;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/recruiter/view-profile")
public class ViewProfileServlet extends HttpServlet {
    private JobSeekerProfileDAO profileDAO = new JobSeekerProfileDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"Recruiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Get seekerId from request as String
        String seekerId = request.getParameter("seekerId");
        if (seekerId == null || seekerId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Recruiter/select_job.jsp");
            return;
        }

        // Fetch profile using String ID
        JobSeekerProfile profile = profileDAO.getProfileBySeekerId(seekerId);
        if (profile == null) {
            String jobId = request.getParameter("jobId");
            response.sendRedirect(request.getContextPath() + "/company/applications?jobId=" + (jobId != null ? jobId : "") + "&error=noProfile");
            return;
        }

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("/Recruiter/view_profile.jsp").forward(request, response);
    }
}
