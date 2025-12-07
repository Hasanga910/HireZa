<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Only try to use notifications if they exist in this context
    List<Notification> modalNotifications = null;
    try {
        modalNotifications = (List<Notification>) request.getAttribute("notifications");
        if (modalNotifications == null) {
            // Try to get from page context (for dashboard)
            Object notificationsObj = pageContext.getAttribute("notifications", PageContext.PAGE_SCOPE);
            if (notificationsObj == null) {
                notificationsObj = pageContext.findAttribute("notifications");
            }
            if (notificationsObj instanceof List) {
                modalNotifications = (List<Notification>) notificationsObj;
            }
        }
    } catch (Exception e) {
        // Notifications not available in this context
    }
%>
<div id="all-notifications-modal" class="all-notifications-modal">
    <div class="all-notifications-modal-content">
        <span class="close" onclick="closeAllNotificationsModal()">&times;</span>
        <h2>All Notifications</h2>
        <div class="notification-list" id="modal-notification-list">
            <% if (modalNotifications != null && !modalNotifications.isEmpty()) { %>
            <% for (Notification notification : modalNotifications) {
                String itemClass = "notification-item";
                if (!notification.getIsRead()) itemClass += " unread";
                itemClass += " " + notification.getType();
                String message = notification.getMessage().replace("\"", "\\\"").replace("'", "\\'");
                String jobTitle = notification.getJobTitle() != null ? notification.getJobTitle().replace("\"", "\\\"").replace("'", "\\'") : "";
                String adminNotes = notification.getAdminNotes() != null ? notification.getAdminNotes().replace("\"", "\\\"").replace("'", "\\'") : "";
                String time = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(notification.getCreatedAt());
            %>
            <div class="<%= itemClass %>"
                 data-notification-id="<%= notification.getNotificationId() %>"
                 onclick="showDetails('<%= message %>', '<%= jobTitle %>', '<%= adminNotes %>', '<%= time %>')">
                <div class="notification-content">
                    <div class="notification-message"><%= notification.getMessage() %></div>
                    <div class="notification-job-title"><strong>Job:</strong> <%= notification.getJobTitle() %></div>
                    <% if (notification.getAdminNotes() != null && !notification.getAdminNotes().trim().isEmpty()) { %>
                    <div class="notification-notes"><strong>Notes:</strong> <%= notification.getAdminNotes() %></div>
                    <% } %>
                    <div class="notification-time"><%= time %></div>
                    <% if (!notification.getIsRead()) { %>
                    <button class="notification-mark-read-btn"
                            onclick="event.stopPropagation(); markAsReadWithButton('<%= notification.getNotificationId() %>', this)">
                        <i class="fas fa-check"></i> Mark as Read
                    </button>
                    <% } %>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <div class="no-notifications">Loading notifications...</div>
            <% } %>
        </div>
    </div>
</div>

<div id="notification-details-modal" class="notification-details-modal">
    <div class="notification-details-modal-content">
        <span class="close" onclick="closeDetailsModal()">&times;</span>
        <h2>Notification Details</h2>
        <p><strong>Message:</strong> <span id="details-message"></span></p>
        <p><strong>Job Title:</strong> <span id="details-job"></span></p>
        <p><strong>Admin Notes:</strong> <span id="details-notes"></span></p>
        <p><strong>Time:</strong> <span id="details-time"></span></p>
    </div>
</div>