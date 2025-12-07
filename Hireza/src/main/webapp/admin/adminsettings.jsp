<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/images/index/favicon.png" sizes="16x16" type="image/png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireZa</title>

    <!-- Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../css/admin.css">
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
            <h1 class="page-title" id="pageTitle">Settings</h1>
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

    <!-- Settings Content -->
    <div class="settings-container">
        <!-- Success Alert (Hidden by default) -->
        <div class="alert alert-success alert-custom d-none" id="successAlert">
            <i class="fas fa-check-circle me-2"></i>
            <span id="successMessage">Profile updated successfully!</span>
        </div>

        <!-- Error Alert (Hidden by default) -->
        <div class="alert alert-danger alert-custom d-none" id="errorAlert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <span id="errorMessage">An error occurred!</span>
        </div>

        <!-- Profile Settings Card -->
        <div class="settings-card">
            <div class="card-header">
                <h5><i class="fas fa-user-cog me-2"></i>Profile Settings</h5>
            </div>
            <div class="card-body">
                <form id="profileForm">
                    <div class="row">

                        <!-- Profile Form -->
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="firstName" class="form-label">First Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <input type="text" class="form-control" id="lastName" name="lastName">
                                    </div>
                                </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username">
                                </div>
                            </div>
                        </div>

                            <div class="form-group">
                                <label for="email" class="form-label">Email Address <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>

                            <div class="form-group">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone">
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mt-4">
                        <button type="button" class="btn btn-outline-secondary me-2" id="cancelBtn">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="saveBtn">
                            <i class="fas fa-save me-1"></i>Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Security Settings Card -->
        <div class="settings-card">
            <div class="card-header">
                <h5><i class="fas fa-shield-alt me-2"></i>Security Settings</h5>
            </div>
            <div class="card-body">
                <form id="passwordForm">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleCurrentPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="newPassword" class="form-label">New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="password-strength">
                                    <div class="password-strength-bar" id="strengthBar"></div>
                                </div>
                                <small class="text-muted mt-1" id="strengthText">Password strength: <span id="strengthLevel">Enter password</span></small>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback" id="passwordMismatch">Passwords do not match</div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <!-- Security Tips -->
                            <div class="security-tip">
                                <h6><i class="fas fa-lightbulb me-2 text-warning"></i>Security Tips</h6>
                                <ul class="small text-muted mb-0">
                                    <li>Use a strong, unique password</li>
                                    <li>Keep your password secure and private</li>
                                    <li>Regularly update your password</li>
                                    <li>Never share your credentials</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mt-4">
                        <button type="button" class="btn btn-outline-secondary me-2">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-key me-1"></i>Update Password
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Global variable to store admin data
    let adminData = null;

    // Initialize when page loads
    document.addEventListener('DOMContentLoaded', function() {
        initializePage();
    });

    async function initializePage() {
        try {
            showLoading(true);
            await loadAdminProfile();
            initializeComponents();
            showLoading(false);
        } catch (error) {
            console.error('Failed to initialize page:', error);
            showLoading(false);
            showErrorAlert('Failed to load admin profile data');
        }
    }

    // Load admin profile data from server
    async function loadAdminProfile() {
        try {
            const response = await fetch('${pageContext.request.contextPath}/api/admin-profile', {
                method: 'GET',
                credentials: 'same-origin'
            });

            const data = await response.json();

            if (!response.ok) {
                if (data.redirect) {
                    window.location.href = '${pageContext.request.contextPath}' + data.redirect;
                    return;
                }
                throw new Error(data.error || 'Failed to load profile');
            }

            if (data.success && data.admin) {
                adminData = data.admin;
                updateUI(data.admin);
            } else {
                throw new Error('Invalid response from server');
            }

        } catch (error) {
            console.error('Error loading admin profile:', error);
            throw error;
        }
    }

    // Update UI with admin data
    function updateUI(admin) {
        // Update navbar profile
        const adminFullName = document.getElementById('adminFullName');
        const profileAvatar = document.getElementById('profileAvatar');
        const profilePhoto = document.getElementById('profilePhoto');

        if (admin.fullName) {
            if (adminFullName) adminFullName.textContent = admin.fullName;

            const initial = admin.fullName.charAt(0).toUpperCase();
            if (profileAvatar) profileAvatar.textContent = initial;
            if (profilePhoto) profilePhoto.textContent = initial;
        }

        // Populate form fields
        document.getElementById('firstName').value = admin.firstName || '';
        document.getElementById('lastName').value = admin.lastName || '';
        document.getElementById('username').value = admin.username || '';
        document.getElementById('email').value = admin.email || '';
        document.getElementById('phone').value = admin.phone || '';
    }

    // Initialize page components
    function initializeComponents() {
        initializeSidebar();
        initializeProfileForm();
        initializePasswordForm();
        setActiveNavigation();
    }

    // Initialize sidebar with state persistence
    function initializeSidebar() {
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        // Enhanced Sidebar Toggle Functionality with Persistence
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                if (window.innerWidth <= 768) {
                    // Mobile behavior - show/hide sidebar
                    sidebar.classList.toggle('show');
                } else {
                    // Desktop behavior - collapse/expand sidebar
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('expanded');

                    // Store state for persistence across pages
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

        // Handle responsive design with state restoration
        handleSidebarResize();
    }

    // Enhanced resize handling with state persistence
    function handleSidebarResize() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        window.addEventListener('resize', function() {
            if (window.innerWidth <= 768) {
                // On mobile, remove collapsed state and use show/hide instead
                sidebar.classList.remove('collapsed', 'show');
                mainContent.classList.remove('expanded');
            } else {
                // On desktop, restore the saved state
                const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
                if (isCollapsed) {
                    sidebar.classList.add('collapsed');
                    mainContent.classList.add('expanded');
                } else {
                    sidebar.classList.remove('collapsed');
                    mainContent.classList.remove('expanded');
                }
            }
        });
    }


    // Initialize profile form - UPDATED WITH DEBUG
    function initializeProfileForm() {
        const profileForm = document.getElementById('profileForm');
        const photoUpload = document.getElementById('photoUpload');
        const profilePhoto = document.getElementById('profilePhoto');
        const removePhoto = document.getElementById('removePhoto');
        const cancelBtn = document.getElementById('cancelBtn');

        // Profile form submission - UPDATED VERSION
        if (profileForm) {
            profileForm.addEventListener('submit', async function(e) {
                e.preventDefault();

                console.log('=== FORM SUBMISSION DEBUG ===');

                // Get form elements first
                const firstNameEl = document.getElementById('firstName');
                const lastNameEl = document.getElementById('lastName');
                const emailEl = document.getElementById('email');
                const phoneEl = document.getElementById('phone');

                console.log('Form elements found:');
                console.log('firstName element:', firstNameEl);
                console.log('lastName element:', lastNameEl);
                console.log('email element:', emailEl);
                console.log('phone element:', phoneEl);

                // Get form values and trim whitespace
                const firstName = firstNameEl ? firstNameEl.value.trim() : '';
                const lastName = lastNameEl ? lastNameEl.value.trim() : '';
                const username = document.getElementById('username') ? document.getElementById('username').value.trim() : '';
                const email = emailEl ? emailEl.value.trim() : '';
                const phone = phoneEl ? phoneEl.value.trim() : '';

                console.log('Values extracted:');
                console.log('firstName:', "'" + firstName + "'");
                console.log('lastName:', "'" + lastName + "'");
                console.log('username:', "'" + username + "'");
                console.log('email:', "'" + email + "'");
                console.log('phone:', "'" + phone + "'");

                // Client-side validation
                if (!firstName) {
                    console.error('Validation failed: First name is empty');
                    showErrorAlert('First name is required');
                    if (firstNameEl) firstNameEl.focus();
                    return;
                }

                if (!email) {
                    console.error('Validation failed: Email is empty');
                    showErrorAlert('Email is required');
                    if (emailEl) emailEl.focus();
                    return;
                }

                // Basic email validation
                const emailRegex = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
                if (!emailRegex.test(email)) {
                    console.error('Validation failed: Invalid email format');
                    showErrorAlert('Please enter a valid email address');
                    if (emailEl) emailEl.focus();
                    return;
                }

                // Try URLSearchParams method first (more reliable)
                console.log('Using URLSearchParams method...');
                const params = new URLSearchParams();
                params.set('firstName', firstName);
                params.set('lastName', lastName);
                params.set('username', username);
                params.set('email', email);
                params.set('phone', phone);

                console.log('URLSearchParams created:');
                for (let [key, value] of params.entries()) {
                    console.log(key + '=' + value);
                }

                await saveProfileWithParams(params);
            });
        }

        // Photo upload functionality
        if (photoUpload && profilePhoto) {
            photoUpload.addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        profilePhoto.style.backgroundImage = `url(${e.target.result})`;
                        profilePhoto.style.backgroundSize = 'cover';
                        profilePhoto.style.backgroundPosition = 'center';
                        profilePhoto.innerHTML = '';
                    };
                    reader.readAsDataURL(file);
                }
            });
        }

        // Remove photo
        if (removePhoto && profilePhoto) {
            removePhoto.addEventListener('click', function() {
                profilePhoto.style.backgroundImage = '';
                profilePhoto.innerHTML = adminData && adminData.fullName ?
                    adminData.fullName.charAt(0).toUpperCase() : 'A';
                if (photoUpload) photoUpload.value = '';
            });
        }

        // Cancel button
        if (cancelBtn) {
            cancelBtn.addEventListener('click', function() {
                if (adminData) updateUI(adminData);
            });
        }
    }

    // NEW: Save profile with URLSearchParams
    async function saveProfileWithParams(params) {
        const saveBtn = document.getElementById('saveBtn');
        const originalText = saveBtn.innerHTML;

        try {
            // Show loading state
            saveBtn.disabled = true;
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Saving...';

            console.log('Making fetch request with URLSearchParams...');
            console.log('URL:', '${pageContext.request.contextPath}/api/admin-profile');
            console.log('Body:', params.toString());

            const response = await fetch('${pageContext.request.contextPath}/api/admin-profile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString(),
                credentials: 'same-origin'
            });

            console.log('Response received:');
            console.log('Status:', response.status);
            console.log('Status text:', response.statusText);
            console.log('OK:', response.ok);
            console.log('Headers:', Object.fromEntries(response.headers.entries()));

            const responseText = await response.text();
            console.log('Raw response text:', responseText);

            let data;
            try {
                data = JSON.parse(responseText);
                console.log('Parsed JSON response:', data);
            } catch (parseError) {
                console.error('Failed to parse JSON:', parseError);
                throw new Error('Server returned invalid JSON response: ' + responseText);
            }

            if (!response.ok) {
                throw new Error(data.error || `HTTP ${response.status}: ${response.statusText}`);
            }

            if (data.success) {
                showSuccessAlert(data.message || 'Profile updated successfully!');
                // Reload profile data to get updated values
                await loadAdminProfile();
            } else {
                throw new Error(data.error || 'Failed to save profile - server returned success: false');
            }

        } catch (error) {
            console.error('Error saving profile:', error);
            showErrorAlert('Failed to save profile: ' + error.message);
        } finally {
            // Reset button
            saveBtn.disabled = false;
            saveBtn.innerHTML = originalText;
        }
    }

    // Save profile to server - FIXED VERSION
    async function saveProfile(formData) {
        const saveBtn = document.getElementById('saveBtn');
        const originalText = saveBtn.innerHTML;

        try {
            // Show loading state
            saveBtn.disabled = true;
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Saving...';

            const response = await fetch('${pageContext.request.contextPath}/api/admin-profile', {
                method: 'POST',
                body: formData,
                credentials: 'same-origin' // Ensure session cookies are sent
            });

            const data = await response.json();

            console.log('Server response:', data);

            if (!response.ok) {
                throw new Error(data.error || 'Failed to save profile');
            }

            if (data.success) {
                showSuccessAlert(data.message || 'Profile updated successfully!');
                // Reload profile data to get updated values
                await loadAdminProfile();
            } else {
                throw new Error(data.error || 'Failed to save profile');
            }

        } catch (error) {
            console.error('Error saving profile:', error);
            showErrorAlert('Failed to save profile: ' + error.message);
        } finally {
            // Reset button
            saveBtn.disabled = false;
            saveBtn.innerHTML = originalText;
        }
    }

    // Initialize password form
    // Replace the initializePasswordForm function in your JSP file with this updated version:

    // Initialize password form
    function initializePasswordForm() {
        const passwordForm = document.getElementById('passwordForm');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');

        // Password form submission - FIXED VERSION
        if (passwordForm) {
            passwordForm.addEventListener('submit', async function(e) {
                e.preventDefault();

                console.log('=== PASSWORD FORM SUBMISSION DEBUG ===');

                if (!validatePasswords()) {
                    console.log('Password validation failed');
                    return;
                }

                // Get password values
                const currentPassword = document.getElementById('currentPassword').value;
                const newPasswordValue = document.getElementById('newPassword').value;
                const confirmPasswordValue = document.getElementById('confirmPassword').value;

                console.log('Password values extracted (lengths):');
                console.log('currentPassword length:', currentPassword.length);
                console.log('newPassword length:', newPasswordValue.length);
                console.log('confirmPassword length:', confirmPasswordValue.length);

                // Create URLSearchParams for password change - FIXED
                const params = new URLSearchParams();
                params.set('action', 'changePassword');  // This is the key fix!
                params.set('currentPassword', currentPassword);
                params.set('newPassword', newPasswordValue);
                params.set('confirmPassword', confirmPasswordValue);

                console.log('URLSearchParams created for password change:');
                for (let [key, value] of params.entries()) {
                    console.log(key + '=' + (key.includes('Password') ? '[HIDDEN]' : value));
                }

                // Call the password update function
                await updatePassword(params);
            });
        }

        // Password visibility toggles
        setupPasswordToggle('toggleCurrentPassword', 'currentPassword');
        setupPasswordToggle('toggleNewPassword', 'newPassword');
        setupPasswordToggle('toggleConfirmPassword', 'confirmPassword');

        // Password strength checker
        if (newPassword) {
            newPassword.addEventListener('input', function() {
                checkPasswordStrength(this.value);
            });
        }

        // Password confirmation checker
        if (confirmPassword) {
            confirmPassword.addEventListener('input', validatePasswords);
        }
    }

    // Update password on server - FIXED VERSION
    async function updatePassword(params) {
        const submitBtn = document.querySelector('#passwordForm button[type="submit"]');
        const originalText = submitBtn.innerHTML;

        try {
            // Show loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Updating...';

            console.log('Making password update request...');
            console.log('URL:', '${pageContext.request.contextPath}/api/admin-profile');

            const response = await fetch('${pageContext.request.contextPath}/api/admin-profile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString(),
                credentials: 'same-origin'
            });

            console.log('Password update response status:', response.status);

            const responseText = await response.text();
            console.log('Raw password update response:', responseText);

            let data;
            try {
                data = JSON.parse(responseText);
                console.log('Parsed password update response:', data);
            } catch (parseError) {
                console.error('Failed to parse password update response:', parseError);
                throw new Error('Server returned invalid JSON response: ' + responseText);
            }

            if (!response.ok) {
                throw new Error(data.error || `HTTP ${response.status}: ${response.statusText}`);
            }

            if (data.success) {
                showSuccessAlert(data.message || 'Password updated successfully!');

                // Reset form and clear password fields
                document.getElementById('passwordForm').reset();
                resetPasswordStrength();

            } else {
                throw new Error(data.error || 'Failed to update password');
            }

        } catch (error) {
            console.error('Error updating password:', error);
            showErrorAlert('Failed to update password: ' + error.message);
        } finally {
            // Reset button
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalText;
        }
    }

    // Password toggle functionality
    function setupPasswordToggle(toggleId, passwordId) {
        const toggle = document.getElementById(toggleId);
        const passwordInput = document.getElementById(passwordId);

        if (toggle && passwordInput) {
            toggle.addEventListener('click', function() {
                const icon = this.querySelector('i');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            });
        }
    }

    // Check password strength
    function checkPasswordStrength(password) {
        const strengthBar = document.getElementById('strengthBar');
        const strengthLevel = document.getElementById('strengthLevel');

        if (!strengthBar || !strengthLevel) return;

        let score = 0;
        let level = 'Very Weak';

        if (password.length >= 8) score++;
        if (password.match(/[a-z]/)) score++;
        if (password.match(/[A-Z]/)) score++;
        if (password.match(/[0-9]/)) score++;
        if (password.match(/[^a-zA-Z0-9]/)) score++;

        strengthBar.className = 'password-strength-bar';

        switch(score) {
            case 0:
            case 1:
                strengthBar.classList.add('strength-weak');
                level = 'Weak';
                break;
            case 2:
                strengthBar.classList.add('strength-fair');
                level = 'Fair';
                break;
            case 3:
            case 4:
                strengthBar.classList.add('strength-good');
                level = 'Good';
                break;
            case 5:
                strengthBar.classList.add('strength-strong');
                level = 'Strong';
                break;
        }

        strengthLevel.textContent = level;
    }

    // Validate password confirmation
    function validatePasswords() {
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const errorDiv = document.getElementById('passwordMismatch');

        if (!newPassword || !confirmPassword || !errorDiv) return true;

        if (confirmPassword.value && newPassword.value !== confirmPassword.value) {
            confirmPassword.classList.add('is-invalid');
            errorDiv.style.display = 'block';
            return false;
        } else {
            confirmPassword.classList.remove('is-invalid');
            errorDiv.style.display = 'none';
            return true;
        }
    }

    // Reset password strength indicator
    function resetPasswordStrength() {
        const strengthBar = document.getElementById('strengthBar');
        const strengthLevel = document.getElementById('strengthLevel');
        if (strengthBar) strengthBar.className = 'password-strength-bar';
        if (strengthLevel) strengthLevel.textContent = 'Enter password';
    }

    // Set active navigation
    function setActiveNavigation() {
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === 'adminsettings.jsp') {
                link.classList.add('active');
            }
        });
    }

    // Show loading overlay
    function showLoading(show) {
        const loadingOverlay = document.getElementById('loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.style.display = show ? 'flex' : 'none';
        }
    }

    // Show success alert
    function showSuccessAlert(message) {
        const alert = document.getElementById('successAlert');
        const messageSpan = document.getElementById('successMessage');
        const errorAlert = document.getElementById('errorAlert');

        if (alert && messageSpan) {
            if (errorAlert) errorAlert.classList.add('d-none');
            messageSpan.textContent = message;
            alert.classList.remove('d-none');

            setTimeout(() => {
                alert.classList.add('d-none');
            }, 5000);

            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    }

    // Show error alert
    function showErrorAlert(message) {
        const alert = document.getElementById('errorAlert');
        const messageSpan = document.getElementById('errorMessage');
        const successAlert = document.getElementById('successAlert');

        if (alert && messageSpan) {
            if (successAlert) successAlert.classList.add('d-none');
            messageSpan.textContent = message;
            alert.classList.remove('d-none');

            setTimeout(() => {
                alert.classList.add('d-none');
            }, 7000);

            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    }

    // Handle window resize
    window.addEventListener('resize', function() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        if (window.innerWidth <= 768) {
            sidebar.classList.add('collapsed');
            mainContent.classList.add('expanded');
        }
    });

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(e) {
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');

        if (window.innerWidth <= 768 &&
            sidebar.classList.contains('show') &&
            !sidebar.contains(e.target) &&
            !sidebarToggle.contains(e.target)) {
            sidebar.classList.remove('show');
        }
    });
</script>
</body>
</html>