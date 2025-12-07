<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign Up - HireLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        video.bg-video {
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -2;
        }

        .overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: -1;
        }

        .signup-box {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem 2rem;
            border-radius: 12px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.25);
            text-align: center;
            max-height: 90vh;
            overflow-y: auto;
        }

        .signup-box h2 {
            margin-bottom: 1.5rem;
            font-size: 1.75rem;
            color: #1e293b;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 1rem;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.4rem;
            font-size: 0.9rem;
            font-weight: 500;
            color: #374151;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 0.65rem 0.85rem;
            border: 1.5px solid #d1d5db;
            border-radius: 6px;
            font-size: 0.95rem;
            transition: all 0.2s;
            background-color: #fff;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.15);
            outline: none;
        }

        .form-group input.error, .form-group select.error {
            border-color: #dc2626;
        }

        .form-group select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
        }

        .error-message {
            color: #dc2626;
            font-size: 0.8rem;
            margin-top: 0.3rem;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        .alert {
            padding: 0.75rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .alert-error {
            background-color: #fee;
            color: #dc2626;
            border: 1px solid #fca;
        }

        .btn-submit {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(135deg, #1e40af, #2563eb);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
            margin-top: 0.8rem;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .btn-submit:disabled {
            background: #9ca3af;
            cursor: not-allowed;
        }

        .login-link {
            margin-top: 1.2rem;
            font-size: 0.9rem;
            color: #6b7280;
        }

        .login-link a {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .password-strength {
            margin-top: 0.5rem;
            height: 4px;
            background: #e5e7eb;
            border-radius: 2px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: all 0.3s;
        }

        .strength-weak { background: #dc2626; width: 33%; }
        .strength-medium { background: #f59e0b; width: 66%; }
        .strength-strong { background: #10b981; width: 100%; }

        .password-strength-text {
            font-size: 0.75rem;
            margin-top: 0.3rem;
            color: #6b7280;
        }

        .required {
            color: red;
            margin-left: 2px; /* small space between label text and asterisk */
        }


    </style>
</head>
<body>

<% String error = (String) request.getAttribute("error"); %>
<% String fullName = request.getAttribute("fullName") != null ? (String) request.getAttribute("fullName") : ""; %>
<% String username = request.getAttribute("username") != null ? (String) request.getAttribute("username") : ""; %>
<% String email = request.getAttribute("email") != null ? (String) request.getAttribute("email") : ""; %>
<% String phone = request.getAttribute("phone") != null ? (String) request.getAttribute("phone") : ""; %>
<% String role = request.getAttribute("role") != null ? (String) request.getAttribute("role") : "JobSeeker"; %>

<video autoplay muted loop playsinline class="bg-video">
    <source src="background1.mp4" type="video/mp4" />
    Your browser does not support the video tag.
</video>

<div class="overlay"></div>

<div class="signup-box">
    <h2>Create Your Account</h2>

    <% if (error != null && !error.isEmpty()) { %>
    <div class="alert alert-error">
        <%= error %>
    </div>
    <% } %>

    <form id="signupForm" action="${pageContext.request.contextPath}/register" method="post" novalidate>
        <div class="form-group">
            <label for="fullName">Full Name <span class="required">*</span></label>
            <input type="text" id="fullName" name="fullName" value="<%= fullName %>"
                   placeholder="Enter your full name" required />
            <div class="error-message" id="fullNameError"></div>
        </div>

        <div class="form-group">
            <label for="username">Username <span class="required">*</span></label>
            <input type="text" id="username" name="username" value="<%= username %>"
                   placeholder="Choose a username" required />
            <div class="error-message" id="usernameError"></div>
        </div>

        <div class="form-group">
            <label for="email">Email Address <span class="required">*</span></label>
            <input type="email" id="email" name="email" value="<%= email %>"
                   placeholder="Enter your email" required />
            <div class="error-message" id="emailError"></div>
        </div>

        <div class="form-group">
            <label for="phone">Phone <span class="required">*</span></label>
            <input type="text" id="phone" name="phone" value="<%= phone %>"
                   placeholder="Enter your phone number" required />
            <div class="error-message" id="phoneError"></div>
        </div>

        <div class="form-group">
            <label for="password">Create Password <span class="required">*</span></label>
            <input type="password" id="password" name="password"
                   placeholder="Enter a secure password" required />
            <div class="password-strength">
                <div class="password-strength-bar" id="strengthBar"></div>
            </div>
            <div class="password-strength-text" id="strengthText"></div>
            <div class="error-message" id="passwordError"></div>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
            <input type="password" id="confirmPassword" name="confirmPassword"
                   placeholder="Re-enter your password" required />
            <div class="error-message" id="confirmPasswordError"></div>
        </div>

        <div class="form-group">
            <label for="role">Register As </label>
            <select id="role" name="role" required>
                <option value="JobSeeker" <%= role.equals("JobSeeker") ? "selected" : "" %>>Job Seeker</option>
                <option value="Employer" <%= role.equals("Employer") ? "selected" : "" %>>Employer</option>
                <option value="JobCounsellor" <%= role.equals("JobCounsellor") ? "selected" : "" %>>Job Counsellor</option>
            </select>
            <div class="error-message" id="roleError"></div>
        </div>

        <button type="submit" class="btn-submit" id="submitBtn">Sign Up</button>

        <div class="login-link">
            Already have an account? <a href="signin.jsp">Sign In</a>
        </div>
    </form>
</div>

<script>
    const form = document.getElementById('signupForm');
    const submitBtn = document.getElementById('submitBtn');

    // Validation patterns
    const patterns = {
        fullName: /^[a-zA-Z0-9\s]{2,50}$/,
        username: /^[a-zA-Z0-9_]{3,20}$/,
        email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
        phone: /^[0-9]{10}$/
    };

    // Real-time validation for each field
    document.getElementById('fullName').addEventListener('blur', function() {
        validateFullName();
    });

    document.getElementById('username').addEventListener('blur', function() {
        validateUsername();
    });

    document.getElementById('email').addEventListener('blur', function() {
        validateEmail();
    });

    document.getElementById('phone').addEventListener('blur', function() {
        validatePhone();
    });

    document.getElementById('password').addEventListener('input', function() {
        checkPasswordStrength();
    });

    document.getElementById('password').addEventListener('blur', function() {
        validatePassword();
    });

    document.getElementById('confirmPassword').addEventListener('blur', function() {
        validateConfirmPassword();
    });

    // Validation functions
    function validateFullName() {
        const fullName = document.getElementById('fullName');
        const error = document.getElementById('fullNameError');

        if (fullName.value.trim() === '') {
            showError(fullName, error, 'Full name is required');
            return false;
        } else         if (!patterns.fullName.test(fullName.value.trim())) {
            showError(fullName, error, 'Name must be 2-50 characters');
            return false;
        } else {
            clearError(fullName, error);
            return true;
        }
    }

    function validateUsername() {
        const username = document.getElementById('username');
        const error = document.getElementById('usernameError');

        if (username.value.trim() === '') {
            showError(username, error, 'Username is required');
            return false;
        } else if (!patterns.username.test(username.value.trim())) {
            showError(username, error, 'Username must be 3-20 characters (letters, numbers, underscore only)');
            return false;
        } else {
            clearError(username, error);
            return true;
        }
    }

    function validateEmail() {
        const email = document.getElementById('email');
        const error = document.getElementById('emailError');

        if (email.value.trim() === '') {
            showError(email, error, 'Email is required');
            return false;
        } else if (!patterns.email.test(email.value.trim())) {
            showError(email, error, 'Please enter a valid email address');
            return false;
        } else {
            clearError(email, error);
            return true;
        }
    }

    function validatePhone() {
        const phone = document.getElementById('phone');
        const error = document.getElementById('phoneError');

        if (phone.value.trim() === '') {
            showError(phone, error, 'Phone number is required');
            return false;
        } else if (!patterns.phone.test(phone.value.trim())) {
            showError(phone, error, 'Please enter a valid 10-digit phone number');
            return false;
        } else {
            clearError(phone, error);
            return true;
        }
    }

    function validatePassword() {
        const password = document.getElementById('password');
        const error = document.getElementById('passwordError');

        if (password.value === '') {
            showError(password, error, 'Password is required');
            return false;
        } else if (password.value.length < 8) {
            showError(password, error, 'Password must be at least 8 characters');
            return false;
        } else if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(password.value)) {
            showError(password, error, 'Password must contain uppercase, lowercase, and number');
            return false;
        } else {
            clearError(password, error);
            return true;
        }
    }

    function validateConfirmPassword() {
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const error = document.getElementById('confirmPasswordError');

        if (confirmPassword.value === '') {
            showError(confirmPassword, error, 'Please confirm your password');
            return false;
        } else if (password.value !== confirmPassword.value) {
            showError(confirmPassword, error, 'Passwords do not match');
            return false;
        } else {
            clearError(confirmPassword, error);
            return true;
        }
    }

    function checkPasswordStrength() {
        const password = document.getElementById('password').value;
        const strengthBar = document.getElementById('strengthBar');
        const strengthText = document.getElementById('strengthText');

        let strength = 0;
        if (password.length >= 8) strength++;
        if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
        if (/\d/.test(password)) strength++;
        if (/[^a-zA-Z\d]/.test(password)) strength++;

        strengthBar.className = 'password-strength-bar';

        if (password.length === 0) {
            strengthBar.style.width = '0';
            strengthText.textContent = '';
        } else if (strength <= 2) {
            strengthBar.classList.add('strength-weak');
            strengthText.textContent = 'Weak password';
            strengthText.style.color = '#dc2626';
        } else if (strength === 3) {
            strengthBar.classList.add('strength-medium');
            strengthText.textContent = 'Medium password';
            strengthText.style.color = '#f59e0b';
        } else {
            strengthBar.classList.add('strength-strong');
            strengthText.textContent = 'Strong password';
            strengthText.style.color = '#10b981';
        }
    }

    function showError(input, errorDiv, message) {
        input.classList.add('error');
        errorDiv.textContent = message;
        errorDiv.classList.add('show');
    }

    function clearError(input, errorDiv) {
        input.classList.remove('error');
        errorDiv.textContent = '';
        errorDiv.classList.remove('show');
    }

    // Form submission validation
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        const isFullNameValid = validateFullName();
        const isUsernameValid = validateUsername();
        const isEmailValid = validateEmail();
        const isPhoneValid = validatePhone();
        const isPasswordValid = validatePassword();
        const isConfirmPasswordValid = validateConfirmPassword();

        if (isFullNameValid && isUsernameValid && isEmailValid &&
            isPhoneValid && isPasswordValid && isConfirmPasswordValid) {
            // All validations passed, submit the form
            form.submit();
        } else {
            // Scroll to first error
            const firstError = document.querySelector('.error');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }
    });

    // Prevent spaces in username and phone
    document.getElementById('username').addEventListener('keypress', function(e) {
        if (e.key === ' ') e.preventDefault();
    });

    document.getElementById('phone').addEventListener('keypress', function(e) {
        if (!/[0-9]/.test(e.key) && e.key !== 'Backspace') e.preventDefault();
    });
</script>

</body>
</html>