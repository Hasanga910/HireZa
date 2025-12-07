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
      <a href="dashboard.jsp" class="nav-link">
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
      <a href="adminsettings.jsp" class="nav-link active">
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
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
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
</script>
</body>
</html>