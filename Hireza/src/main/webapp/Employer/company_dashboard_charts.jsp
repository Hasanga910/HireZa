<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, dao.CompanyDAO, model.Company" %>
<%@ page import="dao.JobPostDAO, dao.JobApplicationDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="model.JobPost, model.JobApplication" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Employer".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }

    CompanyDAO companyDAO = new CompanyDAO();
    Company company = companyDAO.getCompanyByUserId(user.getId());
    String companyId = (company != null) ? company.getCompanyId() : "0";
    String companyLogo = (company != null) ? request.getContextPath() + "/company/logo?companyId=" + company.getCompanyId() : "https://via.placeholder.com/30?text=Logo";
    String companyName = (company != null && company.getCompanyName() != null) ? company.getCompanyName() : "Company Name";

    JobPostDAO jobPostDAO = new JobPostDAO();
    JobApplicationDAO jobApplicationDAO = new JobApplicationDAO();

    // Jobs by Employment Type & Job Status
    List<JobPost> posts = jobPostDAO.getAllJobPostsByCompanyId(companyId);
    Map<String, Integer> jobsByType = new HashMap<>();
    Map<String, Integer> jobStatusCount = new HashMap<>();
    for (JobPost post : posts) {
        String type = (post.getEmploymentType() != null) ? post.getEmploymentType() : "Unknown";
        jobsByType.put(type, jobsByType.getOrDefault(type, 0) + 1);

        String status = (post.getStatus() != null) ? post.getStatus() : "Unknown";
        jobStatusCount.put(status, jobStatusCount.getOrDefault(status, 0) + 1);
    }

    // Applications per Job & Applications Over Time
    Map<String, Integer> applicationsByJob = new HashMap<>();
    Map<String, Integer> applicationsOverTime = new TreeMap<>();
    for (JobPost post : posts) {
        List<JobApplication> apps = jobApplicationDAO.getApplicationsByJobId(post.getJobId());
        applicationsByJob.put(post.getJobTitle(), apps.size());

        for (JobApplication app : apps) {
            java.util.Date dateObj = app.getAppliedAt();
            if (dateObj != null) {
                String date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(dateObj);
                applicationsOverTime.put(date, applicationsOverTime.getOrDefault(date, 0) + 1);
            }
        }
    }
%>
<%@ page import="dao.NotificationDAO" %>
<%@ page import="model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Fetch notifications and unread count
    NotificationDAO notifDAO = new NotificationDAO();
    session.setAttribute("companyId", companyId); // Store companyId in session
    int unreadCount = notifDAO.getUnreadNotificationCount(companyId);
    List<Notification> notifications = notifDAO.getNotificationsByCompanyId(companyId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Dashboard Charts</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <style>
        /* Global Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        /* Navbar Styles */
        .navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            transition: top 0.3s ease;
            height: 60px;
        }

        .navbar.hidden {
            top: -60px;
        }

        .navbar .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: #007bff;
            white-space: nowrap;
            display: flex;
            align-items: center;
        }

        .navbar .logo img {
            height: 2.2rem;
            width: auto;
            margin-right: 0.5rem;
            object-fit: contain;
            vertical-align: middle;
        }

        /* Right Section Styles */
        .right-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        /* Notification Bell Styles */
        .notification-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .notification-bell {
            position: relative;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: #007bff;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 50%;
            transition: background-color 0.3s;
        }

        .notification-bell:hover {
            background-color: #f8f9fa;
        }

        .notification-badge {
            position: absolute;
            top: 0;
            right: 0;
            background-color: #dc3545;
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* Notification Dropdown */
        .notification-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            width: 400px;
            max-height: 500px;
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            z-index: 1000;
            overflow: hidden;
            flex-direction: column;
        }

        .notification-list {
            max-height: 350px;
            overflow-y: auto;
            overflow-x: hidden;
            flex: 1;
            min-height: 0;
        }

        .notification-mark-read-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 0.3rem 0.6rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.75rem;
            margin-top: 0.5rem;
            transition: background-color 0.3s;
        }

        .notification-mark-read-btn:hover {
            background-color: #0056b3;
        }

        .notification-mark-read-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .notification-dropdown.show {
            display: flex;
        }

        .notification-header {
            padding: 1rem;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
            background-color: white;
        }

        .notification-header h3 {
            margin: 0;
            color: #333;
            font-size: 1.1rem;
        }

        .notification-actions {
            display: flex;
            gap: 0.5rem;
        }

        .notification-item {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .notification-item:hover {
            background-color: #f8f9fa;
        }

        .notification-item.unread {
            background-color: #f0f7ff;
            border-left: 3px solid #007bff;
        }

        .notification-item.approved {
            border-left: 3px solid #28a745;
        }

        .notification-item.rejected {
            border-left: 3px solid #dc3545;
        }

        .notification-content {
            display: flex;
            flex-direction: column;
        }

        .notification-message {
            font-weight: 500;
            margin-bottom: 0.25rem;
            color: #333;
        }

        .notification-job-title {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.25rem;
        }

        .notification-notes {
            font-size: 0.85rem;
            color: #888;
            font-style: italic;
            margin-bottom: 0.25rem;
        }

        .notification-time {
            font-size: 0.8rem;
            color: #999;
        }

        .notification-footer {
            padding: 1rem;
            border-top: 1px solid #e0e0e0;
            text-align: center;
            flex-shrink: 0;
            background-color: white;
        }

        .notification-footer a {
            color: #007bff;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .notification-footer a:hover {
            text-decoration: underline;
        }

        .no-notifications {
            padding: 2rem 1rem;
            text-align: center;
            color: #999;
            font-style: italic;
        }

        .navbar .profile-box {
            position: relative;
            cursor: pointer;
            background-color: #f9fbfc;
            padding: 0.3rem 0.8rem;
            border-radius: 5px;
            border: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            height: 40px;
        }

        .navbar .profile-box img {
            width: 30px;
            height: 30px;
            margin-right: 0.5rem;
            object-fit: cover;
        }

        .navbar .profile-box .profile-info {
            display: flex;
            flex-direction: column;
        }

        .navbar .profile-box .profile-info span {
            font-size: 0.85rem;
            white-space: nowrap;
        }

        .navbar .profile-box .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 200px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            right: 0;
            z-index: 1;
            top: 100%;
            font-size: 0.95rem;
        }

        .navbar .profile-box:hover .dropdown-content {
            display: block;
        }

        .navbar .profile-box .dropdown-content a {
            color: #333;
            padding: 0.75rem 1rem;
            text-decoration: none;
            display: block;
            white-space: nowrap;
        }

        .navbar .profile-box .dropdown-content a:hover {
            background-color: #f4f7fa;
        }

        /* Sidebar Styles - FIXED TO MATCH OTHER FILES */
        .sidebar {
            width: 250px;
            background: linear-gradient(135deg, #1e3a8a, #172554);
            color: white;
            padding: 1.5rem;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 60px;
            height: calc(100vh - 60px);
            z-index: 900;
            transition: top 0.3s ease, transform 0.3s ease;
            display: flex;
            flex-direction: column;
            font-size: 1rem;
        }

        .sidebar.adjusted {
            top: 0;
            height: 100vh;
        }

        .sidebar.hidden {
            transform: translateX(-100%);
        }

        .sidebar.collapsed {
            width: 60px;
            padding: 1rem;
        }

        .sidebar.collapsed .header h2,
        .sidebar.collapsed .group-title,
        .sidebar.collapsed a span {
            display: none;
        }

        .sidebar.collapsed a {
            padding: 0.5rem;
            justify-content: center;
        }

        .sidebar.collapsed a i {
            margin: 0;
            font-size: 1.5rem;
        }

        /* FIXED: Match the header styling from other files */
        .sidebar .header {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            background: none;
            min-height: 1.2rem;
            line-height: 1.3;
            padding-bottom: 0.5rem;
        }

        .sidebar h2 {
            font-size: 1.2rem;
            margin: 0 0 0.5rem 0;
            color: #ffffff;
            border-bottom: 1px solid #334455;
            padding-bottom: 0.75rem;
            flex-grow: 1;
            background: none;
            line-height: 1.3;
        }

        .sidebar .toggle-icon {
            cursor: pointer;
            color: #aabbcc;
            font-size: 1.2rem;
            transition: transform 0.3s ease;
            padding: 0 0.5rem;
            line-height: 1.3;
            vertical-align: middle;
        }

        .sidebar .toggle-icon:hover {
            color: #ffffff;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
        }

        .sidebar li {
            margin-bottom: 0.5rem;
        }

        .sidebar li:first-child {
            margin-top: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .sidebar a {
            color: #aabbcc;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            font-size: 0.95rem;
            white-space: nowrap;
            line-height: 1.3;
        }

        .sidebar a i {
            margin-right: 0.5rem;
        }

        .sidebar a:hover {
            background-color: #007bff;
            color: white;
        }

        .sidebar .group-title {
            font-size: 0.85rem;
            color: #ccddee;
            margin: 1rem 0 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            line-height: 1.3;
        }

        .sidebar .sign-out {
            margin-top: 0.5rem;
            border-top: 1px solid #334455;
            padding-top: 0.5rem;
        }

        /* Toggle Button for Sidebar (Mobile) */
        .mobile-toggle-btn {
            display: none;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            position: fixed;
            top: 10px;
            left: 10px;
            z-index: 950;
        }

        .mobile-toggle-btn:hover {
            background-color: #0056b3;
        }

        /* Main Content Styles */
        .main-content {
            margin-left: 250px;
            padding: 6rem 2rem 2rem 5rem;
            width: calc(100% - 250px);
            box-sizing: border-box;
            min-height: calc(100vh - 60px);
            transition: margin-left 0.3s ease, width 0.3s ease, padding-right 0.3s ease;
        }

        .main-content.collapsed {
            margin-left: 0;
            padding: 6rem 2rem 2rem 4rem;
            width: 100%;
        }

        .main-content.expanded {
            margin-left: 60px;
            width: calc(100% - 60px);
            padding-right: 2rem;
            padding-left: 4rem;
        }

        /* Chart-Specific Styles */
        .chart-container {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .chart-container .chart-row {
            display: flex;
            justify-content: space-between;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .chart-container .chart-section {
            background-color: #ffffff;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            flex: 1;
            min-width: 0;
            border: 1px solid #e8ecef;
        }

        .chart-container canvas {
            background: #fafafa;
            border-radius: 8px;
            padding: 1rem;
            box-shadow: 0 1px 6px rgba(0, 0, 0, 0.05);
            height: 400px !important;
            width: 100% !important;
            max-width: 100%;
            box-sizing: border-box;
        }

        .chart-container h2 {
            color: #2c3e50;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
        }

        .chart-container h3 {
            color: #34495e;
            font-size: 1.2rem;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        /* Sign-out Modal */
        .signout-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .signout-modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            border-radius: 5px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .signout-modal-content h2 {
            font-size: 1.4rem;
            margin: 0 0 1rem;
            color: #333;
        }

        .signout-modal-content p {
            font-size: 1rem;
            color: #666;
            margin-bottom: 1.5rem;
        }

        .signout-modal-content button {
            padding: 0.5rem 1.5rem;
            margin: 0 0.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s;
        }

        .signout-modal-content .confirm-btn {
            background-color: #007bff;
            color: white;
        }

        .signout-modal-content .confirm-btn:hover {
            background-color: #0056b3;
        }

        .signout-modal-content .cancel-btn {
            background-color: #6c757d;
            color: white;
        }

        .signout-modal-content .cancel-btn:hover {
            background-color: #545b62;
        }

        /* Toast Notification */
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #007bff;
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            z-index: 10000;
            font-size: 14px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            animation: slideIn 0.3s ease, fadeOut 0.3s ease 2.7s forwards;
        }

        .toast-notification.error {
            background: #dc3545;
        }

        .toast-notification.success {
            background: #28a745;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 200px;
            }

            .main-content {
                margin-left: 200px;
                width: calc(100% - 200px);
                padding: 6rem 2rem 2rem 4rem;
            }

            .main-content.expanded {
                margin-left: 60px;
                width: calc(100% - 60px);
                padding-right: 2rem;
                padding-left: 4rem;
            }

            .notification-dropdown {
                width: 350px;
            }

            .chart-container .chart-row {
                flex-direction: column;
                gap: 1.5rem;
            }

            .chart-container .chart-section {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .navbar {
                flex-direction: row;
                padding: 1rem;
            }

            .notification-dropdown {
                width: 300px;
                right: -50px;
            }

            .sidebar {
                width: 100%;
                position: relative;
                top: 0;
                height: auto;
                padding: 1rem;
            }

            .sidebar.adjusted {
                top: 0;
                height: auto;
            }

            .sidebar.hidden {
                display: none;
            }

            .sidebar.collapsed {
                width: 100%;
            }

            .mobile-toggle-btn {
                display: block;
            }

            .main-content {
                margin-left: 0;
                padding: 6rem 2rem 2rem 4rem;
                width: 100%;
            }

            .main-content.collapsed {
                margin-left: 0;
                width: 100%;
                padding: 6rem 2rem 2rem 4rem;
            }

            .chart-container .chart-row {
                flex-direction: column;
                gap: 1.5rem;
            }

            .chart-container .chart-section {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .navbar .logo {
                font-size: 1.4rem;
                margin-bottom: 0.5rem;
            }

            .navbar .logo img {
                height: 1.7rem;
                width: auto;
            }

            .notification-dropdown {
                width: 280px;
                right: -80px;
            }

            .navbar .profile-box {
                padding: 0.2rem 0.6rem;
                height: 35px;
            }

            .navbar .profile-box img {
                width: 25px;
                height: 25px;
            }

            .navbar .profile-box .profile-info span {
                font-size: 0.75rem;
            }
        }



        /* Email Report Button */
        .email-report-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 50px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .email-report-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        .email-report-btn i {
            font-size: 1.2rem;
        }

        /* Email Modal */
        .email-modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(5px);
            animation: fadeIn 0.3s ease;
        }

        .email-modal-content {
            background: white;
            margin: 8% auto;
            padding: 0;
            border-radius: 15px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            animation: slideDown 0.3s ease;
            overflow: hidden;
        }

        .email-modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .email-modal-header h2 {
            margin: 0;
            font-size: 1.5rem;
            color: white;
        }

        .email-modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.8rem;
            cursor: pointer;
            padding: 0;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: background-color 0.3s;
        }

        .email-modal-close:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .email-modal-body {
            padding: 30px 25px;
        }

        .email-form-group {
            margin-bottom: 20px;
        }

        .email-form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .email-form-group input,
        .email-form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }

        .email-form-group input:focus,
        .email-form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .email-form-group textarea {
            resize: vertical;
            min-height: 100px;
            font-family: inherit;
        }

        .email-form-group small {
            display: block;
            margin-top: 5px;
            color: #666;
            font-size: 0.85rem;
        }

        .email-modal-footer {
            padding: 0 25px 25px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .email-modal-footer button {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: all 0.3s;
        }

        .send-email-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .send-email-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .send-email-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .cancel-email-btn {
            background-color: #f0f0f0;
            color: #333;
        }

        .cancel-email-btn:hover {
            background-color: #e0e0e0;
        }

        .email-loading {
            display: none;
            text-align: center;
            padding: 20px;
        }

        .email-loading i {
            font-size: 3rem;
            color: #667eea;
            animation: spin 1s linear infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Active sidebar menu item styling */
        .sidebar a.active {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.3);
            border-left: 4px solid #ffffff;
        }

        .sidebar a.active i {
            color: white;
        }

        .sidebar a.active:hover {
            background-color: #0056b3;
            color: white;
        }

        /* Specific styling for Dashboard when active */
        .sidebar li:first-child a.active {
            background: linear-gradient(135deg, #007bff, #0056b3);
            border-left: 4px solid #ffd700; /* Gold accent for dashboard */
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Navbar -->
    <nav class="navbar" id="navbar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/employer/1.jpg" alt="HireZa Logo">
            HireZa
        </div>
        <div class="right-section">
            <div class="notification-container">
                <button class="notification-bell" onclick="toggleNotifications()">
                    <i class="fas fa-bell"></i>
                    <% if (unreadCount > 0) { %>
                    <span class="notification-badge" id="notificationBadge"><%= unreadCount %></span>
                    <% } %>
                </button>
                <div class="notification-dropdown" id="notificationDropdown">
                    <div class="notification-header">
                        <h3>Notifications</h3>
                        <div class="notification-actions">
                            <% if (unreadCount > 0) { %>
                            <button class="clear-btn" onclick="markAllAsRead()" style="font-size: 0.8rem; padding: 0.25rem 0.5rem;">
                                <i class="fas fa-check-double"></i> Mark all read
                            </button>
                            <% } %>
                        </div>
                    </div>
                    <div class="notification-list">
                        <% if (notifications.isEmpty()) { %>
                        <div class="no-notifications">No notifications</div>
                        <% } else {
                            for (Notification notification : notifications) {
                                String itemClass = "notification-item";
                                if (!notification.getIsRead()) itemClass += " unread";
                                itemClass += " " + notification.getType();
                        %>
                        <div class="<%= itemClass %>"
                             data-notification-id="<%= notification.getNotificationId() %>"
                             onclick="showDetails('<%= notification.getMessage().replace("\"", "\\\"").replace("'", "\\'") %>', '<%= notification.getJobTitle() != null ? notification.getJobTitle().replace("\"", "\\\"").replace("'", "\\'") : "" %>', '<%= notification.getAdminNotes() != null ? notification.getAdminNotes().replace("\"", "\\\"").replace("'", "\\'") : "" %>', '<%= new java.text.SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(notification.getCreatedAt()) %>')">
                            <div class="notification-content">
                                <div class="notification-message"><%= notification.getMessage() %></div>
                                <div class="notification-job-title"><strong>Job:</strong> <%= notification.getJobTitle() %></div>
                                <% if (notification.getAdminNotes() != null && !notification.getAdminNotes().trim().isEmpty()) { %>
                                <div class="notification-notes"><strong>Notes:</strong> <%= notification.getAdminNotes() %></div>
                                <% } %>
                                <div class="notification-time">
                                    <%= new java.text.SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a").format(notification.getCreatedAt()) %>
                                </div>
                                <% if (!notification.getIsRead()) { %>
                                <button class="notification-mark-read-btn"
                                        onclick="event.stopPropagation(); markAsReadWithButton('<%= notification.getNotificationId() %>', this)">
                                    <i class="fas fa-check"></i> Mark as Read
                                </button>
                                <% } %>
                            </div>
                        </div>
                        <% } } %>
                    </div>
                    <div class="notification-footer">
                        <a href="#" onclick="showAllNotificationsModal()">View All Notifications</a>
                    </div>
                </div>
            </div>
            <div class="profile-box" onmouseover="this.querySelector('.dropdown-content').style.display='block'" onmouseout="this.querySelector('.dropdown-content').style.display='none'">
                <img src="<%= companyLogo %>" alt="Company Logo">
                <div class="profile-info">
                    <span><%= companyName %></span>
                </div>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/Employer/edit_user_profile.jsp">Edit User Profile</a>
                    <a href="${pageContext.request.contextPath}/company/profile">Edit Company Profile</a>
                    <a href="#" onclick="showSignOutModal()">Sign Out</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Toggle Button for Sidebar (Mobile) -->
    <button class="mobile-toggle-btn" onclick="toggleSidebar()">☰ Menu</button>

    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="header">
            <h2>Navigation</h2>
            <i class="fas fa-bars toggle-icon" onclick="toggleSidebarCollapse()"></i>
        </div>
        <ul>
            <li><a href="${pageContext.request.contextPath}/Employer/employer_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
            <li class="group-title">Jobs</li>
            <li><a href="${pageContext.request.contextPath}/company/jobs/post"><i class="fas fa-plus"></i> <span>Post New Job</span></a></li>
            <li><a href="${pageContext.request.contextPath}/company/jobs"><i class="fas fa-tasks"></i> <span>Manage Jobs</span></a></li>
            <li class="group-title">Team</li>
            <li><a href="${pageContext.request.contextPath}/Employer/manage_recruiters.jsp"><i class="fas fa-users"></i> <span>Manage Recruiters</span></a></li>
            <li><a href="${pageContext.request.contextPath}/company/recruiter-activity"><i class="fas fa-chart-line"></i> <span>Recruiter Activity</span></a></li>
            <li class="group-title">Profile</li>
            <li><a href="${pageContext.request.contextPath}/company/profile"><i class="fas fa-building"></i> <span>Company Profile</span></a></li>
            <li><a href="${pageContext.request.contextPath}/Employer/edit_user_profile.jsp"><i class="fas fa-user-edit"></i> <span>Edit User Profile</span></a></li>
            <li class="group-title">Applications</li>
            <li><a href="${pageContext.request.contextPath}/company/employer/applications"><i class="fas fa-file-alt"></i> <span>Employer View Applications</span></a></li>
<%--            <li><a href="${pageContext.request.contextPath}/company/dashboard/charts"><i class="fas fa-chart-bar"></i> <span>Dashboard Charts</span></a></li>--%>

            <li><a href="${pageContext.request.contextPath}/company/dashboard/charts" class="active"><i class="fas fa-tachometer-alt"></i> <span>Dashboard Charts</span></a></li>

            <li class="sign-out">
                <a href="#" onclick="showSignOutModal()"><i class="fas fa-sign-out-alt"></i> <span>Sign Out</span></a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="main-content" id="mainContent">
        <div class="chart-container">
            <h2>Dashboard Charts</h2>
            <div class="chart-row">
                <section class="chart-section">
                    <h3>Jobs by Employment Type</h3>
                    <canvas id="jobsChart"></canvas>
                </section>
                <section class="chart-section">
                    <h3>Applications per Job</h3>
                    <canvas id="applicationsChart"></canvas>
                </section>
            </div>
            <div class="chart-row">
                <section class="chart-section">
                    <h3>Total Applications Over Time</h3>
                    <canvas id="applicationsOverTimeChart"></canvas>
                </section>
                <section class="chart-section">
                    <h3>Job Post Status</h3>
                    <canvas id="jobStatusChart"></canvas>
                </section>
            </div>
        </div>
    </main>
</div>

<!-- Sign-out Modal -->
<div id="signout-modal" class="signout-modal">
    <div class="signout-modal-content">
        <h2>Confirm Sign Out</h2>
        <p>Are you sure you want to sign out?</p>
        <button class="confirm-btn" onclick="signOut()">Yes, Sign Out</button>
        <button class="cancel-btn" onclick="closeSignOutModal()">Cancel</button>
    </div>
</div>

<script>
    // Initialize Charts
    new Chart(document.getElementById('jobsChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: [<%= String.join(",", jobsByType.keySet().stream().map(s -> "\"" + s + "\"").toArray(String[]::new)) %>],
            datasets: [{
                label: 'Number of Jobs',
                data: [<%= String.join(",", jobsByType.values().stream().map(String::valueOf).toArray(String[]::new)) %>],
                backgroundColor: 'rgba(54,162,235,0.7)'
            }]
        }
    });

    new Chart(document.getElementById('applicationsChart').getContext('2d'), {
        type: 'pie',
        data: {
            labels: [<%= String.join(",", applicationsByJob.keySet().stream().map(s -> "\"" + s + "\"").toArray(String[]::new)) %>],
            datasets: [{
                data: [<%= String.join(",", applicationsByJob.values().stream().map(String::valueOf).toArray(String[]::new)) %>],
                backgroundColor: ['rgba(255,99,132,0.7)', 'rgba(54,162,235,0.7)', 'rgba(255,206,86,0.7)', 'rgba(75,192,192,0.7)', 'rgba(153,102,255,0.7)', 'rgba(255,159,64,0.7)']
            }]
        }
    });

    new Chart(document.getElementById('applicationsOverTimeChart').getContext('2d'), {
        type: 'line',
        data: {
            labels: [<%= String.join(",", applicationsOverTime.keySet().stream().map(s -> "\"" + s + "\"").toArray(String[]::new)) %>],
            datasets: [{
                label: 'Applications',
                data: [<%= String.join(",", applicationsOverTime.values().stream().map(String::valueOf).toArray(String[]::new)) %>],
                borderColor: 'rgba(75,192,192,1)',
                fill: false,
                tension: 0.1
            }]
        }
    });

    new Chart(document.getElementById('jobStatusChart').getContext('2d'), {
        type: 'pie',
        data: {
            labels: [<%= String.join(",", jobStatusCount.keySet().stream().map(s -> "\"" + s + "\"").toArray(String[]::new)) %>],
            datasets: [{
                data: [<%= String.join(",", jobStatusCount.values().stream().map(String::valueOf).toArray(String[]::new)) %>],
                backgroundColor: ['rgba(75,192,192,0.7)', 'rgba(255,206,86,0.7)', 'rgba(255,99,132,0.7)', 'rgba(153,102,255,0.7)']
            }]
        }
    });

    // Notification Functions
    function toggleNotifications() {
        const dropdown = document.getElementById('notificationDropdown');
        dropdown.classList.toggle('show');
        if (dropdown.classList.contains('show')) {
            document.addEventListener('click', closeNotificationsOnClickOutside);
        } else {
            document.removeEventListener('click', closeNotificationsOnClickOutside);
        }
    }

    function closeNotificationsOnClickOutside(event) {
        const dropdown = document.getElementById('notificationDropdown');
        const bell = document.querySelector('.notification-bell');
        if (!dropdown.contains(event.target) && !bell.contains(event.target)) {
            dropdown.classList.remove('show');
            document.removeEventListener('click', closeNotificationsOnClickOutside);
        }
    }

    function showNotification(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = 'toast-notification' + (type !== 'info' ? ' ' + type : '');
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => {
            toast.remove();
        }, 3000);
    }

    // Sidebar Functions
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        sidebar.classList.toggle('hidden');
        mainContent.classList.toggle('collapsed');
        showNotification(sidebar.classList.contains('hidden') ? 'Sidebar hidden' : 'Sidebar shown');
    }

    function toggleSidebarCollapse() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        const toggleIcon = document.querySelector('.toggle-icon');
        sidebar.classList.toggle('collapsed');
        mainContent.classList.toggle('expanded');
        toggleIcon.style.transform = sidebar.classList.contains('collapsed') ? 'rotate(180deg)' : 'rotate(0deg)';
        showNotification(sidebar.classList.contains('collapsed') ? 'Sidebar collapsed' : 'Sidebar expanded');
    }

    // Sign-out Modal Functions
    function showSignOutModal() {
        document.getElementById('signout-modal').style.display = 'block';
        showNotification('Sign out confirmation prompted');
    }

    function closeSignOutModal() {
        document.getElementById('signout-modal').style.display = 'none';
        showNotification('Sign out cancelled');
    }

    function signOut() {
        showNotification('Signing out...');
        setTimeout(() => {
            window.location.href = '${pageContext.request.contextPath}/LogoutServlet';
        }, 500);
    }

    // Initialize Sidebar State
    document.addEventListener('DOMContentLoaded', () => {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        // Ensure sidebar is visible and not collapsed by default
        sidebar.classList.remove('hidden', 'collapsed');
        mainContent.classList.remove('collapsed', 'expanded');
    });

    // Navbar and Sidebar Scroll Behavior
    let lastScrollTop = 0;
    const navbar = document.getElementById('navbar');
    const sidebar = document.getElementById('sidebar');
    const navbarHeight = navbar.offsetHeight;

    window.addEventListener('scroll', () => {
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        if (scrollTop > lastScrollTop && scrollTop > navbarHeight) {
            navbar.classList.add('hidden');
            sidebar.classList.add('adjusted');
            const notificationDropdown = document.getElementById('notificationDropdown');
            if (notificationDropdown && notificationDropdown.classList.contains('show')) {
                notificationDropdown.classList.remove('show');
                document.removeEventListener('click', closeNotificationsOnClickOutside);
            }
        } else if (scrollTop < lastScrollTop) {
            navbar.classList.remove('hidden');
            sidebar.classList.remove('adjusted');
        }
        lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
    });

    window.addEventListener('resize', () => {
        const sidebar = document.getElementById('sidebar');
        if (sidebar.classList.contains('adjusted')) {
            sidebar.style.top = '0';
            sidebar.style.height = '100vh';
        } else {
            sidebar.style.top = '60px';
            sidebar.style.height = `calc(100vh - ${navbarHeight}px)`;
        }
    });

    // Enhanced notification functions
    function markAsReadWithButton(notificationId, button) {
        console.log('Marking notification as read via button:', notificationId);

        button.disabled = true;
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Reading...';

        const notificationElement = button.closest('.notification-item');

        fetch('${pageContext.request.contextPath}/company/mark-notification-read', {
            method: 'POST',
            body: new URLSearchParams({
                notificationId: notificationId
            }),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    console.log('Notification marked as read successfully');
                    if (notificationElement) {
                        notificationElement.classList.remove('unread');
                        button.style.transition = 'opacity 0.3s';
                        button.style.opacity = '0';
                        setTimeout(() => button.remove(), 300);
                    }
                    updateNotificationBadge();
                    showNotification('Notification marked as read', 'success');
                } else {
                    console.error('Failed to mark notification as read:', data.error);
                    button.disabled = false;
                    button.innerHTML = '<i class="fas fa-check"></i> Mark as Read';
                    showNotification('Failed to mark notification as read', 'error');
                }
            })
            .catch(error => {
                console.error('Error marking notification as read:', error);
                button.disabled = false;
                button.innerHTML = '<i class="fas fa-check"></i> Mark as Read';
                showNotification('Error marking notification as read', 'error');
            });
    }

    function markAllAsRead() {
        document.querySelectorAll('.notification-item.unread').forEach(item => {
            item.classList.remove('unread');
        });

        updateNotificationBadge();

        const formData = new FormData();
        formData.append('companyId', '<%= companyId %>');

        fetch('${pageContext.request.contextPath}/company/mark-all-notifications-read', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('All notifications marked as read successfully');
                    showNotification('All notifications marked as read', 'success');
                    document.getElementById('notificationDropdown').classList.remove('show');
                } else {
                    console.error('Failed to mark all notifications as read:', data.error);
                    showNotification('Failed to mark all notifications as read', 'error');
                }
            })
            .catch(error => {
                console.error('Error marking all notifications as read:', error);
                showNotification('Error marking all notifications as read', 'error');
            });
    }

    function updateNotificationBadge() {
        const badge = document.getElementById('notificationBadge');
        const unreadItems = document.querySelectorAll('.notification-item.unread');
        const unreadCount = unreadItems.length;

        console.log('Updating badge, unread count:', unreadCount);

        if (unreadCount > 0) {
            if (badge) {
                badge.textContent = unreadCount;
            } else {
                createNotificationBadge(unreadCount);
            }
        } else {
            if (badge) {
                badge.remove();
            }
        }

        refreshNotificationCount();
    }

    function refreshNotificationCount() {
        fetch('${pageContext.request.contextPath}/company/notification-count?companyId=' + encodeURIComponent('<%= companyId %>'))
            .then(response => response.json())
            .then(data => {
                console.log('Server unread count:', data.unreadCount);
                const badge = document.getElementById('notificationBadge');
                const clientUnreadCount = document.querySelectorAll('.notification-item.unread').length;

                if (data.unreadCount !== clientUnreadCount) {
                    if (data.unreadCount > 0) {
                        if (badge) {
                            badge.textContent = data.unreadCount;
                        } else {
                            createNotificationBadge(data.unreadCount);
                        }
                    } else {
                        if (badge) {
                            badge.remove();
                        }
                    }
                }
            })
            .catch(error => console.error('Error refreshing notification count:', error));
    }

    function createNotificationBadge(count) {
        const bell = document.querySelector('.notification-bell');
        const badge = document.createElement('span');
        badge.className = 'notification-badge';
        badge.id = 'notificationBadge';
        badge.textContent = count;
        bell.appendChild(badge);
    }

    function checkNewNotifications() {
        fetch('${pageContext.request.contextPath}/company/notification-count?companyId=' + encodeURIComponent('<%= companyId %>'))
            .then(response => response.json())
            .then(data => {
                if (data.unreadCount > 0) {
                    const currentBadge = document.getElementById('notificationBadge');
                    if (currentBadge) {
                        const currentCount = parseInt(currentBadge.textContent);
                        if (data.unreadCount > currentCount) {
                            currentBadge.textContent = data.unreadCount;
                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');
                        }
                    } else {
                        createNotificationBadge(data.unreadCount);
                        if (data.unreadCount > 0) {
                            showNotification(`You have ${data.unreadCount} new notifications`, 'info');
                        }
                    }
                }
            })
            .catch(error => console.error('Error checking notifications:', error));
    }

    function showAllNotificationsModal() {
        document.getElementById('all-notifications-modal').style.display = 'block';
    }

    function closeAllNotificationsModal() {
        document.getElementById('all-notifications-modal').style.display = 'none';
    }

    function showDetails(message, jobTitle, adminNotes, time) {
        alert('Message: ' + message + '\nJob: ' + jobTitle + '\nNotes: ' + adminNotes + '\nTime: ' + time);
    }

    // Request notification permission on page load
    document.addEventListener('DOMContentLoaded', function() {
        if ('Notification' in window && Notification.permission === 'default') {
            Notification.requestPermission();
        }

        // Check for new notifications every 30 seconds
        setInterval(() => {
            checkNewNotifications();
        }, 30000);
    });





















    // Send email report using Web3Forms API
    async function sendEmailReport() {
        const form = document.getElementById('email-report-form');
        const sendBtn = document.getElementById('send-btn');
        const loading = document.getElementById('email-loading');

        // Validate form
        if (!form.checkValidity()) {
            form.reportValidity();
            return;
        }

        // Show loading
        form.style.display = 'none';
        loading.style.display = 'block';
        sendBtn.disabled = true;

        const fromEmail = document.getElementById('from-email').value;
        const toEmail = document.getElementById('to-email').value;
        const userMessage = document.getElementById('email-message').value;
        const reportHTML = generateReportHTML();
        const companyName = '<%= companyName %>';

        // Prepare email content
        const emailSubject = '📊 Dashboard Report from ' + companyName;

        // Build complete HTML email
        let fullHTML = '<!DOCTYPE html><html><head><meta charset="UTF-8"></head><body style="margin:0;padding:0;font-family:Arial,sans-serif;">';

        // Add user message if provided
        if (userMessage && userMessage.trim()) {
            fullHTML += '<div style="background: #f8f9fa; padding: 20px; border-left: 4px solid #667eea; margin: 20px auto; max-width: 800px;">';
            fullHTML += '<p style="margin: 0; color: #333;"><strong>Message from ' + fromEmail + ':</strong></p>';
            fullHTML += '<p style="margin: 10px 0 0; color: #666;">' + userMessage.replace(/\n/g, '<br>') + '</p>';
            fullHTML += '</div>';
        }

        // Add report
        fullHTML += reportHTML;

        // Add footer
        fullHTML += '<div style="margin: 30px auto 20px; padding: 20px; background: #f8f9fa; text-align: center; border-top: 3px solid #667eea; max-width: 800px;">';
        fullHTML += '<p style="margin: 0; color: #999; font-size: 12px;">This email was sent from HireZa Dashboard System</p>';
        fullHTML += '<p style="margin: 5px 0 0; color: #999; font-size: 12px;">Reply to: ' + fromEmail + '</p>';
        fullHTML += '</div>';
        fullHTML += '</body></html>';

        try {
            // Create FormData for proper HTML handling
            const formData = new FormData();
            formData.append('access_key', '930e9ebb-a3ad-4844-bef9-61029381e546');
            formData.append('subject', emailSubject);
            formData.append('from_name', companyName + ' Dashboard');
            formData.append('email', toEmail); // This is the TO address
            formData.append('replyto', fromEmail);
            formData.append('message', fullHTML);
            formData.append('content_type', 'text/html'); // Important: Tell Web3Forms this is HTML

            // Send via Web3Forms API
            const response = await fetch('https://api.web3forms.com/submit', {
                method: 'POST',
                body: formData
            });

            const result = await response.json();

            if (result.success) {
                showNotification('Report sent successfully! ✅', 'success');
                closeEmailModal();
            } else {
                showNotification('Failed to send report: ' + (result.message || 'Unknown error'), 'error');
                form.style.display = 'block';
                loading.style.display = 'none';
                sendBtn.disabled = false;
            }
        } catch (error) {
            console.error('Error:', error);
            showNotification('Failed to send report. Please check your internet connection. ❌', 'error');
            form.style.display = 'block';
            loading.style.display = 'none';
            sendBtn.disabled = false;
        }
    }














    // Show email modal
    function showEmailModal() {
        document.getElementById('email-modal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    // Close email modal
    function closeEmailModal() {
        document.getElementById('email-modal').style.display = 'none';
        document.body.style.overflow = 'auto';
        document.getElementById('email-report-form').reset();
    }

    // Generate report data as HTML
    function generateReportHTML() {
        const companyName = '<%= companyName %>';
        const currentDate = new Date().toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });

        // Get chart data
        const jobsByType = {
            <%
            boolean first = true;
            for (Map.Entry<String, Integer> entry : jobsByType.entrySet()) {
                if (!first) out.print(", ");
                out.print("\"" + entry.getKey() + "\": " + entry.getValue());
                first = false;
            }
            %>
        };

        const applicationsByJob = {
            <%
            first = true;
            for (Map.Entry<String, Integer> entry : applicationsByJob.entrySet()) {
                if (!first) out.print(", ");
                out.print("\"" + entry.getKey().replace("\"", "\\\"") + "\": " + entry.getValue());
                first = false;
            }
            %>
        };

        const jobStatusCount = {
            <%
            first = true;
            for (Map.Entry<String, Integer> entry : jobStatusCount.entrySet()) {
                if (!first) out.print(", ");
                out.print("\"" + entry.getKey() + "\": " + entry.getValue());
                first = false;
            }
            %>
        };

        const totalJobs = <%= posts.size() %>;
        const totalApplications = <%= applicationsByJob.values().stream().mapToInt(Integer::intValue).sum() %>;

        // Build HTML report using string concatenation
        let html = '<div style="font-family: Segoe UI, Arial, sans-serif; max-width: 800px; margin: 0 auto; background-color: #f8f9fa; padding: 20px;">';
        html += '<div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px 10px 0 0; text-align: center;">';
        html += '<h1 style="margin: 0; font-size: 28px;">📊 Dashboard Report</h1>';
        html += '<p style="margin: 10px 0 0; font-size: 18px;">' + companyName + '</p>';
        html += '<p style="margin: 5px 0 0; opacity: 0.9;">Generated on ' + currentDate + '</p>';
        html += '</div>';

        html += '<div style="background: white; padding: 30px; border-radius: 0 0 10px 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">';
        html += '<h2 style="color: #333; border-bottom: 3px solid #667eea; padding-bottom: 10px; margin-top: 0;">Executive Summary</h2>';
        html += '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px;">';
        html += '<div style="background: #e3f2fd; padding: 20px; border-radius: 8px; text-align: center;">';
        html += '<div style="font-size: 36px; font-weight: bold; color: #1976d2;">' + totalJobs + '</div>';
        html += '<div style="color: #666; margin-top: 5px;">Total Jobs Posted</div>';
        html += '</div>';
        html += '<div style="background: #f3e5f5; padding: 20px; border-radius: 8px; text-align: center;">';
        html += '<div style="font-size: 36px; font-weight: bold; color: #7b1fa2;">' + totalApplications + '</div>';
        html += '<div style="color: #666; margin-top: 5px;">Total Applications</div>';
        html += '</div>';
        html += '</div>';

        html += '<h2 style="color: #333; border-bottom: 3px solid #667eea; padding-bottom: 10px; margin-top: 30px;">Jobs by Employment Type</h2>';
        html += '<table style="width: 100%; border-collapse: collapse; margin-bottom: 30px;">';
        html += '<thead><tr style="background-color: #f5f5f5;">';
        html += '<th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Employment Type</th>';
        html += '<th style="padding: 12px; text-align: center; border-bottom: 2px solid #ddd;">Number of Jobs</th>';
        html += '</tr></thead><tbody>';

        for (const [type, count] of Object.entries(jobsByType)) {
            html += '<tr style="border-bottom: 1px solid #eee;">';
            html += '<td style="padding: 12px;">' + type + '</td>';
            html += '<td style="padding: 12px; text-align: center; font-weight: bold; color: #667eea;">' + count + '</td>';
            html += '</tr>';
        }

        html += '</tbody></table>';

        html += '<h2 style="color: #333; border-bottom: 3px solid #667eea; padding-bottom: 10px; margin-top: 30px;">Applications per Job</h2>';
        html += '<table style="width: 100%; border-collapse: collapse; margin-bottom: 30px;">';
        html += '<thead><tr style="background-color: #f5f5f5;">';
        html += '<th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Job Title</th>';
        html += '<th style="padding: 12px; text-align: center; border-bottom: 2px solid #ddd;">Applications</th>';
        html += '</tr></thead><tbody>';

        for (const [job, count] of Object.entries(applicationsByJob)) {
            html += '<tr style="border-bottom: 1px solid #eee;">';
            html += '<td style="padding: 12px;">' + job + '</td>';
            html += '<td style="padding: 12px; text-align: center; font-weight: bold; color: #764ba2;">' + count + '</td>';
            html += '</tr>';
        }

        html += '</tbody></table>';

        html += '<h2 style="color: #333; border-bottom: 3px solid #667eea; padding-bottom: 10px; margin-top: 30px;">Job Post Status</h2>';
        html += '<table style="width: 100%; border-collapse: collapse; margin-bottom: 30px;">';
        html += '<thead><tr style="background-color: #f5f5f5;">';
        html += '<th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Status</th>';
        html += '<th style="padding: 12px; text-align: center; border-bottom: 2px solid #ddd;">Count</th>';
        html += '</tr></thead><tbody>';

        for (const [status, count] of Object.entries(jobStatusCount)) {
            const statusColor = status === 'Active' ? '#28a745' : status === 'Pending' ? '#ffc107' : '#dc3545';
            html += '<tr style="border-bottom: 1px solid #eee;">';
            html += '<td style="padding: 12px;">';
            html += '<span style="display: inline-block; width: 10px; height: 10px; background-color: ' + statusColor + '; border-radius: 50%; margin-right: 8px;"></span>';
            html += status + '</td>';
            html += '<td style="padding: 12px; text-align: center; font-weight: bold; color: ' + statusColor + ';">' + count + '</td>';
            html += '</tr>';
        }

        html += '</tbody></table>';
        html += '<div style="margin-top: 40px; padding: 20px; background-color: #f8f9fa; border-radius: 8px; text-align: center;">';
        html += '<p style="margin: 0; color: #666; font-size: 14px;">This report was automatically generated by HireZa Dashboard<br>For more details, please visit your dashboard.</p>';
        html += '</div></div></div>';

        return html;
    }

    // Close modal on outside click
    window.onclick = function(event) {
        const modal = document.getElementById('email-modal');
        if (event.target === modal) {
            closeEmailModal();
        }
    }

    // Function to highlight active sidebar menu item based on current page
    function setActiveSidebarItem() {
        const currentPage = window.location.pathname;
        const sidebarLinks = document.querySelectorAll('.sidebar a');

        sidebarLinks.forEach(link => {
            // Remove active class from all links first
            link.classList.remove('active');

            // Check if this link's href matches current page
            if (link.getAttribute('href') === currentPage) {
                link.classList.add('active');
            }

            // Special case for dashboard which might have different URLs but same page
            if (currentPage.includes('employer_dashboard') && link.getAttribute('href').includes('employer_dashboard')) {
                link.classList.add('active');
            }
        });
    }

    // Call this function when page loads
    document.addEventListener('DOMContentLoaded', function() {
        setActiveSidebarItem();
    });
</script>

<!-- Email Report Button -->
<button class="email-report-btn" onclick="showEmailModal()">
    <i class="fas fa-envelope"></i>
    <span>Email Report</span>
</button>

<!-- Email Modal -->
<div id="email-modal" class="email-modal">
    <div class="email-modal-content">
        <div class="email-modal-header">
            <h2><i class="fas fa-paper-plane"></i> Email Dashboard Report</h2>
            <button class="email-modal-close" onclick="closeEmailModal()">&times;</button>
        </div>
        <div class="email-modal-body">
            <form id="email-report-form">
                <div class="email-form-group">
                    <label for="from-email">
                        <i class="fas fa-user"></i> Your Email Address
                    </label>
                    <input
                            type="email"
                            id="from-email"
                            name="from_email"
                            placeholder="your.email@example.com"
                            required
                            value="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                    >
                    <small>The sender's email address</small>
                </div>

                <div class="email-form-group">
                    <label for="to-email">
                        <i class="fas fa-inbox"></i> Recipient Email Address
                    </label>
                    <input
                            type="email"
                            id="to-email"
                            name="to_email"
                            placeholder="recipient@example.com"
                            required
                    >
                    <small>Who should receive this report?</small>
                </div>

                <div class="email-form-group">
                    <label for="email-message">
                        <i class="fas fa-comment"></i> Additional Message (Optional)
                    </label>
                    <textarea
                            id="email-message"
                            name="message"
                            placeholder="Add a personal message to include with the report..."
                    ></textarea>
                </div>
            </form>

            <div class="email-loading" id="email-loading">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Sending your report...</p>
            </div>
        </div>
        <div class="email-modal-footer">
            <button class="cancel-email-btn" onclick="closeEmailModal()">Cancel</button>
            <button class="send-email-btn" onclick="sendEmailReport()" id="send-btn">
                <i class="fas fa-paper-plane"></i> Send Report
            </button>
        </div>
    </div>
</div>
</body>
</html>