//package controller;
//
//import dao.UserDAO;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//
//@WebServlet("/ChangePasswordServlet")
//public class ChangePasswordServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//
//        // Get parameters from request
//        String userIdStr = request.getParameter("userId");
//        String currentPassword = request.getParameter("currentPassword");
//        String newPassword = request.getParameter("newPassword");
//        String confirmPassword = request.getParameter("confirmPassword");
//
//        // Validate parameters
//        if (userIdStr == null || currentPassword == null || newPassword == null || confirmPassword == null) {
//            session.setAttribute("errorMessage", "All fields are required");
//            response.sendRedirect(request.getContextPath() + "/Assistant/Settings.jsp");
//            return;
//        }
//
//        if (!newPassword.equals(confirmPassword)) {
//            session.setAttribute("errorMessage", "New passwords do not match");
//            response.sendRedirect(request.getContextPath() + "/Assistant/Settings.jsp");
//            return;
//        }
//
//        try {
//            int userId = Integer.parseInt(userIdStr);
//            UserDAO userDAO = new UserDAO();
//
//            // Attempt to change password
//            boolean success = userDAO.changePassword(userId, currentPassword, newPassword);
//
//            if (success) {
//                session.setAttribute("successMessage", "Password updated successfully!");
//            } else {
//                session.setAttribute("errorMessage", "Current password is incorrect");
//            }
//
//        } catch (NumberFormatException e) {
//            session.setAttribute("errorMessage", "Invalid user ID");
//        } catch (Exception e) {
//            session.setAttribute("errorMessage", "An error occurred while updating password");
//            e.printStackTrace();
//        }
//
//        // Fixed redirect path - use the correct Assistant path
//        response.sendRedirect(request.getContextPath() + "/Assistant/Settings.jsp");
//    }
//}

package controller;

import dao.UserDAO;
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

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Get parameters from request
        String userIdStr = request.getParameter("userId");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate parameters
        if (userIdStr == null || currentPassword == null || newPassword == null || confirmPassword == null) {
            session.setAttribute("errorMessage", "All fields are required");
            response.sendRedirect(request.getContextPath() + "/Assistant/Settings.jsp");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("errorMessage", "New passwords do not match");
            response.sendRedirect(request.getContextPath() + "/Assistant/Settings.jsp");
            return;
        }

        if (newPassword.length() < 8) {
            session.setAttribute("errorMessage", "New password must be at least 8 characters long");
            response.sendRedirect(request.getContextPath() + "/Assistant/Settings.jsp");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();

            // Hash the new password
            String hashedNewPassword = hashPassword(newPassword);

            // Attempt to change password
            boolean success = userDAO.changePassword(userId, currentPassword, hashedNewPassword);

            if (success) {
                session.setAttribute("successMessage", "Password updated successfully!");
            } else {
                session.setAttribute("errorMessage", "Current password is incorrect");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid user ID");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred while updating password");
            e.printStackTrace();
        }

        // Fixed redirect path - use the correct Assistant path
        response.sendRedirect(request.getContextPath() + "/Assistant/Settings.jsp");
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