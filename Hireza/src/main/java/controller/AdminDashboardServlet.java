package controller;

import dao.*;
import model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // 1. Check session and admin login
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("adminId") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                String errorJson = "{\"error\":\"Not authenticated\",\"redirect\":\"/admin/dashboard.jsp\"}";
                out.print(errorJson);
                return;
            }

            // Changed to String to match the new ID format
            String adminId = (String) session.getAttribute("adminId");

            // 2. Fetch admin user details
            AdminDAO adminDAO = new AdminDAO();
            Admin adminUser = adminDAO.getAdminById(adminId);  // Now accepts String

            if (adminUser == null) {
                // Clear session and redirect to login
                session.invalidate();
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                String errorJson = "{\"error\":\"Admin not found\",\"redirect\":\"/admin/dashboard.jsp\"}";
                out.print(errorJson);
                return;
            }

            // 3. Fetch counts with error handling
            int employersCount = 0;
            int recruitersCount = 0;
            int jobseekersCount = 0;
            int counselorsCount = 0;
            int adminAssistantsCount = 0;

            try {
                // Use your DAO methods to get actual counts
                employersCount = CompanyDAO.getEmployersCount();
                recruitersCount = RecruiterDAO.getRecruitersCount();
                jobseekersCount = JobSeekerProfileDAO.getJobSeekersCount();
                counselorsCount = CounselorDAO.getCounselorsCount();
                adminAssistantsCount = AdminAssistantDAO.getAdminAssistantsCount();

            } catch (Exception e) {
                e.printStackTrace();
                System.err.println("Error fetching dashboard counts: " + e.getMessage());
                // Continue with default values (0)
            }

            // 4. Build JSON response manually
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{");
            jsonResponse.append("\"success\":true,");

            // Admin data
            jsonResponse.append("\"admin\":{");
            jsonResponse.append("\"id\":\"").append(escapeJson(adminUser.getId())).append("\",");  // Changed to string format
            jsonResponse.append("\"fullName\":\"").append(escapeJson(adminUser.getFullName())).append("\",");
            jsonResponse.append("\"email\":\"").append(escapeJson(adminUser.getEmail())).append("\"");
            jsonResponse.append("},");

            // Counts data
            jsonResponse.append("\"counts\":{");
            jsonResponse.append("\"employers\":").append(employersCount).append(",");
            jsonResponse.append("\"recruiters\":").append(recruitersCount).append(",");
            jsonResponse.append("\"jobseekers\":").append(jobseekersCount).append(",");
            jsonResponse.append("\"counselors\":").append(counselorsCount).append(",");
            jsonResponse.append("\"adminAssistants\":").append(adminAssistantsCount);
            jsonResponse.append("}");

            jsonResponse.append("}");

            // 5. Send JSON response
            out.print(jsonResponse.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            String errorJson = "{\"error\":\"Internal server error: " + escapeJson(e.getMessage()) + "\"}";
            out.print(errorJson);
        } finally {
            out.close();
        }
    }

    // Helper method to escape JSON strings
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}