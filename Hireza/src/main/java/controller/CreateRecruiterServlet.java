package controller;

import dao.CompanyDAO;
import dao.RecruiterDAO;
import dao.UserDAO;
import model.Company;
import model.Recruiter;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.logging.Logger;
import java.util.regex.Pattern;

@WebServlet("/company/create-recruiter")
public class CreateRecruiterServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CreateRecruiterServlet.class.getName());
    private UserDAO userDAO = new UserDAO();
    private CompanyDAO companyDAO = new CompanyDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();

    // Validation patterns
    private static final Pattern FULL_NAME_PATTERN = Pattern.compile("^[a-zA-Z0-9\\s]{2,50}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"Employer".equals(user.getRole())) {
            LOGGER.warning("Unauthorized access attempt to create-recruiter by user: " + (user != null ? user.getUsername() : "null"));
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }
        request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User employer = (User) session.getAttribute("user");
        if (employer == null || !"Employer".equals(employer.getRole())) {
            LOGGER.warning("Unauthorized POST attempt to create-recruiter by user: " + (employer != null ? employer.getUsername() : "null"));
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Retrieve and trim form parameters
        String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName").trim() : "";
        String username = request.getParameter("username") != null ? request.getParameter("username").trim() : "";
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";

        // Validate all fields
        String validationError = validateAllFields(fullName, username, email, phone, password, confirmPassword);
        if (validationError != null) {
            LOGGER.info("Validation failed: " + validationError);
            request.setAttribute("error", validationError);
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
            return;
        }

        // Check for existing username or email
        if (userDAO.isUsernameExists(username)) {
            LOGGER.info("Username already exists: " + username);
            request.setAttribute("error", "Username already exists. Please choose a different username.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
            return;
        }

        if (userDAO.isEmailExists(email)) {
            LOGGER.info("Email already registered: " + email);
            request.setAttribute("error", "Email already registered. Please use a different email.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
            return;
        }

        // Hash the password
        String hashedPassword;
        try {
            hashedPassword = hashPassword(password);
        } catch (RuntimeException e) {
            LOGGER.severe("Password hashing failed: " + e.getMessage());
            request.setAttribute("error", "Error processing password. Please try again.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
            return;
        }

        // Create new user with hashed password
        User newUser = new User(fullName, username, email, hashedPassword, "Recruiter");
        newUser.setPhone(phone);
        String userId = userDAO.registerUser(newUser);
        if (userId == null || userId.isEmpty()) {
            LOGGER.severe("Failed to register user: " + username);
            request.setAttribute("error", "Failed to create user due to a system error. Please try again.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
            return;
        }
//        String userId = userDAO.registerUser(newUser);
//        if (userId <= 0) {
//            LOGGER.severe("Failed to register user: " + username);
//            request.setAttribute("error", "Failed to create user due to a system error. Please try again.");
//            request.setAttribute("fullName", fullName);
//            request.setAttribute("username", username);
//            request.setAttribute("email", email);
//            request.setAttribute("phone", phone);
//            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
//            return;
//        }

        // Retrieve company
        Company company = companyDAO.getCompanyByUserId(employer.getId());
        if (company == null) {
            LOGGER.severe("No company found for employer userId: " + employer.getId());
            request.setAttribute("error", "No company associated with this employer. Please contact support.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
            return;
        }

        // Create recruiter
        Recruiter recruiter = new Recruiter();
        recruiter.setUserId(userId);
        recruiter.setCompanyId(company.getCompanyId());
        recruiter.setPosition(""); // Default empty string to avoid NULL constraint issues
        recruiter.setBio(""); // Default empty string to avoid NULL constraint issues
        recruiter.setProfileCompleted(false);
        if (!recruiterDAO.saveRecruiter(recruiter)) {
            LOGGER.severe("Failed to save recruiter for userId: " + userId);
            // Optionally delete the created user to maintain consistency
            userDAO.deleteUser(userId);
            request.setAttribute("error", "Failed to create recruiter due to a system error. Please try again.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/Employer/create_recruiter.jsp").forward(request, response);
            return;
        }

        LOGGER.info("Successfully created recruiter: " + username + " for companyId: " + company.getCompanyId());
        response.sendRedirect(request.getContextPath() + "/Employer/manage_recruiters.jsp");
    }

    /**
     * Validates all form fields and returns error message if validation fails
     */
    private String validateAllFields(String fullName, String username, String email,
                                     String phone, String password, String confirmPassword) {
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

        // All validations passed
        return null;
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
}