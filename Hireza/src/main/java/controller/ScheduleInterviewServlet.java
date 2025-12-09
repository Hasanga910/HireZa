//package servlet;
//
//import dao.InterviewDAO;
//import dao.JobApplicationDAO;
//import model.Interview;
//import model.JobApplication;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.time.LocalDateTime;
//
//@WebServlet("/ScheduleInterviewServlet")
//public class ScheduleInterviewServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        try {
//            Interview interview = new Interview();
//            String applicationId = request.getParameter("applicationId");
//            interview.setApplicationId(applicationId);
//            interview.setCompanyId(request.getParameter("companyId"));
//            interview.setUserId(request.getParameter("userId"));
//
//            // Fetch jobId from JobApplication
//            JobApplicationDAO applicationDAO = new JobApplicationDAO();
//            JobApplication application = applicationDAO.getApplicationById(applicationId);
//            if (application == null) {
//                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Invalid application ID");
//                return;
//            }
//            interview.setJobId(application.getJobId());
//
//            interview.setInterviewer(request.getParameter("interviewer"));
//            interview.setLocation(request.getParameter("location"));
//            interview.setMode(request.getParameter("mode"));
//            interview.setScheduledAt(LocalDateTime.parse(request.getParameter("scheduledAt")));
//            interview.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
//            interview.setNotes(request.getParameter("notes"));
//            interview.setStatus(request.getParameter("status"));
//
//            InterviewDAO interviewDAO = new InterviewDAO();
//            boolean success = interviewDAO.saveInterview(interview);
//
//            if (success) {
//                response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp?success=Interview scheduled successfully");
//            } else {
//                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Failed to schedule interview");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=An error occurred");
//        }
//    }
//}



package controller;

import dao.InterviewDAO;
import dao.JobApplicationDAO;
import dao.RecruiterActivityDAO;
import dao.RecruiterDAO;
import model.Interview;
import model.JobApplication;
import model.Recruiter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

@WebServlet("/ScheduleInterviewServlet")
public class ScheduleInterviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("=== ScheduleInterviewServlet: START ===");

            Interview interview = new Interview();
            String applicationId = request.getParameter("applicationId");
            String userId = request.getParameter("userId");
            System.out.println("Application ID: " + applicationId);

            // Validate required parameters
            if (applicationId == null || applicationId.trim().isEmpty()) {
                System.err.println("ERROR: Application ID is missing");
                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Application ID is required");
                return;
            }
            if (userId == null || userId.trim().isEmpty()) {
                System.err.println("ERROR: User ID is missing");
                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=User ID is required");
                return;
            }

            interview.setApplicationId(applicationId);
            interview.setCompanyId(request.getParameter("companyId"));
            interview.setUserId(userId);

            System.out.println("Company ID: " + interview.getCompanyId());
            System.out.println("User ID: " + userId);

            // Fetch jobId from JobApplication
            JobApplicationDAO applicationDAO = new JobApplicationDAO();
            JobApplication application = applicationDAO.getApplicationById(applicationId);
            if (application == null) {
                System.err.println("ERROR: Invalid application ID: " + applicationId);
                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Invalid application ID: " + applicationId);
                return;
            }
            interview.setJobId(application.getJobId());
            System.out.println("Job ID: " + interview.getJobId());

            interview.setInterviewer(request.getParameter("interviewer"));
            interview.setLocation(request.getParameter("location"));
            interview.setMode(request.getParameter("mode"));

            System.out.println("Interviewer: " + interview.getInterviewer());
            System.out.println("Mode: " + interview.getMode());

            // Parse date with better error handling
            String scheduledAtStr = request.getParameter("scheduledAt");
            System.out.println("Scheduled At (raw): " + scheduledAtStr);

            try {
                LocalDateTime scheduledAt = LocalDateTime.parse(scheduledAtStr);
                interview.setScheduledAt(scheduledAt);
                System.out.println("Scheduled At (parsed): " + scheduledAt);
            } catch (DateTimeParseException e) {
                System.err.println("ERROR: Invalid date format: " + scheduledAtStr);
                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Invalid date format");
                return;
            }

            // Parse duration with validation
            try {
                int duration = Integer.parseInt(request.getParameter("durationMinutes"));
                if (duration <= 0 || duration > 480) {
                    System.err.println("ERROR: Duration out of range: " + duration);
                    response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Duration must be between 1 and 480 minutes");
                    return;
                }
                interview.setDurationMinutes(duration);
                System.out.println("Duration: " + duration);
            } catch (NumberFormatException e) {
                System.err.println("ERROR: Invalid duration format");
                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Invalid duration");
                return;
            }

            interview.setNotes(request.getParameter("notes"));
            interview.setStatus(request.getParameter("status"));
            System.out.println("Status: " + interview.getStatus());

            System.out.println("Attempting to save interview...");
            InterviewDAO interviewDAO = new InterviewDAO();
            boolean success = interviewDAO.saveInterview(interview);

            if (success) {
                // Log the interview scheduling action
                RecruiterActivityDAO activityDAO = new RecruiterActivityDAO();
                RecruiterDAO recruiterDAO = new RecruiterDAO();
                Recruiter recruiter = recruiterDAO.getRecruiterByUserId(userId);
                if (recruiter != null) {
                    String action = "Scheduled interview for application ID: " + applicationId + " with status: " + interview.getStatus();
                    boolean activityLogged = activityDAO.saveActivity(recruiter.getRecruiterId(), applicationId, action);
                    if (activityLogged) {
                        System.out.println("✅ Interview scheduling activity logged successfully for application: " + applicationId);
                    } else {
                        System.err.println("⚠️ Failed to log interview scheduling activity for application: " + applicationId);
                    }
                } else {
                    System.err.println("⚠️ Recruiter not found for user ID: " + userId);
                }

                System.out.println("✅ Interview scheduled successfully for application: " + applicationId);
                response.sendRedirect(request.getContextPath() + "/Recruiter/recruiter_dashboard.jsp?success=Interview scheduled successfully");
            } else {
                System.err.println("❌ Failed to schedule interview for application: " + applicationId);
                response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=Failed to schedule interview");
            }

            System.out.println("=== ScheduleInterviewServlet: END ===");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("❌ Error in ScheduleInterviewServlet: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Recruiter/schedule_interview.jsp?error=An error occurred: " + e.getMessage());
        }
    }
}
