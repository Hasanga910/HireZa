<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Apply for Job</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007bff;
            --secondary-color: #00a0dc;
            --success-color: #059669;
            --danger-color: #dc2626;
            --warning-color: #d97706;
            --text-dark: #1f2937;
            --text-muted: #6b7280;
            --border-color: #e5e7eb;
            --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            padding: 2rem 0;
            color: var(--text-dark);
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .application-card {
            background: white;
            border-radius: 16px;
            padding: 2.5rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .application-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        h2 {
            color: var(--text-dark);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        h2::before {
            content: '\f15c';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            color: var(--primary-color);
        }

        /* Alert Styles */
        .alert {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }

        .alert-danger::before {
            content: '\f071';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        .alert-success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }

        .alert-success::before {
            content: '\f00c';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        /* Form Styles */
        .application-form {
            margin-top: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #fafafa;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            background-color: white;
        }

        .form-control.is-invalid {
            border-color: var(--danger-color);
            background-color: #fff5f5;
        }

        .form-control.is-invalid:focus {
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
        }

        .form-control.is-valid {
            border-color: var(--success-color);
            background-color: #f0fdf4;
        }

        .form-control[type="file"] {
            padding: 0.75rem;
            background-color: white;
            cursor: pointer;
        }

        .form-control[type="file"]::-webkit-file-upload-button {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 500;
            margin-right: 1rem;
            cursor: pointer;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
        }

        /* Validation Messages */
        .invalid-feedback, .valid-feedback {
            display: none;
            font-size: 0.875rem;
            margin-top: 0.5rem;
            font-weight: 500;
        }

        .invalid-feedback {
            color: var(--danger-color);
        }

        .valid-feedback {
            color: var(--success-color);
        }

        .form-control.is-invalid ~ .invalid-feedback {
            display: block;
        }

        .form-control.is-valid ~ .valid-feedback {
            display: block;
        }

        .text-muted {
            display: block;
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        /* Submit Button */
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .btn-submit:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-submit:active:not(:disabled) {
            transform: translateY(0);
        }

        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .btn-submit::after {
            content: '\f1d8';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        /* Required field indicator */
        .required::after {
            content: ' *';
            color: var(--danger-color);
            font-weight: bold;
        }

        /* Form icons */
        .form-group-icon {
            position: relative;
        }

        .form-group-icon .form-control {
            padding-left: 3rem;
        }

        .form-group-icon .form-icon {
            position: absolute;
            left: 1rem;
            top: calc(50% + 12px);
            transform: translateY(-50%);
            color: var(--text-muted);
            z-index: 2;
            font-size: 1rem;
            pointer-events: none;
        }

        .form-group-icon .form-label {
            margin-left: 0;
        }

        /* Character counter */
        .char-counter {
            font-size: 0.8rem;
            color: var(--text-muted);
            text-align: right;
            margin-top: 0.25rem;
        }

        .char-counter.warning {
            color: var(--warning-color);
        }

        .char-counter.danger {
            color: var(--danger-color);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 1rem 0;
            }

            .application-card {
                padding: 1.5rem;
                margin: 0 1rem;
                border-radius: 12px;
            }

            h2 {
                font-size: 1.5rem;
            }

            .btn-submit {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="application-card">
        <h2>Apply for Job</h2>

        <!-- Display errors -->
        <c:if test="${param.error != null}">
            <div class="alert alert-danger">
                <c:choose>
                    <c:when test="${param.error == 'loginRequired'}">You must login first.</c:when>
                    <c:when test="${param.error == 'invalidJob'}">Invalid Job ID.</c:when>
                    <c:when test="${param.error == 'missingFields'}">Full Name and Email are required.</c:when>
                    <c:when test="${param.error == 'noResume'}">Please upload your resume.</c:when>
                    <c:when test="${param.error == 'badFileType'}">Only PDF, DOC, DOCX allowed.</c:when>
                    <c:when test="${param.error == 'db'}">Database error occurred. Try again.</c:when>
                    <c:otherwise>Unknown error.</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Success message -->
        <c:if test="${param.applied == '1'}">
            <div class="alert alert-success">
                Application submitted successfully!
            </div>
        </c:if>

        <!-- Apply form -->
        <form class="application-form" id="applicationForm" action="${pageContext.request.contextPath}/submit-application"
              method="post" enctype="multipart/form-data" novalidate>

            <!-- Hidden field for jobId -->
            <input type="hidden" name="jobId" value="${param.jobId}" />

            <div class="form-group form-group-icon">
                <label class="form-label required">Full Name</label>
                <i class="fas fa-user form-icon"></i>
                <input type="text" name="fullName" id="fullName" class="form-control" required
                       minlength="2" maxlength="100" />
                <div class="invalid-feedback">
                    <i class="fas fa-exclamation-circle"></i> Please enter your full name (2-100 characters)
                </div>
                <div class="valid-feedback">
                    <i class="fas fa-check-circle"></i> Looks good!
                </div>
            </div>

            <div class="form-group form-group-icon">
                <label class="form-label required">Email</label>
                <i class="fas fa-envelope form-icon"></i>
                <input type="email" name="email" id="email" class="form-control" required
                       pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" />
                <div class="invalid-feedback">
                    <i class="fas fa-exclamation-circle"></i> Please enter a valid email address
                </div>
                <div class="valid-feedback">
                    <i class="fas fa-check-circle"></i> Email looks valid!
                </div>
            </div>

            <div class="form-group form-group-icon">
                <label class="form-label">Phone</label>
                <i class="fas fa-phone form-icon"></i>
                <input type="tel" name="phone" id="phone" class="form-control"
                       pattern="[\d\s\-\+\(\)]{10,20}"
                       placeholder="+1 (555) 123-4567" />
                <small class="text-muted">Optional - Format: +1 (555) 123-4567</small>
                <div class="invalid-feedback">
                    <i class="fas fa-exclamation-circle"></i> Please enter a valid phone number (10-20 digits)
                </div>
                <div class="valid-feedback">
                    <i class="fas fa-check-circle"></i> Phone number is valid!
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Cover Letter</label>
                <textarea name="coverLetter" id="coverLetter" class="form-control" rows="5" cols="40"
                          maxlength="2000"
                          placeholder="Tell us why you're the perfect fit for this position..."></textarea>
                <div class="char-counter">
                    <span id="charCount">0</span> / 2000 characters
                </div>
                <small class="text-muted">Optional - Maximum 2000 characters</small>
            </div>

            <div class="form-group">
                <label class="form-label required">Resume</label>
                <input type="file" name="resume" id="resume" class="form-control" required
                       accept=".pdf,.doc,.docx" />
                <small class="text-muted">Accepted formats: PDF, DOC, DOCX (Max size: 5MB)</small>
                <div class="invalid-feedback">
                    <i class="fas fa-exclamation-circle"></i> <span id="resumeError">Please upload your resume</span>
                </div>
                <div class="valid-feedback">
                    <i class="fas fa-check-circle"></i> Resume uploaded successfully!
                </div>
            </div>

            <!-- Submit button -->
            <button type="submit" class="btn-submit" id="submitBtn">Apply Now</button>

        </form>
    </div>
</div>

<script>
    // Form validation
    (function() {
        'use strict';

        const form = document.getElementById('applicationForm');
        const fullName = document.getElementById('fullName');
        const email = document.getElementById('email');
        const phone = document.getElementById('phone');
        const coverLetter = document.getElementById('coverLetter');
        const resume = document.getElementById('resume');
        const charCount = document.getElementById('charCount');
        const submitBtn = document.getElementById('submitBtn');

        // Real-time validation functions
        function validateFullName() {
            const value = fullName.value.trim();
            if (value.length < 2) {
                fullName.classList.add('is-invalid');
                fullName.classList.remove('is-valid');
                return false;
            } else {
                fullName.classList.remove('is-invalid');
                fullName.classList.add('is-valid');
                return true;
            }
        }

        function validateEmail() {
            const value = email.value.trim();
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(value)) {
                email.classList.add('is-invalid');
                email.classList.remove('is-valid');
                return false;
            } else {
                email.classList.remove('is-invalid');
                email.classList.add('is-valid');
                return true;
            }
        }

        function validatePhone() {
            const value = phone.value.trim();
            if (value.length === 0) {
                phone.classList.remove('is-invalid', 'is-valid');
                return true; // Optional field
            }
            const phonePattern = /^[\d\s\-\+\(\)]{10,20}$/;
            if (!phonePattern.test(value)) {
                phone.classList.add('is-invalid');
                phone.classList.remove('is-valid');
                return false;
            } else {
                phone.classList.remove('is-invalid');
                phone.classList.add('is-valid');
                return true;
            }
        }

        function validateResume() {
            const file = resume.files[0];
            const resumeError = document.getElementById('resumeError');

            if (!file) {
                resume.classList.add('is-invalid');
                resume.classList.remove('is-valid');
                resumeError.textContent = 'Please upload your resume';
                return false;
            }

            // Check file size (5MB = 5 * 1024 * 1024 bytes)
            const maxSize = 5 * 1024 * 1024;
            if (file.size > maxSize) {
                resume.classList.add('is-invalid');
                resume.classList.remove('is-valid');
                resumeError.textContent = 'File size must be less than 5MB';
                return false;
            }

            // Check file type
            const allowedTypes = ['application/pdf', 'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
            const fileName = file.name.toLowerCase();
            const validExtension = fileName.endsWith('.pdf') || fileName.endsWith('.doc') || fileName.endsWith('.docx');

            if (!validExtension) {
                resume.classList.add('is-invalid');
                resume.classList.remove('is-valid');
                resumeError.textContent = 'Only PDF, DOC, and DOCX files are allowed';
                return false;
            }

            resume.classList.remove('is-invalid');
            resume.classList.add('is-valid');
            return true;
        }

        // Character counter for cover letter
        function updateCharCount() {
            const count = coverLetter.value.length;
            charCount.textContent = count;

            const counter = document.querySelector('.char-counter');
            if (count > 1800) {
                counter.classList.add('danger');
                counter.classList.remove('warning');
            } else if (count > 1500) {
                counter.classList.add('warning');
                counter.classList.remove('danger');
            } else {
                counter.classList.remove('warning', 'danger');
            }
        }

        // Event listeners for real-time validation
        fullName.addEventListener('blur', validateFullName);
        fullName.addEventListener('input', function() {
            if (this.value.length >= 2) validateFullName();
        });

        email.addEventListener('blur', validateEmail);
        email.addEventListener('input', function() {
            if (this.value.includes('@')) validateEmail();
        });

        phone.addEventListener('blur', validatePhone);
        phone.addEventListener('input', function() {
            if (this.value.length >= 10) validatePhone();
        });

        coverLetter.addEventListener('input', updateCharCount);
        resume.addEventListener('change', validateResume);

        // Form submission validation
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            event.stopPropagation();

            // Check jobId
            const jobId = document.querySelector('input[name="jobId"]').value;
            if (!jobId) {
                alert('Error: Job ID is missing! Please return to the job listing and try again.');
                return false;
            }

            // Validate all required fields
            const isFullNameValid = validateFullName();
            const isEmailValid = validateEmail();
            const isPhoneValid = validatePhone();
            const isResumeValid = validateResume();

            // If all validations pass, submit the form
            if (isFullNameValid && isEmailValid && isPhoneValid && isResumeValid) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
                form.submit();
            } else {
                // Scroll to first invalid field
                const firstInvalid = form.querySelector('.is-invalid');
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            }
        });

        // Initialize character count
        updateCharCount();
    })();
</script>
</body>
</html>