package controller;

import dao.JobNotificationDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/DeleteNotificationServlet")
public class DeleteNotificationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String notificationId = request.getParameter("notificationId");

        JobNotificationDAO dao = new JobNotificationDAO();
        boolean success = dao.deleteNotification(notificationId);

        response.setContentType("text/plain");
        response.getWriter().write(success ? "SUCCESS" : "FAILED");
    }
}