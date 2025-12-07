package controller;

import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {

            String userId = ((model.User) session.getAttribute("user")).getId();

            // Delete user from database
            boolean deleted = userDAO.deleteUserWithProfile(userId);

            if (deleted) {
                // Invalidate session after deletion
                session.invalidate();
                // Redirect to home or signup page
                response.sendRedirect(request.getContextPath() + "/index.jsp?msg=account_deleted");
            } else {
                // Failed deletion
                response.sendRedirect(request.getContextPath() + "/jobseeker/home.jsp?error=delete_failed");
            }
        } else {
            // Not logged in
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        }
    }
}