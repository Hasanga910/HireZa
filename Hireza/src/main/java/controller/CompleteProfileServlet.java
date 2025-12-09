package controller;

import dao.JobSeekerProfileDAO;
import dao.UserDAO;
import model.JobSeekerProfile;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/CompleteProfileServlet")
public class CompleteProfileServlet extends HttpServlet {

    private final JobSeekerProfileDAO profileDAO = new JobSeekerProfileDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");  // Get logged-in user

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Use String ID directly
        String seekerId = user.getId();

        JobSeekerProfile profile = profileDAO.getProfileBySeekerId(seekerId);

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("/jobseeker/completeProfile.jsp").forward(request, response);
    }
}



