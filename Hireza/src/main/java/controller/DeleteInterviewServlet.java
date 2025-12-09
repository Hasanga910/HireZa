package controller;

import dao.InterviewDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteInterviewServlet")
public class DeleteInterviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Keep interviewId as String
            String interviewId = request.getParameter("interviewId");

            if (interviewId == null || interviewId.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp?error=Missing interview ID");
                return;
            }

            InterviewDAO interviewDAO = new InterviewDAO();
            boolean success = interviewDAO.deleteInterview(interviewId); // ✅ use string directly

            if (success) {
                response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp?success=Interview deleted successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp?error=Failed to delete interview");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp?error=An error occurred while deleting interview");
        }
    }
}
