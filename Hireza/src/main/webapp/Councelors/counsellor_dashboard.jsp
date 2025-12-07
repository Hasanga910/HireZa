<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Counselor" %>
<%
    User user = (User) session.getAttribute("user");
    Counselor counselor = (Counselor) session.getAttribute("counselor");

    if (user == null || !"JobCounsellor".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }

    String counselorName = (counselor != null) ? counselor.getFullName() : user.getFullName();
    String specialization = (counselor != null && counselor.getSpecialization() != null) ? counselor.getSpecialization() : "Not Set";
    double rating = (counselor != null) ? counselor.getRating() : 0.0;
    boolean isAvailable = (counselor != null) ? counselor.isAvailable() : true;
    String profilePic = (counselor != null && counselor.getProfilePic() != null) ? counselor.getProfilePic() : "default-avatar.png";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counselor Dashboard - HireZa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --light-bg: #f8f9fa;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', sans-serif;
        }

        .sidebar {
            background: var(--primary-color);
            min-height: 100vh;
            position: fixed;
            width: 250px;
            left: 0;
            top: 0;
            padding-top: 20px;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            padding: 20px;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .sidebar-brand img {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .sidebar .nav-link {
            color: white;
            padding: 10px 20px;
            transition: background 0.3s;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: var(--secondary-color);
        }

        .profile-section {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }

        .profile-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 2px solid white;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8em;
        }

        .dashboard-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
        }

        .stat-card {
            background: white;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
        }

        .stat-label {
            color: #6c757d;
        }

        .btn-toggle-status {
            background: var(--success-color);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
        }

        .rating-stars {
            color: #ffc107;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s;
            }

            .sidebar.show {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <a href="#" class="sidebar-brand">
        <img src="${pageContext.request.contextPath}/images/index/favicon.png" alt="HireZa Logo">
        HireZa
    </a>

    <div class="profile-section">
        <img src="<%= request.getContextPath() %>/images/profiles/<%= profilePic %>"
             alt="Profile" class="profile-img"
             onerror="this.src='<%= request.getContextPath() %>/images/default-avatar.png'">
        <h6 class="text-white"><%= counselorName %></h6>
        <p class="text-light"><%= specialization %></p>
        <div class="rating-stars">
            <% for(int i = 1; i <= 5; i++) { %>
            <i class="fas fa-star <%= (i <= rating) ? "" : "text-muted" %>"></i>
            <% } %>
            (<%= String.format("%.1f", rating) %>)
        </div>
        <span class="status-badge <%= isAvailable ? "bg-success" : "bg-danger" %>">
            <%= isAvailable ? "Available" : "Busy" %>
        </span>
    </div>

    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link active" href="<%= request.getContextPath() %>/Counselor/counselor-dashboard.jsp">
                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/Counselor/counselor-appointments.jsp">
                <i class="fas fa-calendar-alt me-2"></i> Appointments
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/Counselor/counselor-clients.jsp">
                <i class="fas fa-users me-2"></i> My Clients
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/Counselor/counselor-sessions.jsp">
                <i class="fas fa-comments me-2"></i> Sessions
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/Counselor/counselor-reports.jsp">
                <i class="fas fa-chart-bar me-2"></i> Reports
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<%= request.getContextPath() %>/Counselor/counselor-profile.jsp">
                <i class="fas fa-user-edit me-2"></i> Profile Settings
            </a>
        </li>
        <li class="nav-item mt-3">
            <a class="nav-link text-warning" href="<%= request.getContextPath() %>/LogoutServlet">
                <i class="fas fa-sign-out-alt me-2"></i> Logout
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Top Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white mb-4 shadow-sm">
        <div class="container-fluid">
            <button class="btn btn-outline-primary d-md-none" onclick="toggleSidebar()">
                <i class="fas fa-bars"></i>
            </button>
            <h5 class="mb-0">Dashboard</h5>
            <form class="d-flex ms-auto" action="<%= request.getContextPath() %>/UpdateCounselorAvailability" method="post">
                <input type="hidden" name="availability" value="<%= !isAvailable %>">
                <button type="submit" class="btn-toggle-status">
                    <%= isAvailable ? "Go Busy" : "Go Available" %>
                </button>
            </form>
        </div>
    </nav>

    <!-- Stats Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number text-primary">28</div>
                <div class="stat-label">Active Clients</div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number text-success">3</div>
                <div class="stat-label">Today's Sessions</div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number text-warning">156</div>
                <div class="stat-label">Total Sessions</div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card">
                <div class="stat-number text-info"><%= String.format("%.1f", rating) %></div>
                <div class="stat-label">Average Rating</div>
            </div>
        </div>
    </div>

    <!-- Today's Schedule -->
    <div class="dashboard-card">
        <h5 class="mb-3">Today's Schedule</h5>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>Time</th>
                    <th>Client</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>09:00 AM</td>
                    <td>John Smith</td>
                    <td>Career Planning</td>
                    <td><span class="badge bg-success">Confirmed</span></td>
                    <td><button class="btn btn-sm btn-outline-primary">Join</button></td>
                </tr>
                <tr>
                    <td>11:00 AM</td>
                    <td>Sarah Johnson</td>
                    <td>Resume Review</td>
                    <td><span class="badge bg-warning">Pending</span></td>
                    <td><button class="btn btn-sm btn-outline-secondary">Reschedule</button></td>
                </tr>
                <tr>
                    <td>02:00 PM</td>
                    <td>Mike Davis</td>
                    <td>Interview Prep</td>
                    <td><span class="badge bg-success">Confirmed</span></td>
                    <td><button class="btn btn-sm btn-outline-primary">Join</button></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('show');
    }
</script>
</body>
</html>