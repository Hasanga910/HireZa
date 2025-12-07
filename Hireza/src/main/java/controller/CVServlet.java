package controller;

import dao.CVDAO;
import model.CV;
import model.JobSeekerProfile;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;

public class CVServlet extends HttpServlet {

    private CVDAO cvDAO = new CVDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("DEBUG: CVServlet doPost entered");


        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // logged-in user

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Collect form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String linkedin = request.getParameter("linkedin");
        String education = request.getParameter("education");
        String institute = request.getParameter("institute");
        String jobTitle = request.getParameter("jobTitle");
        String company = request.getParameter("company");
        String experienceYears = request.getParameter("experienceYears");
        String skills = request.getParameter("skills");
        String interests = request.getParameter("interests");
        String projects = request.getParameter("projects");
        String certifications = request.getParameter("certifications");


        // Create CV object
        CV cv = new CV();
        cv.setSeekerId(user.getId());
        cv.setFullName(fullName);
        cv.setEmail(email);
        cv.setPhone(phone);
        cv.setLinkedin(linkedin);
        cv.setEducation(education);
        cv.setInstitute(institute);
        cv.setJobTitle(jobTitle);
        cv.setCompany(company);
        cv.setExperienceYears(experienceYears);
        cv.setSkills(skills);
        cv.setInterests(interests);
        cv.setProjects(projects);
        cv.setCertifications(certifications);

        // Check if CV exists
        CV existingCV = cvDAO.getCVBySeekerId(user.getId());
        boolean saved;
        if (existingCV != null) {
            // Update existing CV
            cv.setCvId(existingCV.getCvId());
            saved = cvDAO.updateCV(cv);
        } else {
            // Insert new CV
            saved = cvDAO.saveCV(cv);
        }

        if (saved) {
            // Check if user wants to download PDF
            String action = request.getParameter("action");
            if ("download".equals(action)) {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=cv.pdf");

                try (OutputStream out = response.getOutputStream()) {
                    cvDAO.generateCV(new JobSeekerProfile(), cv, out);
                    out.flush();
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("cvForm.jsp?error=true");
                }
                return; // stop further processing
            } else {
                // Redirect to profile page with success message
                response.sendRedirect(request.getContextPath() + "/jobseeker/profile.jsp?cvSaved=true");
                System.out.println("DEBUG: CV saved successfully, redirecting to profile.");

            }
        } else {
            response.sendRedirect("cvForm.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to CV form page
        request.getRequestDispatcher("/cvForm.jsp").forward(request, response);
    }
}
