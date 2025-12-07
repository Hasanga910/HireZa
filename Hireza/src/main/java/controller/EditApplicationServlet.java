package controller;

import dao.JobApplicationDAO;
import model.JobApplication;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/EditApplicationServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class EditApplicationServlet extends HttpServlet {

    private JobApplicationDAO jobAppDAO = new JobApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=invalid_id");
            return;
        }

        JobApplication app = jobAppDAO.getApplicationById(id);

        if (app != null) {
            request.setAttribute("application", app);
            request.getRequestDispatcher("/jobseeker/UpdateApplication.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=not_found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String applicationId = request.getParameter("applicationId");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String coverLetter = request.getParameter("coverLetter");

            if (applicationId == null || fullName == null || email == null || phone == null) {
                response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=missing_fields");
                return;
            }

            JobApplication existingApp = jobAppDAO.getApplicationById(applicationId);
            if (existingApp == null) {
                response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=not_found");
                return;
            }

            String resumeFilePath = existingApp.getResumeFile();

            Part filePart = request.getPart("resumeFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);

                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "resumes";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }

                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String filePath = uploadPath + File.separator + uniqueFileName;

                    filePart.write(filePath);
                    resumeFilePath = "resumes/" + uniqueFileName;

                    if (existingApp.getResumeFile() != null && !existingApp.getResumeFile().isEmpty()) {
                        String oldFilePath = getServletContext().getRealPath("") + File.separator + existingApp.getResumeFile();
                        File oldFile = new File(oldFilePath);
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }
                }
            }

            JobApplication app = new JobApplication();
            app.setApplicationId(applicationId);
            app.setFullName(fullName);
            app.setEmail(email);
            app.setPhone(phone);
            app.setCoverLetter(coverLetter);
            app.setResumeFile(resumeFilePath);

            boolean updated = jobAppDAO.updateApplication(app);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/EditApplicationServlet?id=" + applicationId + "&error=update_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=server_error");
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
}