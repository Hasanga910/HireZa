package servlet;

import dao.InterviewDAO;
import model.Interview;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/EditInterviewServlet")
public class EditInterviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Interview interview = new Interview();
            interview.setInterviewId(request.getParameter("interviewId"));
            interview.setApplicationId(request.getParameter("applicationId"));
            interview.setCompanyId(request.getParameter("companyId"));
            interview.setUserId(request.getParameter("userId"));
            interview.setJobId(request.getParameter("jobId"));
            interview.setInterviewer(request.getParameter("interviewer"));
            interview.setLocation(request.getParameter("location"));
            interview.setMode(request.getParameter("mode"));
            interview.setScheduledAt(LocalDateTime.parse(request.getParameter("scheduledAt")));
            interview.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
            interview.setNotes(request.getParameter("notes"));
            interview.setStatus(request.getParameter("status"));

            InterviewDAO interviewDAO = new InterviewDAO();
            boolean success = interviewDAO.updateInterview(interview);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/Recruiter/interview_details.jsp?interviewId=" + interview.getInterviewId() + "&success=Interview updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/Recruiter/edit_interview.jsp?interviewId=" + interview.getInterviewId() + "&error=Failed to update interview");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Recruiter/edit_interview.jsp?interviewId=" + request.getParameter("interviewId") + "&error=An error occurred");
        }
    }
}