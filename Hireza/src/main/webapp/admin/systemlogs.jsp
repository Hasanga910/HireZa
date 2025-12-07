<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireZa - System Logs</title>

    <!-- Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../css/admin.css">

    <style>
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
        }

        .stat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stat-icon.jobs { background: #dbeafe; color: #2563eb; }
        .stat-icon.applications { background: #dcfce7; color: #16a34a; }
        .stat-icon.hired { background: #fef3c7; color: #d97706; }
        .stat-icon.company { background: #f3e8ff; color: #9333ea; }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
            color: #1e293b;
        }

        .stat-label {
            color: #64748b;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .stat-change {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            border-radius: 20px;
            font-weight: 500;
            margin-top: 0.5rem;
            display: inline-block;
        }

        .stat-change.positive {
            background: #dcfce7;
            color: #16a34a;
        }

        .stat-change.negative {
            background: #fecaca;
            color: #dc2626;
        }

        /* Monthly Report Section */
        .report-section {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .report-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .report-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin: 0;
            color: #1e293b;
        }

        .month-selector {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .month-selector select {
            padding: 0.5rem 1rem;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 0.875rem;
            cursor: pointer;
        }

        .export-btn {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.875rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: background 0.2s ease;
        }

        .export-btn:hover {
            background: #1d4ed8;
        }

        .report-content {
            padding: 2rem;
        }

        /* Chart Container */
        .chart-container {
            margin-bottom: 2rem;
        }

        .chart-wrapper {
            position: relative;
            height: 350px;
            margin-bottom: 1rem;
        }

        /* Company Ranking */
        .company-ranking {
            background: #f8fafc;
            border-radius: 8px;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .ranking-title {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #1e293b;
        }

        .company-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.75rem;
            background: white;
            border-radius: 6px;
            margin-bottom: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .company-rank {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 600;
            margin-right: 0.75rem;
            flex-shrink: 0;
        }

        .company-info {
            flex: 1;
            min-width: 0;
        }

        .company-name {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.25rem;
        }

        .company-category {
            font-size: 0.75rem;
            color: #64748b;
        }

        .application-count {
            background: #dbeafe;
            color: #2563eb;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 600;
            white-space: nowrap;
            margin-left: 0.5rem;
        }

        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .report-header {
                flex-direction: column;
                align-items: stretch;
            }

            .month-selector {
                flex-direction: column;
            }

            .company-item {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
<!-- Loading Overlay -->
<div id="loadingOverlay" class="loading-overlay">
    <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <a href="#" class="sidebar-brand">
        <img src="../images/index/favicon.png" alt="HireZa Logo">
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
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=JobSeeker" class="nav-link">
                <i class="fas fa-users"></i>
                <span class="nav-text">Job Seekers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=Employer" class="nav-link">
                <i class="fas fa-building"></i>
                <span class="nav-text">Employers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=Recruiter" class="nav-link">
                <i class="fas fa-user-tie"></i>
                <span class="nav-text">Recruiters</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/UserManagementServlet?action=fetch&userRole=JobCounsellor" class="nav-link">
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
            <a href="systemlogs.jsp" class="nav-link active">
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
            <h1 class="page-title">System Logs</h1>
        </div>
        <div class="navbar-right">
            <div class="admin-profile dropdown">
                <div class="d-flex align-items-center" data-bs-toggle="dropdown" aria-expanded="false" style="cursor: pointer;">
                    <div class="profile-avatar" id="profileAvatar">A</div>
                    <div class="profile-info">
                        <h6 id="adminFullName">Loading...</h6>
                        <small>Administrator</small>
                    </div>
                    <i class="fas fa-chevron-down ms-2"></i>
                </div>

                <!-- Dropdown Menu -->
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/adminsettings.jsp"><i class="fas fa-cog me-2"></i>Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Dashboard Content -->
    <div class="dashboard-content">
        <div class="welcome-section">
            <h2><i class="fas fa-clipboard-list me-2"></i>System Logs & Monthly Reports</h2>
            <p class="mb-0">Monitor system activities and track important events across the platform with detailed monthly analytics.</p>
        </div>

        <!-- Quick Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value" id="currentJobsPosted">0</div>
                        <div class="stat-label">Jobs Posted This Month</div>
                    </div>
                    <div class="stat-icon jobs">
                        <i class="fas fa-briefcase"></i>
                    </div>
                </div>
                <div class="stat-change positive" id="jobsChange">
                    <i class="fas fa-arrow-up me-1"></i>Loading...
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value" id="currentApplications">0</div>
                        <div class="stat-label">Applications Received</div>
                    </div>
                    <div class="stat-icon applications">
                        <i class="fas fa-file-alt"></i>
                    </div>
                </div>
                <div class="stat-change positive" id="applicationsChange">
                    <i class="fas fa-arrow-up me-1"></i>Loading...
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value" id="currentHired">0</div>
                        <div class="stat-label">People Hired</div>
                    </div>
                    <div class="stat-icon hired">
                        <i class="fas fa-user-check"></i>
                    </div>
                </div>
                <div class="stat-change positive" id="hiredChange">
                    <i class="fas fa-arrow-up me-1"></i>Loading...
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value" id="topCompanyApplications">0</div>
                        <div class="stat-label">Top Company Applications</div>
                    </div>
                    <div class="stat-icon company">
                        <i class="fas fa-crown"></i>
                    </div>
                </div>
                <div style="font-size: 0.75rem; color: #64748b; margin-top: 0.5rem;">
                    <strong id="topCompanyName">Loading...</strong>
                </div>
            </div>
        </div>

        <!-- Monthly Report Section -->
        <div class="report-section">
            <div class="report-header">
                <h3 class="report-title">Monthly Summary Report</h3>
                <div class="month-selector">
                    <select id="monthSelect" class="form-select">
                        <!-- Options will be generated by JavaScript -->
                    </select>
                    <button class="export-btn" onclick="exportReport()">
                        <i class="fas fa-download"></i>
                        Export Report
                    </button>
                </div>
            </div>

            <div class="report-content">
                <!-- Chart Section -->
                <div class="chart-container">
                    <h4 style="margin-bottom: 1rem; color: #1e293b;">Monthly Trends</h4>
                    <div class="chart-wrapper">
                        <canvas id="monthlyChart"></canvas>
                    </div>
                </div>

                <!-- Company Ranking Section -->
                <div class="company-ranking">
                    <h4 class="ranking-title">Top 5 Companies by Applications</h4>
                    <div id="companyRanking">
                        <div class="text-center text-muted py-3">
                            <i class="fas fa-spinner fa-spin"></i> Loading...
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    let dashboardData = null;
    let monthlyChart = null;
    let currentSelectedMonth = null;

    document.addEventListener('DOMContentLoaded', () => {
        console.log('Initializing dashboard...');
        populateMonthSelector();
        initializeDashboard();
        initializeUIComponents();
    });

    function populateMonthSelector() {
        const monthSelect = document.getElementById('monthSelect');
        if (!monthSelect) {
            console.error('Month select element not found!');
            return;
        }

        const currentDate = new Date();
        const months = [];

        // Generate last 12 months
        for (let i = 0; i < 12; i++) {
            const date = new Date(currentDate.getFullYear(), currentDate.getMonth() - i, 1);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const monthName = date.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });

            months.push({ value: year + '-' + month, label: monthName });
        }

        console.log('Generated months:', months);

        // Clear and populate
        monthSelect.innerHTML = '';
        months.forEach((m, index) => {
            const option = document.createElement('option');
            option.value = m.value;
            option.textContent = m.label;
            if (index === 0) {
                option.selected = true;
                currentSelectedMonth = m.value;
            }
            monthSelect.appendChild(option);
        });

        console.log('Month selector populated with', months.length, 'options');

        // Add change event listener
        monthSelect.addEventListener('change', (e) => {
            console.log('Month changed to:', e.target.value);
            currentSelectedMonth = e.target.value;
            loadMonthlyData(e.target.value);
        });
    }

    async function initializeDashboard() {
        try {
            showLoading(true);

            // Get current month in YYYY-MM format
            const currentDate = new Date();
            const year = currentDate.getFullYear();
            const month = String(currentDate.getMonth() + 1).padStart(2, '0');
            currentSelectedMonth = year + '-' + month;

            console.log('Loading data for current month:', currentSelectedMonth);

            // Initialize chart first
            initializeChart();

            // Fetch data
            await fetchDashboardData(currentSelectedMonth);

            showLoading(false);
        } catch (error) {
            console.error('Dashboard initialization failed:', error);
            showLoading(false);
            showError('Failed to load dashboard data: ' + error.message);
        }
    }

    async function fetchDashboardData(month) {
        try {
            // Build URL with month parameter if provided
            const url = '${pageContext.request.contextPath}/SystemLogsServlet' + (month ? '?month=' + month : '');
            console.log('Fetching from:', url);

            const response = await fetch(url, {
                method: 'GET',
                credentials: 'same-origin',
                headers: {
                    'Accept': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('HTTP error! status: ' + response.status);
            }

            const data = await response.json();
            console.log('Received data:', data);

            if (data.success) {
                updateStats(data);
                updateTopCompany(data.topCompany);
                updateChartData(data.weeklyData);
                updateCompanyRanking(data.topCompanies);
                dashboardData = data;
            } else {
                throw new Error(data.error || 'Unknown error occurred');
            }

            // Fetch admin profile data separately
            try {
                const profileResponse = await fetch('${pageContext.request.contextPath}/api/dashboard', {
                    method: 'GET',
                    credentials: 'same-origin'
                });

                if (profileResponse.ok) {
                    const profileData = await profileResponse.json();
                    if (profileData.success && profileData.admin) {
                        updateAdminProfile(profileData);
                    }
                }
            } catch (profileError) {
                console.error('Error fetching profile data:', profileError);
                // Don't throw - profile is not critical
            }
        } catch (error) {
            console.error('Error fetching dashboard data:', error);
            throw error;
        }
    }

    function updateAdminProfile(data) {
        if (data.admin) {
            const adminFullName = document.getElementById('adminFullName');
            const profileAvatar = document.getElementById('profileAvatar');

            if (adminFullName && data.admin.fullName) {
                adminFullName.textContent = data.admin.fullName;
            }

            if (profileAvatar && data.admin.fullName) {
                profileAvatar.textContent = data.admin.fullName.charAt(0).toUpperCase();
            }
        }
    }

    function updateStats(data) {
        console.log('Updating stats with:', data.stats);
        if (data.stats) {
            // Update with animation
            animateNumber('currentJobsPosted', data.stats.jobsPosted || 0);
            animateNumber('currentApplications', data.stats.applications || 0);
            animateNumber('currentHired', data.stats.hired || 0);

            updateChangeIndicator('jobsChange', data.stats.jobsPostedChange || 0);
            updateChangeIndicator('applicationsChange', data.stats.applicationsChange || 0);
            updateChangeIndicator('hiredChange', data.stats.hiredChange || 0);
        }
    }

    function updateTopCompany(topCompany) {
        console.log('Updating top company:', topCompany);
        if (topCompany) {
            const nameElement = document.getElementById('topCompanyName');
            const appsElement = document.getElementById('topCompanyApplications');

            if (nameElement) nameElement.textContent = topCompany.name || 'No Data';
            if (appsElement) animateNumber('topCompanyApplications', topCompany.applications || 0);
        }
    }

    function animateNumber(elementId, targetNumber) {
        const element = document.getElementById(elementId);
        if (!element) return;

        const duration = 1000;
        const steps = 60;
        const increment = targetNumber / steps;
        let current = 0;
        let step = 0;

        const timer = setInterval(() => {
            step++;
            current += increment;

            if (step >= steps) {
                current = targetNumber;
                clearInterval(timer);
            }

            element.textContent = Math.floor(current).toLocaleString();
        }, duration / steps);
    }

    function updateChangeIndicator(elementId, percentage) {
        const element = document.getElementById(elementId);
        if (!element) return;

        const isPositive = percentage >= 0;
        const formattedPercentage = Math.abs(percentage).toFixed(1);

        element.className = 'stat-change ' + (isPositive ? 'positive' : 'negative');
        element.innerHTML =
            '<i class="fas fa-arrow-' + (isPositive ? 'up' : 'down') + ' me-1"></i>' +
            (isPositive ? '+' : '-') + formattedPercentage + '% from last month';
    }

    function initializeChart() {
        const ctx = document.getElementById('monthlyChart');
        if (!ctx) {
            console.error('Chart canvas not found!');
            return;
        }

        monthlyChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                datasets: [
                    {
                        label: 'Jobs Posted',
                        data: [0, 0, 0, 0],
                        borderColor: '#2563eb',
                        backgroundColor: 'rgba(37, 99, 235, 0.1)',
                        tension: 0.4,
                        fill: true
                    },
                    {
                        label: 'Applications',
                        data: [0, 0, 0, 0],
                        borderColor: '#16a34a',
                        backgroundColor: 'rgba(22, 163, 74, 0.1)',
                        tension: 0.4,
                        fill: true
                    },
                    {
                        label: 'Hired',
                        data: [0, 0, 0, 0],
                        borderColor: '#d97706',
                        backgroundColor: 'rgba(217, 119, 6, 0.1)',
                        tension: 0.4,
                        fill: true
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 15
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '#f1f5f9'
                        },
                        ticks: {
                            precision: 0
                        }
                    },
                    x: {
                        grid: {
                            color: '#f1f5f9'
                        }
                    }
                }
            }
        });
        console.log('Chart initialized');
    }

    function updateChartData(weeklyData) {
        console.log('Updating chart with weekly data:', weeklyData);
        if (!monthlyChart) {
            console.error('Chart not initialized!');
            return;
        }

        if (weeklyData && weeklyData.length > 0) {
            const labels = weeklyData.map(w => w.week);
            const jobsData = weeklyData.map(w => w.jobsPosted || 0);
            const appsData = weeklyData.map(w => w.applications || 0);
            const hiredData = weeklyData.map(w => w.hired || 0);

            console.log('Chart data - Labels:', labels);
            console.log('Chart data - Jobs:', jobsData);
            console.log('Chart data - Apps:', appsData);
            console.log('Chart data - Hired:', hiredData);

            monthlyChart.data.labels = labels;
            monthlyChart.data.datasets[0].data = jobsData;
            monthlyChart.data.datasets[1].data = appsData;
            monthlyChart.data.datasets[2].data = hiredData;
            monthlyChart.update();

            console.log('Chart updated successfully');
        } else {
            console.warn('No weekly data to display');
        }
    }

    function updateCompanyRanking(companies) {
        console.log('Updating company ranking:', companies);
        const rankingContainer = document.getElementById('companyRanking');
        if (!rankingContainer) {
            console.error('Ranking container not found!');
            return;
        }

        if (!companies || companies.length === 0) {
            rankingContainer.innerHTML =
                '<div class="text-center text-muted py-3">' +
                '<i class="fas fa-info-circle fa-2x mb-2"></i>' +
                '<p>No company data available</p>' +
                '</div>';
            return;
        }

        rankingContainer.innerHTML = companies.map((company, index) =>
            '<div class="company-item">' +
            '<div class="company-rank">' + (index + 1) + '</div>' +
            '<div class="company-info">' +
            '<div class="company-name">' + (company.name || 'Unknown') + '</div>' +
            '<div class="company-category">' + (company.category || 'General') + '</div>' +
            '</div>' +
            '<div class="application-count">' + (company.applications || 0) + ' applications</div>' +
            '</div>'
        ).join('');

        console.log('Company ranking updated with', companies.length, 'companies');
    }

    async function loadMonthlyData(month) {
        try {
            console.log('Loading monthly data for:', month);
            showLoading(true);
            await fetchDashboardData(month);
            showLoading(false);
        } catch (error) {
            console.error('Error loading monthly data:', error);
            showError('Failed to load monthly data: ' + error.message);
            showLoading(false);
        }
    }

    function exportReport() {
        console.log('Exporting report...');

        if (!dashboardData) {
            showError('No data available to export');
            return;
        }

        const monthSelect = document.getElementById('monthSelect');
        const selectedMonth = monthSelect.value;
        const monthName = monthSelect.options[monthSelect.selectedIndex].text;

        const currentDate = new Date();
        const formattedDate = currentDate.toLocaleDateString('en-US', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: true
        });

        // Get current values from the page
        const jobsPosted = document.getElementById('currentJobsPosted').textContent;
        const applications = document.getElementById('currentApplications').textContent;
        const hired = document.getElementById('currentHired').textContent;
        const topCompanyName = document.getElementById('topCompanyName').textContent;
        const topCompanyApps = document.getElementById('topCompanyApplications').textContent;

        let reportContent = 'HireZa Monthly Report - ' + monthName + '\n';
        reportContent += '='.repeat(50) + '\n\n';
        reportContent += 'MONTHLY STATISTICS\n';
        reportContent += '-'.repeat(50) + '\n';
        reportContent += 'Jobs Posted: ' + jobsPosted + '\n';
        reportContent += 'Applications Received: ' + applications + '\n';
        reportContent += 'People Hired: ' + hired + '\n';
        reportContent += 'Top Company: ' + topCompanyName + '\n';
        reportContent += 'Top Company Applications: ' + topCompanyApps + '\n\n';

        reportContent += 'TOP 5 COMPANIES BY APPLICATIONS\n';
        reportContent += '-'.repeat(50) + '\n';

        const companies = document.querySelectorAll('.company-item');
        if (companies.length > 0) {
            companies.forEach((company, index) => {
                const name = company.querySelector('.company-name').textContent;
                const category = company.querySelector('.company-category').textContent;
                const apps = company.querySelector('.application-count').textContent;
                reportContent += (index + 1) + '. ' + name + ' (' + category + ') - ' + apps + '\n';
            });
        } else {
            reportContent += 'No company data available\n';
        }

        reportContent += '\n' + '-'.repeat(50) + '\n';
        reportContent += 'Report Generated: ' + formattedDate + '\n';

        console.log('Report content:', reportContent);

        const blob = new Blob([reportContent], { type: 'text/plain' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'HireZa_Monthly_Report_' + selectedMonth + '.txt';
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        document.body.removeChild(a);

        showSuccess('Report exported successfully!');
    }

    function showLoading(show) {
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.style.display = show ? 'flex' : 'none';
        }
    }

    function showError(message) {
        console.error('Error:', message);
        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-danger alert-dismissible fade show position-fixed';
        alertDiv.style.top = '20px';
        alertDiv.style.right = '20px';
        alertDiv.style.zIndex = '9999';
        alertDiv.innerHTML =
            '<i class="fas fa-exclamation-triangle me-2"></i>' +
            message +
            '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
        document.body.appendChild(alertDiv);

        setTimeout(() => {
            if (alertDiv.parentNode) {
                alertDiv.parentNode.removeChild(alertDiv);
            }
        }, 5000);
    }

    function showSuccess(message) {
        console.log('Success:', message);
        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-success alert-dismissible fade show position-fixed';
        alertDiv.style.top = '20px';
        alertDiv.style.right = '20px';
        alertDiv.style.zIndex = '9999';
        alertDiv.innerHTML =
            '<i class="fas fa-check-circle me-2"></i>' +
            message +
            '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
        document.body.appendChild(alertDiv);

        setTimeout(() => {
            if (alertDiv.parentNode) {
                alertDiv.parentNode.removeChild(alertDiv);
            }
        }, 3000);
    }

    function initializeUIComponents() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                if (window.innerWidth <= 768) {
                    sidebar.classList.toggle('show');
                } else {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('expanded');
                    localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
                }
            });
        }

        // Restore sidebar state on page load
        const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
        if (isCollapsed && window.innerWidth > 768) {
            sidebar.classList.add('collapsed');
            mainContent.classList.add('expanded');
        }

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 768 &&
                sidebar.classList.contains('show') &&
                !sidebar.contains(e.target) &&
                !sidebarToggle.contains(e.target)) {
                sidebar.classList.remove('show');
            }
        });

        // Handle window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth <= 768) {
                sidebar.classList.remove('collapsed');
                mainContent.classList.remove('expanded');
                sidebar.classList.remove('show');
            } else {
                const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
                if (isCollapsed) {
                    sidebar.classList.add('collapsed');
                    mainContent.classList.add('expanded');
                }
            }
        });
    }
</script>
</body>
</html>