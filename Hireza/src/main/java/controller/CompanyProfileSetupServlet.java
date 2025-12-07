package controller;

import dao.CompanyDAO;
import model.Company;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/company/profile/setup")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 15)   // 15MB
public class CompanyProfileSetupServlet extends HttpServlet {

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

        // Check if profile is already completed
        if (companyDAO.isCompanyProfileCompleted(user.getId())) {
            response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");
            return;
        }

        request.getRequestDispatcher("/Employer/company_profile_setup.jsp").forward(request, response);
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

        try {
            // Retrieve form parameters
            String companyName = request.getParameter("companyName");
            String industry = request.getParameter("industry");
            String description = request.getParameter("description");
            String website = request.getParameter("website");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zipCode = request.getParameter("zipCode");
            String contactNumber = request.getParameter("contactNumber");
            String companySize = request.getParameter("companySize");

            int foundedYear = 0;
            String foundedYearStr = request.getParameter("foundedYear");
            if (foundedYearStr != null && !foundedYearStr.isEmpty()) {
                foundedYear = Integer.parseInt(foundedYearStr);
            }

            String workMode = request.getParameter("workMode");
            String[] employmentTypesArray = request.getParameterValues("employmentTypes");
            String employmentTypes = employmentTypesArray != null ? String.join(",", employmentTypesArray) : "";
            String companyEmail = request.getParameter("companyEmail");
            String aboutUs = request.getParameter("aboutUs");

            // Handle file upload (logo is required in setup)
            byte[] logoBytes = null;
            Part filePart = request.getPart("logo");

            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect(request.getContextPath() + "/company/profile/setup?error=logo_required");
                return;
            }

            try (InputStream inputStream = filePart.getInputStream();
                 ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                logoBytes = outputStream.toByteArray();
            }

            // Create Company object
            Company company = new Company(
                    user.getId(),
                    companyName,
                    industry,
                    description,
                    website,
                    address,
                    city,
                    state,
                    zipCode,
                    contactNumber,
                    companySize,
                    foundedYear,
                    workMode,
                    employmentTypes,
                    companyEmail,
                    logoBytes,
                    aboutUs
            );

            // Save the company profile
            boolean isSaved = companyDAO.saveCompanyProfile(company);

            if (isSaved) {
                // Redirect to success page or dashboard
                response.sendRedirect(request.getContextPath() + "/company/profile/setup/success");
            } else {
                response.sendRedirect(request.getContextPath() + "/company/profile/setup?error=save_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/company/profile/setup?error=1");
        }
    }
}