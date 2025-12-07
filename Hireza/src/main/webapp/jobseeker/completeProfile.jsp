<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.JobSeekerProfile" %>
<%
    JobSeekerProfile profile = (JobSeekerProfile) request.getAttribute("profile");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Your Profile - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2563eb;
            --light-blue: #3b82f6;
            --pale-blue: #dbeafe;
            --sky-blue: #e0f2fe;
            --navy-blue: #1e40af;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --text-muted: #9ca3af;
            --white: #ffffff;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --border-light: #e5e7eb;
            --success-green: #10b981;
            --danger-red: #ef4444;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, var(--sky-blue) 0%, var(--gray-50) 100%);
            color: var(--text-primary);
            line-height: 1.6;
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .main-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .header-section {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-blue);
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            font-size: 1.125rem;
            color: var(--text-secondary);
            font-weight: 400;
        }

        .form-container {
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--border-light);
            overflow: hidden;
            position: relative;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-blue), var(--light-blue), var(--sky-blue));
        }

        .form-header {
            padding: 2.5rem 2.5rem 1.5rem;
            background: linear-gradient(135deg, var(--gray-50), var(--white));
            border-bottom: 1px solid var(--border-light);
            text-align: center;
        }

        .form-header h2 {
            font-size: 1.875rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .form-header p {
            color: var(--text-secondary);
            font-size: 1rem;
            margin: 0;
        }

        .form-body {
            padding: 2.5rem;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            font-size: 0.95rem;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: var(--primary-blue);
            width: 16px;
            text-align: center;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            font-size: 1rem;
            border: 2px solid var(--border-light);
            border-radius: 12px;
            background: var(--white);
            color: var(--text-primary);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            transform: translateY(-1px);
        }

        .form-control:hover {
            border-color: var(--light-blue);
        }

        .form-control::placeholder {
            color: var(--text-muted);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        .file-input-wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .file-input {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border: 0;
        }

        .file-input-label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            width: 100%;
            padding: 1rem;
            border: 2px dashed var(--border-light);
            border-radius: 12px;
            background: var(--gray-50);
            color: var(--text-secondary);
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
        }

        .file-input-label:hover {
            border-color: var(--primary-blue);
            background: var(--pale-blue);
            color: var(--primary-blue);
        }

        .file-input:focus + .file-input-label {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .submit-section {
            padding: 1.5rem 2.5rem 2.5rem;
            border-top: 1px solid var(--border-light);
            background: var(--gray-50);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, var(--primary-blue), var(--light-blue));
            color: var(--white);
            border: none;
            border-radius: 12px;
            padding: 1rem 2rem;
            font-size: 1.125rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            position: relative;
            overflow: hidden;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, var(--navy-blue), var(--primary-blue));
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-submit:active {
            transform: translateY(0);
            box-shadow: var(--shadow-sm);
        }

        .btn-submit:disabled {
            background: var(--gray-200);
            color: var(--text-muted);
            cursor: not-allowed;
            transform: none;
        }

        .progress-bar {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            background: rgba(255, 255, 255, 0.3);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .char-counter {
            font-size: 0.875rem;
            color: var(--text-muted);
            text-align: right;
            margin-top: 0.25rem;
        }

        .required-indicator {
            color: var(--danger-red);
            font-size: 0.875rem;
            margin-left: 0.25rem;
        }

        .help-text {
            font-size: 0.875rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Animation classes */
        .fade-in {
            animation: fadeIn 0.6s ease forwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .loading-spinner {
            display: none;
        }

        .loading .loading-spinner {
            display: inline-block;
            animation: spin 1s linear infinite;
        }

        .loading .button-text {
            display: none;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 1rem 0.5rem;
            }

            .main-container {
                max-width: 100%;
            }

            .page-title {
                font-size: 2rem;
            }

            .form-header,
            .form-body,
            .submit-section {
                padding: 1.5rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }
        }

        /* Focus visible for accessibility */
        .form-control:focus-visible,
        .btn-submit:focus-visible {
            outline: 2px solid var(--primary-blue);
            outline-offset: 2px;
        }
    </style>
</head>
<body>
<div class="main-container">
    <!-- Header Section -->
    <div class="header-section fade-in">
        <h1 class="page-title">
            <i class="fas fa-user-edit"></i>
            Complete Your Profile
        </h1>
        <p class="page-subtitle">
            Tell us about yourself to attract the right opportunities
        </p>
    </div>

    <!-- Form Container -->
    <div class="form-container fade-in">
        <div class="form-header">
            <h2>
                <i class="fas fa-clipboard-list"></i>
                Profile Information
            </h2>
            <p>Fill in the details below to create your professional profile</p>
        </div>

        <form id="profileForm" action="<%= request.getContextPath() %>/SaveProfileServlet" method="post" enctype="multipart/form-data">
            <div class="form-body">
                <!-- Personal Information Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-briefcase"></i>
                            Professional Title
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="text"
                               name="title"
                               class="form-control"
                               value="<%= profile != null ? profile.getTitle() : "" %>"
                               placeholder="e.g., Software Engineer, Marketing Manager"
                               required>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Your current job title or desired position
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-map-marker-alt"></i>
                            Location
                            <span class="required-indicator">*</span>
                        </label>
                        <input type="text"
                               name="location"
                               class="form-control"
                               value="<%= profile != null ? profile.getLocation() : "" %>"
                               placeholder="City, Country"
                               required>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Where you're based or looking for work
                        </div>
                    </div>
                </div>

                <!-- About Section -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user"></i>
                        About You
                    </label>
                    <textarea name="about"
                              class="form-control"
                              rows="4"
                              maxlength="500"
                              placeholder="Write a brief summary about yourself, your career goals, and what makes you unique..."><%= profile != null ? profile.getAbout() : "" %></textarea>
                    <div class="char-counter">
                        <span id="aboutCounter">0</span>/500 characters
                    </div>
                    <div class="help-text">
                        <i class="fas fa-lightbulb"></i>
                        This will be the first thing employers see on your profile
                    </div>
                </div>

                <!-- Experience Section -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-building"></i>
                        Work Experience
                    </label>
                    <textarea name="experience"
                              class="form-control"
                              rows="4"
                              maxlength="1000"
                              placeholder="Describe your work experience, key achievements, and responsibilities..."><%= profile != null ? profile.getExperience() : "" %></textarea>
                    <div class="char-counter">
                        <span id="experienceCounter">0</span>/1000 characters
                    </div>
                    <div class="help-text">
                        <i class="fas fa-chart-line"></i>
                        Include company names, positions, and key accomplishments
                    </div>
                </div>

                <!-- Education Section -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-graduation-cap"></i>
                        Education
                    </label>
                    <textarea name="education"
                              class="form-control"
                              rows="3"
                              maxlength="500"
                              placeholder="List your educational background, degrees, certifications..."><%= profile != null ? profile.getEducation() : "" %></textarea>
                    <div class="char-counter">
                        <span id="educationCounter">0</span>/500 characters
                    </div>
                    <div class="help-text">
                        <i class="fas fa-university"></i>
                        Include degrees, schools, and relevant certifications
                    </div>
                </div>

                <!-- Skills Section -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-tools"></i>
                        Skills & Technologies
                    </label>
                    <input type="text"
                           name="skills"
                           class="form-control"
                           value="<%= profile != null ? profile.getSkills() : "" %>"
                           placeholder="JavaScript, Python, Project Management, Digital Marketing">
                    <div class="help-text">
                        <i class="fas fa-tags"></i>
                        Separate skills with commas (e.g., Java, React, SQL, Leadership)
                    </div>
                </div>

                <!-- Profile Picture Section -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-camera"></i>
                        Profile Picture
                    </label>
                    <div class="file-input-wrapper">
                        <input type="file"
                               id="profilePic"
                               name="profilePic"
                               class="file-input"
                               accept="image/*">
                        <label for="profilePic" class="file-input-label">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <span>Choose a professional photo</span>
                        </label>
                    </div>
                    <div class="help-text">
                        <i class="fas fa-image"></i>
                        Upload a professional headshot (JPG, PNG - Max 5MB)
                    </div>
                </div>
            </div>

            <div class="submit-section">
                <button type="submit" class="btn-submit" id="submitBtn">
                    <i class="fas fa-spinner loading-spinner"></i>
                    <span class="button-text">
                            <i class="fas fa-save"></i>
                            Save Profile
                        </span>
                    <div class="progress-bar"></div>
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Character counters
        const textareas = [
            { element: document.querySelector('textarea[name="about"]'), counter: 'aboutCounter', max: 500 },
            { element: document.querySelector('textarea[name="experience"]'), counter: 'experienceCounter', max: 1000 },
            { element: document.querySelector('textarea[name="education"]'), counter: 'educationCounter', max: 500 }
        ];

        textareas.forEach(item => {
            if (item.element) {
                const counter = document.getElementById(item.counter);

                // Initialize counter
                counter.textContent = item.element.value.length;

                // Update counter on input
                item.element.addEventListener('input', function() {
                    const length = this.value.length;
                    counter.textContent = length;

                    // Change color based on usage
                    if (length > item.max * 0.9) {
                        counter.style.color = 'var(--danger-red)';
                    } else if (length > item.max * 0.7) {
                        counter.style.color = 'var(--text-secondary)';
                    } else {
                        counter.style.color = 'var(--text-muted)';
                    }
                });
            }
        });

        // File input enhancement
        const fileInput = document.getElementById('profilePic');
        const fileLabel = document.querySelector('.file-input-label span');
        const originalText = fileLabel.textContent;

        fileInput.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                const fileName = this.files[0].name;
                const fileSize = (this.files[0].size / 1024 / 1024).toFixed(2);
                fileLabel.textContent = `Selected: ${fileName} (${fileSize}MB)`;

                // Validate file size (5MB limit)
                if (this.files[0].size > 5 * 1024 * 1024) {
                    showNotification('File size must be less than 5MB', 'error');
                    this.value = '';
                    fileLabel.textContent = originalText;
                }
            } else {
                fileLabel.textContent = originalText;
            }
        });

        // Form submission enhancement
        const form = document.getElementById('profileForm');
        const submitBtn = document.getElementById('submitBtn');

        form.addEventListener('submit', function(e) {
            e.preventDefault();

            // Validate form
            if (!validateForm()) {
                return;
            }

            // Show loading state
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;

            // Simulate progress
            const progressBar = submitBtn.querySelector('.progress-bar');
            let progress = 0;
            const progressInterval = setInterval(() => {
                progress += 10;
                progressBar.style.transform = `scaleX(${progress / 100})`;

                if (progress >= 100) {
                    clearInterval(progressInterval);
                    // Submit the form
                    form.submit();
                }
            }, 100);
        });

        // Form validation
        function validateForm() {
            const requiredFields = form.querySelectorAll('[required]');
            let isValid = true;

            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    field.style.borderColor = 'var(--danger-red)';
                    field.focus();
                    isValid = false;
                    showNotification('Please fill in all required fields', 'error');
                    return;
                } else {
                    field.style.borderColor = 'var(--border-light)';
                }
            });

            return isValid;
        }

        // Notification system
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 9999;
                    padding: 1rem 1.5rem;
                    border-radius: 12px;
                    font-weight: 500;
                    box-shadow: var(--shadow-lg);
                    animation: slideInRight 0.3s ease;
                    max-width: 350px;
                `;

            const colors = {
                'success': { bg: '#10b981', color: 'white' },
                'error': { bg: '#ef4444', color: 'white' },
                'info': { bg: 'var(--primary-blue)', color: 'white' }
            };

            notification.style.background = colors[type].bg;
            notification.style.color = colors[type].color;
            notification.textContent = message;

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // Skills input enhancement
        const skillsInput = document.querySelector('input[name="skills"]');
        skillsInput.addEventListener('blur', function() {
            // Clean up skills format
            const skills = this.value.split(',').map(skill => skill.trim()).filter(skill => skill);
            this.value = skills.join(', ');
        });

        // Add entrance animations
        const elements = document.querySelectorAll('.fade-in');
        elements.forEach((el, index) => {
            el.style.animationDelay = `${index * 0.1}s`;
        });
    });

    // CSS animations
    const style = document.createElement('style');
    style.textContent = `
            @keyframes slideInRight {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }

            @keyframes slideOutRight {
                from { transform: translateX(0); opacity: 1; }
                to { transform: translateX(100%); opacity: 0; }
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>