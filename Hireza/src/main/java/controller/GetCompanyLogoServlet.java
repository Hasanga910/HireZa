package controller;

import dao.CompanyDAO;
import model.Company;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/company/logo")
public class GetCompanyLogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String companyId = request.getParameter("companyId");

        String sql = "SELECT logo FROM Company WHERE companyId = ?";
        try (Connection conn = util.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                byte[] logo = rs.getBytes("logo");
                if (logo != null) {
                    response.setContentType("image/jpeg"); // Adjust MIME type as needed
                    response.getOutputStream().write(logo);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
