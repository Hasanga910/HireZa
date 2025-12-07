//package controller;
//
//import dao.UserDAO;
//import model.User;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.nio.charset.StandardCharsets;
//import java.security.MessageDigest;
//import java.security.NoSuchAlgorithmException;
//
//@WebServlet("/jobseekerChangePasswordServlet")
//public class Jobseekerchangepassword extends HttpServlet {
//
//    private UserDAO userDAO = new UserDAO();
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//
//        if (session == null || session.getAttribute("user") == null) {
//            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
//            return;
//        }
//
//        User user = (User) session.getAttribute("user");
//
//        String currentPassword = request.getParameter("currentPassword");
//        String newPassword = request.getParameter("newPassword");
//        String confirmPassword = request.getParameter("confirmPassword");
//
//        // Verify current password
//        if (!user.getPassword().equals(currentPassword)) {
//            response.sendRedirect("jobseeker/change_password.jsp?error=Incorrect current password");
//            return;
//        }
//
//        // Check new password match
//        if (!newPassword.equals(confirmPassword)) {
//            response.sendRedirect("jobseeker/change_password.jsp?error=Passwords do not match");
//            return;
//        }
//
//        // Update in DB
//        boolean updated = userDAO.updatePassword(user.getId(), newPassword);
//
//        if (updated) {
//            // Update session with new password
//            user.setPassword(newPassword);
//            session.setAttribute("user", user);
//
//            response.sendRedirect(request.getContextPath() + "/jobseeker/profile.jsp?success=Password updated successfully");
//        } else {
//            response.sendRedirect("jobseeker/change_password.jsp?error=Failed to update password");
//        }
//    }
//
//
//
//}

package controller;

import controller.RegisterServlet;
import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

@WebServlet("/jobseekerChangePasswordServlet")
public class Jobseekerchangepassword extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // FIXED: Verify current password against stored hash
        String storedHashedPassword = user.getPassword();
        if (!RegisterServlet.verifyPassword(currentPassword, storedHashedPassword)) {
            response.sendRedirect("jobseeker/change_password.jsp?error=Incorrect current password");
            return;
        }

        // Check new password match
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("jobseeker/change_password.jsp?error=Passwords do not match");
            return;
        }

        // FIXED: Hash the new password before saving
        String newHashedPassword = hashPassword(newPassword);

        // Update in DB with hashed password
        boolean updated = userDAO.updatePassword(user.getId(), newHashedPassword);

        if (updated) {
            // FIXED: Update session with new HASHED password
            user.setPassword(newHashedPassword);
            session.setAttribute("user", user);

            response.sendRedirect(request.getContextPath() + "/jobseeker/profile.jsp?success=Password updated successfully");
        } else {
            response.sendRedirect("jobseeker/change_password.jsp?error=Failed to update password");
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