package controller;

import dao.UserDAO;
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

@WebServlet("/company/edit-user")
public class EditUserProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"Employer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        // Retrieve form parameters
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // FIXED: Validate and hash password (if provided)
        if (password != null && !password.isEmpty()) {
            if (!password.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/Employer/edit_user_profile.jsp?error=2");
                return;
            }
            if (password.length() < 8) {
                response.sendRedirect(request.getContextPath() + "/Employer/edit_user_profile.jsp?error=3");
                return;
            }
            // Hash the new password before storing
            String hashedPassword = hashPassword(password);
            user.setPassword(hashedPassword);
        }
        // If password is empty, keep the existing hashed password (no change)

        // Update user object
        user.setFullName(fullName);
        user.setUsername(username);
        user.setEmail(email);
        user.setPhone(phone);

        // Update user in the database
        boolean isUpdated = userDAO.updateUser(user);

        if (isUpdated) {
            // Update session with the modified user object
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/Employer/edit_user_profile.jsp?error=1");
        }
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