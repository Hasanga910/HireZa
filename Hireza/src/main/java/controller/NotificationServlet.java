package controller;

import dao.NotificationDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "NotificationServlet", urlPatterns = {
        "/company/mark-notification-read",
        "/company/mark-all-notifications-read",
        "/company/notification-count",
        "/company/delete-all-notifications"  // Add this
})
public class NotificationServlet extends HttpServlet {
    private NotificationDAO notificationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/company/notification-count".equals(path)) {
            getUnreadNotificationCount(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/company/mark-notification-read".equals(path)) {
            markNotificationAsRead(request, response);
        } else if ("/company/mark-all-notifications-read".equals(path)) {
            markAllNotificationsAsRead(request, response);
        } else if ("/company/delete-all-notifications".equals(path)) { // Add this
            deleteAllNotifications(request, response);
        }
    }

    private void markNotificationAsRead(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String notificationId = request.getParameter("notificationId");

            if (notificationId == null || notificationId.trim().isEmpty()) {
                out.print("{\"success\": false, \"error\": \"Notification ID is required\"}");
                return;
            }

            boolean success = notificationDAO.markAsRead(notificationId.trim());
            out.print("{\"success\": " + success + "}");

        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"success\": false, \"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
            }
        }
    }

    private void markAllNotificationsAsRead(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String companyId = request.getParameter("companyId");

            if (companyId == null || companyId.trim().isEmpty()) {
                // Try to get companyId from session if not in parameters
                HttpSession session = request.getSession(false);
                if (session != null) {
                    companyId = (String) session.getAttribute("companyId");
                }
            }

            if (companyId == null || companyId.trim().isEmpty()) {
                out.print("{\"success\": false, \"error\": \"Company ID is required\"}");
                return;
            }

            boolean success = notificationDAO.markAllAsRead(companyId.trim());
            out.print("{\"success\": " + success + "}");

        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"success\": false, \"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
            }
        }
    }

    private void getUnreadNotificationCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String companyId = request.getParameter("companyId");

            if (companyId == null || companyId.trim().isEmpty()) {
                // Try to get companyId from session if not in parameters
                HttpSession session = request.getSession(false);
                if (session != null) {
                    companyId = (String) session.getAttribute("companyId");
                }
            }

            if (companyId == null || companyId.trim().isEmpty()) {
                out.print("{\"unreadCount\": 0, \"error\": \"Company ID is required\"}");
                return;
            }

            int unreadCount = notificationDAO.getUnreadNotificationCount(companyId.trim());
            out.print("{\"unreadCount\": " + unreadCount + "}");

        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"unreadCount\": 0, \"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
            }
        }
    }

    private void deleteAllNotifications(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String companyId = request.getParameter("companyId");

            if (companyId == null || companyId.trim().isEmpty()) {
                // Try to get companyId from session if not in parameters
                HttpSession session = request.getSession(false);
                if (session != null) {
                    companyId = (String) session.getAttribute("companyId");
                }
            }

            if (companyId == null || companyId.trim().isEmpty()) {
                out.print("{\"success\": false, \"error\": \"Company ID is required\"}");
                return;
            }

            boolean success = notificationDAO.deleteAllNotifications(companyId.trim());
            out.print("{\"success\": " + success + "}");

        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"success\": false, \"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
            }
        }
    }
}