package controller;
import dao.JobApplicationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.UUID;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,        // 1MB
        maxFileSize = 10 * 1024 * 1024,         // 10MB
        maxRequestSize = 20 * 1024 * 1024       // 20MB
)
public class SubmitApplicationServlet extends HttpServlet {

    private final JobApplicationDAO applicationDAO = new JobApplicationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1️⃣ Retrieve logged-in job seeker ID (as String) - FIXED
        HttpSession session = request.getSession(false);
        Object seekerIdObj = (session != null) ? session.getAttribute("seekerId") : null;
        String seekerId = (seekerIdObj != null) ? seekerIdObj.toString() : null;

        // Additional validation: check if seekerId is valid
        if (seekerId == null || seekerId.trim().isEmpty() || seekerId.equals("null")) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp?error=loginRequired");
            return;
        }

        // 2️⃣ Get jobId as String (no integer parsing)
        String jobId = request.getParameter("jobId");
        if (jobId == null || jobId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Applynow.jsp?error=missingJobId");
            return;
        }
        jobId = jobId.trim();

        // 3️⃣ Get form fields
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String coverLetter = request.getParameter("coverLetter");

        // 4️⃣ Validate required fields
        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Applynow.jsp?jobId=" + jobId + "&error=missingFields");
            return;
        }

        // 5️⃣ Handle resume file upload
        Part resumePart = request.getPart("resume");
        if (resumePart == null || resumePart.getSize() == 0) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Applynow.jsp?jobId=" + jobId + "&error=noResume");
            return;
        }

        String originalFilename = Paths.get(resumePart.getSubmittedFileName()).getFileName().toString();
        String ext = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();
        if (!ext.equals(".pdf") && !ext.equals(".doc") && !ext.equals(".docx")) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Applynow.jsp?jobId=" + jobId + "&error=badFileType");
            return;
        }

        // 6️⃣ Prepare upload directory
        String uploadsDir = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "resumes";
        Files.createDirectories(Paths.get(uploadsDir));

        // 7️⃣ Create unique resume filename
        String storedName = "resume_" + seekerId + "_" + UUID.randomUUID() + ext;
        Path filePath = Paths.get(uploadsDir, storedName);
        try (InputStream inputStream = resumePart.getInputStream()) {
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        }

        // 8️⃣ Relative path to save in DB
        String relativePath = "uploads/resumes/" + storedName;

        // 9️⃣ Insert into DB using DAO (seekerId and jobId are strings)
        boolean success = applicationDAO.insert(
                jobId,
                seekerId,
                fullName.trim(),
                email.trim(),
                phone.trim(),
                coverLetter != null ? coverLetter.trim() : "",
                relativePath
        );

        // 10️⃣ Redirect based on result
        if (success) {
            response.sendRedirect(request.getContextPath() + "/search-jobs?applied=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Applynow.jsp?jobId=" + jobId + "&error=dbError");
        }
    }
}