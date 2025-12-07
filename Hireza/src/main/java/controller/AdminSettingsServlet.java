package controller;

import dao.AdminDAO;
import model.Admin;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/admin-profile")
public class AdminSettingsServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\": false, \"error\": \"Not authenticated\", \"redirect\": \"/admin/dashboard.jsp\"}");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // DEBUG: Print session user info
        System.out.println("=== DEBUG: AdminSettingsServlet GET ===");
        System.out.println("Session User ID: " + sessionUser.getId());
        System.out.println("Session User ID Type: " + (sessionUser.getId() != null ? sessionUser.getId().getClass().getName() : "null"));
        System.out.println("Session User Role: " + sessionUser.getRole());
        System.out.println("=====================================");

        // Check if user is admin
        if (!"admin".equalsIgnoreCase(sessionUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            out.print("{\"success\": false, \"error\": \"Access denied\"}");
            return;
        }

        try {
            // Get the admin ID as String
            String adminId = sessionUser.getId();

            if (adminId == null || adminId.trim().isEmpty()) {
                System.out.println("ERROR: Admin ID is null or empty");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"error\": \"Invalid admin ID\"}");
                return;
            }

            System.out.println("Fetching admin with ID: " + adminId);

            // Fetch fresh admin data from database using AdminDAO
            Admin adminData = adminDAO.getAdminById(adminId);

            if (adminData != null) {
                System.out.println("Admin data retrieved successfully");
                System.out.println("Admin Full Name: " + adminData.getFullName());
                System.out.println("Admin Email: " + adminData.getEmail());

                // Split full name into first and last name
                String fullName = adminData.getFullName() != null ? adminData.getFullName() : "";
                String firstName = "";
                String lastName = "";

                if (!fullName.trim().isEmpty()) {
                    String[] nameParts = fullName.trim().split("\\s+", 2);
                    firstName = nameParts[0];
                    if (nameParts.length > 1) {
                        lastName = nameParts[1];
                    }
                }

                // Create JSON response manually
                StringBuilder json = new StringBuilder();
                json.append("{")
                        .append("\"success\": true,")
                        .append("\"admin\": {")
                        .append("\"id\": \"").append(escapeJson(adminData.getId())).append("\",")  // Wrap in quotes
                        .append("\"fullName\": \"").append(escapeJson(fullName)).append("\",")
                        .append("\"firstName\": \"").append(escapeJson(firstName)).append("\",")
                        .append("\"lastName\": \"").append(escapeJson(lastName)).append("\",")
                        .append("\"email\": \"").append(escapeJson(adminData.getEmail() != null ? adminData.getEmail() : "")).append("\",")
                        .append("\"phone\": \"").append(escapeJson(adminData.getPhone() != null ? adminData.getPhone() : "")).append("\",")
                        .append("\"username\": \"").append(escapeJson(adminData.getUsername() != null ? adminData.getUsername() : "")).append("\",")
                        .append("\"role\": \"").append(escapeJson(adminData.getRole() != null ? adminData.getRole() : "")).append("\"")
                        .append("}")
                        .append("}");

                out.print(json.toString());

            } else {
                System.out.println("ERROR: Admin not found with ID: " + adminId);
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"success\": false, \"error\": \"Admin profile not found\"}");
            }

        } catch (Exception e) {
            System.out.println("EXCEPTION in doGet: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Database error: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\": false, \"error\": \"Not authenticated\"}");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // Check if user is admin
        if (!"admin".equalsIgnoreCase(sessionUser.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            out.print("{\"success\": false, \"error\": \"Access denied\"}");
            return;
        }

        // ===== DEBUG CODE =====
        System.out.println("=== DEBUG: AdminSettingsServlet POST Request ===");
        System.out.println("Content Type: " + request.getContentType());
        System.out.println("Method: " + request.getMethod());
        System.out.println("Session User ID: " + sessionUser.getId());
        System.out.println("Session User ID Type: " + (sessionUser.getId() != null ? sessionUser.getId().getClass().getName() : "null"));
        System.out.println("Session User Role: " + sessionUser.getRole());

        // Print all parameters received
        System.out.println("=== All Parameters Received ===");
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        boolean hasParams = false;
        while (paramNames.hasMoreElements()) {
            hasParams = true;
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println("Parameter: " + paramName + " = '" + paramValue + "'");
        }

        if (!hasParams) {
            System.out.println("NO PARAMETERS RECEIVED!");
        }
        System.out.println("=====================================");
        // ===== END DEBUG CODE =====

        try {
            // Check if this is a password update request
            String action = request.getParameter("action");

            if ("changePassword".equals(action)) {
                // Handle password change
                handlePasswordChange(request, response, sessionUser, out);
            } else {
                // Handle profile update
                handleProfileUpdate(request, response, sessionUser, out);
            }

        } catch (Exception e) {
            System.out.println("EXCEPTION in doPost: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Database error: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private void handlePasswordChange(HttpServletRequest request, HttpServletResponse response,
                                      User sessionUser, PrintWriter out) throws IOException {
        System.out.println("=== HANDLING PASSWORD CHANGE ===");

        // Get password parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        System.out.println("Password parameters received:");
        System.out.println("currentPassword: " + (currentPassword != null ? "[PROVIDED]" : "null"));
        System.out.println("newPassword: " + (newPassword != null ? "[PROVIDED]" : "null"));
        System.out.println("confirmPassword: " + (confirmPassword != null ? "[PROVIDED]" : "null"));

        // Validate password parameters
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            System.out.println("VALIDATION FAILED: Current password is null or empty");
            out.print("{\"success\": false, \"error\": \"Current password is required\"}");
            return;
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            System.out.println("VALIDATION FAILED: New password is null or empty");
            out.print("{\"success\": false, \"error\": \"New password is required\"}");
            return;
        }

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            System.out.println("VALIDATION FAILED: Confirm password is null or empty");
            out.print("{\"success\": false, \"error\": \"Please confirm your new password\"}");
            return;
        }

        // Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            System.out.println("VALIDATION FAILED: New passwords don't match");
            out.print("{\"success\": false, \"error\": \"New passwords do not match\"}");
            return;
        }

        // Validate password strength (basic validation)
        if (newPassword.length() < 6) {
            System.out.println("VALIDATION FAILED: Password too short");
            out.print("{\"success\": false, \"error\": \"Password must be at least 6 characters long\"}");
            return;
        }

        try {
            // Get admin ID as String
            String adminId = sessionUser.getId();

            if (adminId == null || adminId.trim().isEmpty()) {
                System.out.println("ERROR: Admin ID is null or empty");
                out.print("{\"success\": false, \"error\": \"Invalid admin ID\"}");
                return;
            }

            System.out.println("Updating password for admin ID: " + adminId);

            // Update password using AdminDAO (now accepts String)
            boolean updated = adminDAO.updateAdminPassword(adminId, currentPassword, newPassword);

            if (updated) {
                System.out.println("SUCCESS: Password updated in database");
                out.print("{\"success\": true, \"message\": \"Password updated successfully\"}");
            } else {
                System.out.println("ERROR: Password update failed - possibly wrong current password");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"error\": \"Current password is incorrect or update failed\"}");
            }

        } catch (Exception e) {
            System.out.println("EXCEPTION in password update: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Database error: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response,
                                     User sessionUser, PrintWriter out) throws IOException {
        System.out.println("=== HANDLING PROFILE UPDATE ===");

        // Get parameters from request
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Additional debug for the specific parameters we're looking for
        System.out.println("=== Parameter Values After Extraction ===");
        System.out.println("firstName: '" + firstName + "'");
        System.out.println("lastName: '" + lastName + "'");
        System.out.println("username: '" + username + "'");
        System.out.println("email: '" + email + "'");
        System.out.println("phone: '" + phone + "'");
        System.out.println("==========================================");

        // Validate required fields
        if (firstName == null || firstName.trim().isEmpty()) {
            System.out.println("VALIDATION FAILED: firstName is null or empty");
            out.print("{\"success\": false, \"error\": \"First name is required\"}");
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            System.out.println("VALIDATION FAILED: email is null or empty");
            out.print("{\"success\": false, \"error\": \"Email is required\"}");
            return;
        }

        // Basic email validation
        if (!isValidEmail(email.trim())) {
            System.out.println("VALIDATION FAILED: Invalid email format");
            out.print("{\"success\": false, \"error\": \"Please enter a valid email address\"}");
            return;
        }

        // Combine first and last name
        String fullName = firstName.trim();
        if (lastName != null && !lastName.trim().isEmpty()) {
            fullName += " " + lastName.trim();
        }

        System.out.println("=== Final Values for Database ===");
        System.out.println("fullName: '" + fullName + "'");
        System.out.println("username: '" + (username != null ? username.trim() : "") + "'");
        System.out.println("email: '" + email.trim() + "'");
        System.out.println("phone: '" + (phone != null ? phone.trim() : "") + "'");
        System.out.println("==================================");

        try {
            // Get admin ID as String
            String adminId = sessionUser.getId();

            if (adminId == null || adminId.trim().isEmpty()) {
                System.out.println("ERROR: Admin ID is null or empty");
                out.print("{\"success\": false, \"error\": \"Invalid admin ID\"}");
                return;
            }

            System.out.println("Updating profile for admin ID: " + adminId);

            // Update admin profile using AdminDAO (now accepts String)
            boolean updated = adminDAO.updateAdminProfile(
                    adminId,
                    fullName,
                    username != null ? username.trim() : "",
                    email.trim(),
                    phone != null ? phone.trim() : ""
            );

            if (updated) {
                System.out.println("SUCCESS: Profile updated in database");

                // Update session data
                sessionUser.setFullName(fullName);
                sessionUser.setUsername(username != null ? username.trim() : "");
                sessionUser.setEmail(email.trim());
                sessionUser.setPhone(phone != null ? phone.trim() : "");
                request.getSession().setAttribute("user", sessionUser);

                out.print("{\"success\": true, \"message\": \"Profile updated successfully\"}");
            } else {
                System.out.println("ERROR: Database update failed - no rows updated");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false, \"error\": \"Failed to update profile - admin not found\"}");
            }

        } catch (Exception e) {
            System.out.println("EXCEPTION in profile update: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Database error: " + escapeJson(e.getMessage()) + "\"}");
        }
    }

    // Helper method to validate email
    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        // Simple email validation regex
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }

    // Helper method to escape JSON strings
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}