package controller;

import dao.JobSeekerProfileDAO;
import model.JobSeekerProfile;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/jobseeker/saveProfile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 15)   // 15MB
public class SaveProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String seekerId = user.getId();

        // Collect form data
        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String about = request.getParameter("about");
        String experience = request.getParameter("experience");
        String education = request.getParameter("education");
        String skills = request.getParameter("skills");

        // Handle file upload
        Part filePart = request.getPart("profilePic");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            filePart.write(uploadPath + File.separator + fileName);
        }

        try {
            JobSeekerProfileDAO dao = new JobSeekerProfileDAO();
            JobSeekerProfile existingProfile = dao.getProfileBySeekerId(seekerId);

            if (existingProfile == null) {
                // ✅ Insert new profile (use DAO's ID generator)
                JobSeekerProfile newProfile = new JobSeekerProfile();
                newProfile.setSeekerId(seekerId);
                newProfile.setTitle(title);
                newProfile.setLocation(location);
                newProfile.setAbout(about);
                newProfile.setExperience(experience);
                newProfile.setEducation(education);
                newProfile.setSkills(skills);
                newProfile.setProfilePic(fileName);

                dao.saveProfile(newProfile);

            } else {
                // ✅ Update existing profile
                existingProfile.setTitle(title);
                existingProfile.setLocation(location);
                existingProfile.setAbout(about);
                existingProfile.setExperience(experience);
                existingProfile.setEducation(education);
                existingProfile.setSkills(skills);
                if (fileName != null) existingProfile.setProfilePic(fileName);

                dao.updateProfile(existingProfile);
            }

            response.sendRedirect(request.getContextPath() + "/jobseeker/profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving profile: " + e.getMessage());
        }
    }
}
