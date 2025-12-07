package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.regex.Pattern;
import java.security.SecureRandom;

public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    // Validation patterns
    private static final Pattern FULL_NAME_PATTERN = Pattern.compile("^[a-zA-Z0-9\\s]{2,50}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");

        // Trim whitespace
        fullName = fullName != null ? fullName.trim() : "";
        username = username != null ? username.trim() : "";
        email = email != null ? email.trim() : "";
        phone = phone != null ? phone.trim() : "";
        role = role != null ? role.trim() : "";

        // Validate all fields
        String validationError = validateAllFields(fullName, username, email, phone, password, confirmPassword, role);

        if (validationError != null) {
            // Validation failed - redirect back with error message and preserve form data
            request.setAttribute("error", validationError);
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("jobseeker/signup.jsp").forward(request, response);
            return;
        }

        // Additional business logic validations
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username already exists. Please choose a different username.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("jobseeker/signup.jsp").forward(request, response);
            return;
        }

        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already registered. Please use a different email or sign in.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("jobseeker/signup.jsp").forward(request, response);
            return;
        }

        // FIXED: Hash the password BEFORE creating the user
        String hashedPassword = hashPassword(password);

        // Create user with HASHED password
        User user = new User(fullName, username, email, hashedPassword, role);
        user.setPhone(phone);

        String userId = userDAO.registerUser(user);

        if (userId != null && !userId.isEmpty()) {
            // Registration successful
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Registration successful! Please sign in with your credentials.");
            response.sendRedirect("jobseeker/signin.jsp");
        } else {
            // Database error
            request.setAttribute("error", "Registration failed due to a system error. Please try again later.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("jobseeker/signup.jsp").forward(request, response);
        }
    }

    /**
     * Validates all form fields and returns error message if validation fails
     */
    private String validateAllFields(String fullName, String username, String email,
                                     String phone, String password, String confirmPassword, String role) {

        // Validate Full Name
        if (fullName == null || fullName.isEmpty()) {
            return "Full name is required.";
        }
        if (!FULL_NAME_PATTERN.matcher(fullName).matches()) {
            return "Name must be 2-50 characters.";
        }

        // Validate Username
        if (username == null || username.isEmpty()) {
            return "Username is required.";
        }
        if (!USERNAME_PATTERN.matcher(username).matches()) {
            return "Username must be 3-20 characters and contain only letters, numbers, and underscores.";
        }

        // Validate Email
        if (email == null || email.isEmpty()) {
            return "Email is required.";
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return "Please enter a valid email address.";
        }

        // Validate Phone
        if (phone == null || phone.isEmpty()) {
            return "Phone number is required.";
        }
        if (!PHONE_PATTERN.matcher(phone).matches()) {
            return "Phone number must be exactly 10 digits.";
        }

        // Validate Password
        if (password == null || password.isEmpty()) {
            return "Password is required.";
        }
        if (password.length() < 8) {
            return "Password must be at least 8 characters long.";
        }
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            return "Password must contain at least one uppercase letter, one lowercase letter, and one number.";
        }

        // Validate Confirm Password
        if (confirmPassword == null || confirmPassword.isEmpty()) {
            return "Please confirm your password.";
        }
        if (!password.equals(confirmPassword)) {
            return "Passwords do not match.";
        }

        // Validate Role
        if (role == null || role.isEmpty()) {
            return "Please select a role.";
        }
        String[] validRoles = {"JobSeeker", "Admin", "AdminAssistant", "Recruiter", "Employer", "JobCounsellor"};
        boolean isValidRole = false;
        for (String validRole : validRoles) {
            if (validRole.equals(role)) {
                isValidRole = true;
                break;
            }
        }
        if (!isValidRole) {
            return "Invalid role selected.";
        }

        // All validations passed
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the signup page
        response.sendRedirect("jobseeker/signup.jsp");
    }

    /**
     * Hash password using SHA-256 with salt
     * @param password Plain text password
     * @return Salted and hashed password in format: salt:hash
     */
    private String hashPassword(String password) {
        try {
            // Generate random salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);

            // Hash password with salt
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes("UTF-8"));

            // Encode salt and hash to Base64
            String saltStr = Base64.getEncoder().encodeToString(salt);
            String hashStr = Base64.getEncoder().encodeToString(hashedPassword);

            // Return in format: salt:hash
            return saltStr + ":" + hashStr;
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    /**
     * Verify password against hash (for login functionality)
     * @param password Plain text password
     * @param storedHash Stored hash in format salt:hash
     * @return true if password matches
     */
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            // Split stored hash into salt and hash parts
            String[] parts = storedHash.split(":");
            if (parts.length != 2) {
                return false;
            }

            byte[] salt = Base64.getDecoder().decode(parts[0]);
            String storedHashPart = parts[1];

            // Hash the input password with the stored salt
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes("UTF-8"));
            String hashStr = Base64.getEncoder().encodeToString(hashedPassword);

            // Compare hashes
            return storedHashPart.equals(hashStr);
        } catch (Exception e) {
            return false;
        }
    }
}




