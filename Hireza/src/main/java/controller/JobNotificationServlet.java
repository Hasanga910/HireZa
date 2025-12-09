package controller;

import dao.JobNotificationDAO;
import model.Notification2;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;

@WebServlet(name = "JobNotificationServlet", urlPatterns = {
        "/company/job-notifications",
        "/company/job-notification-count",
        "/company/mark-job-notification-read",
        "/company/mark-all-job-notifications-read",
        "/company/delete-all-job-notifications"
})
public class JobNotificationServlet extends HttpServlet {

    private JobNotificationDAO notificationDAO = new JobNotificationDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String path = request.getServletPath();
        String companyId = request.getParameter("companyId");

        if (companyId == null || companyId.trim().isEmpty()) {
            out.print("{\"success\": false, \"error\": \"Company ID is required\"}");
            return;
        }

        try {
            switch (path) {
                case "/company/job-notifications":
                    handleGetNotifications(companyId, out);
                    break;

                case "/company/job-notification-count":
                    handleGetCount(companyId, out);
                    break;

                default:
                    out.print("{\"success\": false, \"error\": \"Unknown action\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String path = request.getServletPath();

        try {
            switch (path) {
                case "/company/mark-job-notification-read":
                    handleMarkAsRead(request, out);
                    break;

                case "/company/mark-all-job-notifications-read":
                    handleMarkAllAsRead(request, out);
                    break;

                case "/company/delete-all-job-notifications":
                    handleDeleteAll(request, out);
                    break;

                default:
                    out.print("{\"success\": false, \"error\": \"Unknown action\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private void handleGetNotifications(String companyId, PrintWriter out) {
        List<Notification2> notifications = notificationDAO.getNotificationsByCompanyId(companyId);
        String json = gson.toJson(notifications);
        out.print("{\"success\": true, \"notifications\": " + json + "}");
    }

    private void handleGetCount(String companyId, PrintWriter out) {
        int unreadCount = notificationDAO.getUnreadNotificationsCount(companyId);
        out.print("{\"success\": true, \"unreadCount\": " + unreadCount + "}");
    }

    private void handleMarkAsRead(HttpServletRequest request, PrintWriter out) {
        String notificationId = request.getParameter("notificationId");

        if (notificationId == null || notificationId.trim().isEmpty()) {
            out.print("{\"success\": false, \"error\": \"Notification ID is required\"}");
            return;
        }

        boolean success = notificationDAO.markAsRead(notificationId);

        if (success) {
            out.print("{\"success\": true}");
        } else {
            out.print("{\"success\": false, \"error\": \"Failed to mark notification as read\"}");
        }
    }

    private void handleMarkAllAsRead(HttpServletRequest request, PrintWriter out) {
        String companyId = request.getParameter("companyId");

        if (companyId == null || companyId.trim().isEmpty()) {
            out.print("{\"success\": false, \"error\": \"Company ID is required\"}");
            return;
        }

        boolean success = notificationDAO.markAllAsRead(companyId);

        if (success) {
            out.print("{\"success\": true}");
        } else {
            out.print("{\"success\": false, \"error\": \"Failed to mark all notifications as read\"}");
        }
    }

    private void handleDeleteAll(HttpServletRequest request, PrintWriter out) {
        String companyId = request.getParameter("companyId");

        if (companyId == null || companyId.trim().isEmpty()) {
            out.print("{\"success\": false, \"error\": \"Company ID is required\"}");
            return;
        }

        boolean success = notificationDAO.deleteAllNotifications(companyId);

        if (success) {
            out.print("{\"success\": true}");
        } else {
            out.print("{\"success\": false, \"error\": \"Failed to delete all notifications\"}");
        }
    }
}