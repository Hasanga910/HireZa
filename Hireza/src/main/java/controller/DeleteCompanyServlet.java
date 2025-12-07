package controller;

import dao.CompanyDAO;
import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/company/delete")
public class DeleteCompanyServlet extends HttpServlet {

    private CompanyDAO companyDAO = new CompanyDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"Employer".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        boolean isDeleted = true;

        // Step 1: Delete related JobApplications records to avoid foreign key constraint violation
        String deleteJobApplicationsSql = "DELETE FROM JobApplications WHERE seekerId = ?";
        try (Connection conn = util.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(deleteJobApplicationsSql)) {
            stmt.setString(1, user.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            isDeleted = false;
        }

        // Step 2: Delete company profile (cascades to Posts due to ON DELETE CASCADE)
        if (isDeleted) {
            isDeleted = companyDAO.deleteCompanyProfile(user.getId());
        }

        // Step 3: Delete user from Users table
        if (isDeleted) {
            String deleteUserSql = "DELETE FROM Users WHERE userId = ?";
            try (Connection conn = util.DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(deleteUserSql)) {
                stmt.setString(1, user.getId());
                int rowsDeleted = stmt.executeUpdate();
                isDeleted = rowsDeleted > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                isDeleted = false;
            }
        }

        if (isDeleted) {
            // Invalidate session and redirect to sign-in page
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/Employer/employer_dashboard.jsp?error=1");
        }
    }
}