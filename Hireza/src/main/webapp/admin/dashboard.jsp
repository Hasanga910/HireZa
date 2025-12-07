<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HireZa Admin Dashboard</title>

  <!-- Bootstrap -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../css/stylesheet.css">
  <!-- Dashboard CSS -->
  <link rel="stylesheet" href="../css/dashboard.css">
</head>
<body>
<!-- Sidebar -->
<div class="sidebar" id="sidebar">
  <a href="#" class="sidebar-brand">
    <img src="../images/logo.jpg" alt="HireZa Logo">
    <span class="brand-text">HireZa</span>
  </a>

  <ul class="sidebar-nav">
    <li class="nav-header">Main</li>
    <li class="nav-item">
      <a href="dashboard.jsp" class="nav-link active">
        <i class="fas fa-tachometer-alt"></i>
        <span class="nav-text">Dashboard</span>
      </a>
    </li>

    <li class="nav-header">User Management</li>
    <li class="nav-item">
      <a href="UMjobseeker.jsp" class="nav-link">
        <i class="fas fa-users"></i>
        <span class="nav-text">Job Seekers</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="UMemployers.jsp" class="nav-link">
        <i class="fas fa-building"></i>
        <span class="nav-text">Employers</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="UMrecruiters.jsp" class="nav-link">
        <i class="fas fa-user-tie"></i>
        <span class="nav-text">Recruiters</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="UMcounselors.jsp" class="nav-link">
        <i class="fas fa-user-graduate"></i>
        <span class="nav-text">Job Counselors</span>
      </a>
    </li>

    <li class="nav-header">Administration</li>
    <li class="nav-item">
      <a href="Aadminassistants.jsp" class="nav-link">
        <i class="fas fa-user-shield"></i>
        <span class="nav-text">Admin Assistants</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="systemlogs.jsp" class="nav-link">
        <i class="fas fa-clipboard-list"></i>
        <span class="nav-text">System Logs</span>
      </a>
    </li>
    <li class="nav-item">
      <a href="adminsettings.jsp" class="nav-link">
        <i class="fas fa-cog"></i>
        <span class="nav-text">Settings</span>
      </a>
    </li>
  </ul>
</div>

<!-- Main Content -->
<div class="main-content" id="mainContent">
  <!-- Top Navbar -->
  <div class="top-navbar">
    <div class="navbar-left">
      <button class="sidebar-toggle" id="sidebarToggle">
        <i class="fas fa-bars"></i>
      </button>
      <h1 class="page-title" id="pageTitle">Dashboard</h1>
    </div>
    <div class="navbar-right">
      <div class="admin-profile">
        <div class="profile-avatar">A</div>
        <div class="profile-info">
          <h6>Admin User</h6>
          <small>Super Administrator</small>
        </div>
        <i class="fas fa-chevron-down ms-2"></i>
      </div>
    </div>
  </div>

  <!-- Dashboard Content -->
  <div class="dashboard-content">
    <!-- Welcome Section -->
    <div class="welcome-section">
      <h2><i class="fas fa-home me-2"></i>Welcome to HireZa Admin Dashboard</h2>
      <p class="mb-0">Monitor and manage your recruitment platform efficiently. Get insights into user activity and system performance.</p>
    </div>

    <!-- Stats Cards -->
    <div class="row g-4 mb-4">
      <div class="col-lg-3 col-md-6">
        <a href="UMemployers.jsp" class="stats-card employers card h-100 text-decoration-none">
          <div class="card-body text-center">
            <div class="stats-icon">
              <i class="fas fa-building"></i>
            </div>
            <h2 class="stats-number" id="employersCount">
              <%
                // Replace this with actual database query
                // Example: int employersCount = EmployerDAO.getEmployersCount();
                int employersCount = 45; // Replace with actual count from database
                out.print(employersCount);
              %>
            </h2>
            <p class="stats-label">Employers</p>
            <small class="d-block mt-2">
              <i class="fas fa-arrow-right me-1"></i>View Details
            </small>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-6">
        <a href="UMrecruiters.jsp" class="stats-card recruiters card h-100 text-decoration-none">
          <div class="card-body text-center">
            <div class="stats-icon">
              <i class="fas fa-user-tie"></i>
            </div>
            <h2 class="stats-number" id="recruitersCount">
              <%
                // Replace this with actual database query
                // Example: int recruitersCount = RecruiterDAO.getRecruitersCount();
                int recruitersCount = 23; // Replace with actual count from database
                out.print(recruitersCount);
              %>
            </h2>
            <p class="stats-label">Recruiters</p>
            <small class="d-block mt-2">
              <i class="fas fa-arrow-right me-1"></i>View Details
            </small>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-6">
        <a href="UMjobseeker.jsp" class="stats-card jobseekers card h-100 text-decoration-none">
          <div class="card-body text-center">
            <div class="stats-icon">
              <i class="fas fa-users"></i>
            </div>
            <h2 class="stats-number" id="jobseekersCount">
              <%
                // Replace this with actual database query
                // Example: int jobseekersCount = JobSeekerDAO.getJobSeekersCount();
                int jobseekersCount = 189; // Replace with actual count from database
                out.print(jobseekersCount);
              %>
            </h2>
            <p class="stats-label">Job Seekers</p>
            <small class="d-block mt-2">
              <i class="fas fa-arrow-right me-1"></i>View Details
            </small>
          </div>
        </a>
      </div>

      <div class="col-lg-3 col-md-6">
        <a href="UMcounselors.jsp" class="stats-card counselors card h-100 text-decoration-none">
          <div class="card-body text-center">
            <div class="stats-icon">
              <i class="fas fa-user-graduate"></i>
            </div>
            <h2 class="stats-number" id="counselorsCount">
              <%
                // Replace this with actual database query
                // Example: int counselorsCount = CounselorDAO.getCounselorsCount();
                int counselorsCount = 12; // Replace with actual count from database
                out.print(counselorsCount);
              %>
            </h2>
            <p class="stats-label">Job Counselors</p>
            <small class="d-block mt-2">
              <i class="fas fa-arrow-right me-1"></i>View Details
            </small>
          </div>
        </a>
      </div>
    </div>

    <!-- Recent Activity Section -->
    <div class="recent-activity">
      <h4><i class="fas fa-clock me-2"></i>Recent Activity</h4>
      <hr>
      <div class="activity-item">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <h6><i class="fas fa-user-plus text-success me-2"></i>New Employer Registered</h6>
            <p class="mb-1 text-muted">Tech Solutions Inc. has joined the platform</p>
            <small class="text-muted">2 hours ago</small>
          </div>
        </div>
      </div>

      <div class="activity-item">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <h6><i class="fas fa-briefcase text-primary me-2"></i>New Job Posted</h6>
            <p class="mb-1 text-muted">Software Developer position posted by ABC Corp</p>
            <small class="text-muted">4 hours ago</small>
          </div>
        </div>
      </div>

      <div class="activity-item">
        <div class="d-flex justify-content-between align-items-start">
          <div>
            <h6><i class="fas fa-users text-info me-2"></i>Job Seekers Activity</h6>
            <p class="mb-1 text-muted">15 new job applications submitted today</p>
            <small class="text-muted">6 hours ago</small>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  // Clean Dashboard JavaScript - No Navigation Interference

  document.addEventListener('DOMContentLoaded', () => {
    // DOM Elements
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('mainContent');

    // Sidebar Toggle Functionality ONLY
    if (sidebarToggle) {
      sidebarToggle.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        mainContent.classList.toggle('expanded');
      });
    }

    // Set active navigation based on current page
    setActiveNavigation();

    // Initialize other dashboard features
    initializeStatsCards();
    animateCounters();
    initializeActivityItems();
    handleResize();
  });

  // Set Active Navigation Based on Current Page
  function setActiveNavigation() {
    const currentPage = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.nav-link');

    navLinks.forEach(link => {
      link.classList.remove('active');
      const linkHref = link.getAttribute('href');

      if (linkHref === currentPage ||
              (currentPage === '' && linkHref === 'dashboard.jsp') ||
              linkHref.includes(currentPage)) {
        link.classList.add('active');
      }
    });
  }

  // Responsive Sidebar Handling
  function handleResize() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('mainContent');

    if (window.innerWidth <= 768) {
      sidebar.classList.add('collapsed');
      mainContent.classList.add('expanded');
    }
  }

  // Stats Cards Animation
  function initializeStatsCards() {
    const statsCards = document.querySelectorAll('.stats-card');

    statsCards.forEach(card => {
      card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-5px) scale(1.02)';
      });

      card.addEventListener('mouseleave', function() {
        this.style.transform = '';
      });
    });
  }

  // Counter Animation for Stats Numbers
  function animateCounters() {
    const counters = document.querySelectorAll('.stats-number');

    counters.forEach(counter => {
      const target = parseInt(counter.textContent);
      if (isNaN(target)) return;

      const increment = target / 50;
      let current = 0;

      const updateCounter = () => {
        if (current < target) {
          current += increment;
          counter.textContent = Math.ceil(current);
          requestAnimationFrame(updateCounter);
        } else {
          counter.textContent = target;
        }
      };

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            updateCounter();
            observer.unobserve(entry.target);
          }
        });
      });

      observer.observe(counter);
    });
  }

  // Activity Items Animation
  function initializeActivityItems() {
    const activityItems = document.querySelectorAll('.activity-item');

    activityItems.forEach((item, index) => {
      setTimeout(() => {
        item.style.opacity = '0';
        item.style.transform = 'translateX(-20px)';
        item.style.transition = 'all 0.3s ease';

        requestAnimationFrame(() => {
          item.style.opacity = '1';
          item.style.transform = 'translateX(0)';
        });
      }, index * 100);
    });
  }

  // Window resize event listener
  window.addEventListener('resize', handleResize);
</script>
</body>
</html>