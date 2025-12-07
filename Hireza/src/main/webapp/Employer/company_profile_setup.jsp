<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Employer".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Company Profile - HireZa</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" type="image/jpeg" href="${pageContext.request.contextPath}/images/employer/2.jpg">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            min-height: 100vh;
            padding: 2rem;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            color: #1a1a1a;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .header h1 i {
            color: #6366f1;
            margin-right: 0.5rem;
        }

        .header p {
            font-size: 1.1rem;
            color: #6b7280;
            font-weight: 400;
        }

        .progress-container {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .step-indicator {
            text-align: center;
            color: #6b7280;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
            font-weight: 500;
        }

        .step-indicator span {
            color: #6366f1;
            font-weight: 600;
        }

        .progress-bar {
            background: #f3f4f6;
            border-radius: 100px;
            height: 10px;
            overflow: hidden;
            position: relative;
        }

        .progress-fill {
            background: linear-gradient(90deg, #6366f1 0%, #8b5cf6 100%);
            height: 100%;
            border-radius: 100px;
            transition: width 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            width: 16.67%;
            box-shadow: 0 0 10px rgba(99, 102, 241, 0.3);
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 3rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            display: none;
            border: 1px solid #f3f4f6;
        }

        .card.active {
            display: block;
            animation: fadeInUp 0.4s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card-header {
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f3f4f6;
        }

        .card-header h2 {
            color: #1a1a1a;
            font-size: 1.75rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .card-header h2 i {
            margin-right: 0.75rem;
            font-size: 1.8rem;
            color: #6366f1;
        }

        .card-header p {
            color: #6b7280;
            font-size: 1rem;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 1.75rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.75rem;
            color: #374151;
            font-size: 0.95rem;
        }

        .required {
            color: #ef4444;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.875rem 1.125rem;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            background: #fafafa;
            color: #1a1a1a;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #6366f1;
            background: white;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }

        .form-group input:hover,
        .form-group textarea:hover,
        .form-group select:hover {
            border-color: #d1d5db;
            background: white;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
            line-height: 1.6;
        }

        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            cursor: pointer;
            padding: 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            transition: all 0.2s ease;
            background: #fafafa;
        }

        .checkbox-label:hover {
            border-color: #6366f1;
            background: #f5f3ff;
            transform: translateY(-2px);
        }

        .checkbox-label input[type="checkbox"]:checked + span {
            color: #6366f1;
            font-weight: 600;
        }

        .checkbox-label input[type="checkbox"] {
            width: auto;
            margin-right: 0.75rem;
            cursor: pointer;
            accent-color: #6366f1;
            width: 18px;
            height: 18px;
        }

        .file-upload {
            border: 3px dashed #e5e7eb;
            border-radius: 16px;
            padding: 3rem 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #fafafa;
        }

        .file-upload:hover {
            border-color: #6366f1;
            background: #f5f3ff;
            transform: translateY(-4px);
        }

        .file-upload i {
            font-size: 3.5rem;
            color: #6366f1;
            margin-bottom: 1.5rem;
            display: block;
        }

        .file-upload input[type="file"] {
            display: none;
        }

        .file-upload-text {
            color: #6b7280;
            font-size: 1rem;
            font-weight: 500;
        }

        .file-upload-text small {
            display: block;
            margin-top: 0.5rem;
            color: #9ca3af;
            font-size: 0.875rem;
        }

        .file-preview {
            margin-top: 1.5rem;
            text-align: center;
            display: none;
        }

        .file-preview img {
            max-width: 250px;
            max-height: 250px;
            border-radius: 12px;
            border: 2px solid #e5e7eb;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 2.5rem;
            gap: 1rem;
            padding-top: 2rem;
            border-top: 2px solid #f3f4f6;
        }

        .btn {
            padding: 0.875rem 2.5rem;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-family: inherit;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            flex: 1;
            box-shadow: 0 4px 6px rgba(99, 102, 241, 0.2);
        }

        .btn-primary:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 8px 12px rgba(99, 102, 241, 0.3);
        }

        .btn-primary:active:not(:disabled) {
            transform: translateY(0);
        }

        .btn-secondary {
            background: #f3f4f6;
            color: #374151;
        }

        .btn-secondary:hover:not(:disabled) {
            background: #e5e7eb;
        }

        .btn:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        .error {
            color: #ef4444;
            font-size: 0.875rem;
            margin-top: 0.5rem;
            display: none;
            font-weight: 500;
        }

        #reviewContent {
            background: #f9fafb;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            border: 2px solid #f3f4f6;
        }

        #reviewContent h3 {
            color: #1a1a1a;
            margin-bottom: 1.5rem;
            font-size: 1.25rem;
            font-weight: 700;
        }

        #reviewContent p {
            margin-bottom: 0.875rem;
            color: #374151;
            line-height: 1.8;
        }

        #reviewContent strong {
            color: #1a1a1a;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .header h1 {
                font-size: 1.75rem;
            }

            .card {
                padding: 2rem 1.5rem;
            }

            .progress-container {
                padding: 1.5rem;
            }

            .checkbox-group {
                grid-template-columns: 1fr;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-building"></i> Complete Your Company Profile</h1>
        <p>Let's get your company set up in just a few steps</p>
    </div>

    <div class="progress-container">
        <div class="step-indicator">
            Step <span id="currentStepDisplay">1</span> of 6
        </div>
        <div class="progress-bar">
            <div class="progress-fill" id="progressBar"></div>
        </div>
    </div>

    <form id="companyProfileForm" method="post" action="${pageContext.request.contextPath}/company/profile/setup" enctype="multipart/form-data">

        <!-- Step 1: Basic Information -->
        <div class="card active" id="step1">
            <div class="card-header">
                <h2><i class="fas fa-info-circle"></i> Basic Information</h2>
                <p>Tell us about your company</p>
            </div>
            <div class="form-group">
                <label for="companyName">Company Name <span class="required">*</span></label>
                <input type="text" id="companyName" name="companyName">
                <span class="error" id="errorCompanyName">Please enter company name</span>
            </div>
            <div class="form-group">
                <label for="industry">Industry <span class="required">*</span></label>
                <input type="text" id="industry" name="industry" placeholder="e.g., Technology, Healthcare, Finance">
                <span class="error" id="errorIndustry">Please enter industry</span>
            </div>
            <div class="form-group">
                <label for="description">Company Description</label>
                <textarea id="description" name="description" placeholder="Brief description of your company"></textarea>
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" disabled>
                    <i class="fas fa-arrow-left"></i> Previous
                </button>
                <button type="button" class="btn btn-primary" id="btnNext1">
                    Next <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </div>

        <!-- Step 2: Contact & Location -->
        <div class="card" id="step2">
            <div class="card-header">
                <h2><i class="fas fa-map-marker-alt"></i> Contact & Location</h2>
                <p>Where can candidates find you?</p>
            </div>
            <div class="form-group">
                <label for="companyEmail">Company Email <span class="required">*</span></label>
                <input type="email" id="companyEmail" name="companyEmail">
                <span class="error" id="errorCompanyEmail">Please enter a valid email</span>
            </div>
            <div class="form-group">
                <label for="contactNumber">Contact Number <span class="required">*</span></label>
                <input type="tel" id="contactNumber" name="contactNumber">
                <span class="error" id="errorContactNumber">Please enter contact number</span>
            </div>
            <div class="form-group">
                <label for="website">Website</label>
                <input type="url" id="website" name="website" placeholder="https://www.example.com">
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address">
            </div>
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" id="city" name="city">
            </div>
            <div class="form-group">
                <label for="state">State</label>
                <input type="text" id="state" name="state">
            </div>
            <div class="form-group">
                <label for="zipCode">Zip Code</label>
                <input type="text" id="zipCode" name="zipCode">
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" id="btnPrev2">
                    <i class="fas fa-arrow-left"></i> Previous
                </button>
                <button type="button" class="btn btn-primary" id="btnNext2">
                    Next <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </div>

        <!-- Step 3: Company Details -->
        <div class="card" id="step3">
            <div class="card-header">
                <h2><i class="fas fa-building"></i> Company Details</h2>
                <p>Help candidates understand your company better</p>
            </div>
            <div class="form-group">
                <label for="companySize">Company Size <span class="required">*</span></label>
                <select id="companySize" name="companySize">
                    <option value="">Select Size</option>
                    <option value="1-10">1-10 employees</option>
                    <option value="11-50">11-50 employees</option>
                    <option value="51-200">51-200 employees</option>
                    <option value="201-500">201-500 employees</option>
                    <option value="501+">501+ employees</option>
                </select>
                <span class="error" id="errorCompanySize">Please select company size</span>
            </div>
            <div class="form-group">
                <label for="foundedYear">Founded Year</label>
                <input type="number" id="foundedYear" name="foundedYear" min="1800" max="2025" placeholder="YYYY">
            </div>
            <div class="form-group">
                <label for="aboutUs">About Us</label>
                <textarea id="aboutUs" name="aboutUs" placeholder="Tell candidates what makes your company special"></textarea>
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" id="btnPrev3">
                    <i class="fas fa-arrow-left"></i> Previous
                </button>
                <button type="button" class="btn btn-primary" id="btnNext3">
                    Next <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </div>

        <!-- Step 4: Work Environment -->
        <div class="card" id="step4">
            <div class="card-header">
                <h2><i class="fas fa-laptop-house"></i> Work Environment</h2>
                <p>What work arrangements do you offer?</p>
            </div>
            <div class="form-group">
                <label for="workMode">Work Mode <span class="required">*</span></label>
                <select id="workMode" name="workMode">
                    <option value="">Select Work Mode</option>
                    <option value="Online">Online (Remote)</option>
                    <option value="Offline">Offline (On-site)</option>
                    <option value="Hybrid">Hybrid</option>
                </select>
                <span class="error" id="errorWorkMode">Please select work mode</span>
            </div>
            <div class="form-group">
                <label>Employment Types <span class="required">*</span></label>
                <div class="checkbox-group">
                    <label class="checkbox-label">
                        <input type="checkbox" name="employmentTypes" value="Full-Time">
                        <span>Full-Time</span>
                    </label>
                    <label class="checkbox-label">
                        <input type="checkbox" name="employmentTypes" value="Part-Time">
                        <span>Part-Time</span>
                    </label>
                    <label class="checkbox-label">
                        <input type="checkbox" name="employmentTypes" value="Contract">
                        <span>Contract</span>
                    </label>
                    <label class="checkbox-label">
                        <input type="checkbox" name="employmentTypes" value="Freelance">
                        <span>Freelance</span>
                    </label>
                </div>
                <span class="error" id="errorEmploymentTypes">Please select at least one employment type</span>
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" id="btnPrev4">
                    <i class="fas fa-arrow-left"></i> Previous
                </button>
                <button type="button" class="btn btn-primary" id="btnNext4">
                    Next <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </div>

        <!-- Step 5: Company Logo -->
        <div class="card" id="step5">
            <div class="card-header">
                <h2><i class="fas fa-image"></i> Company Logo</h2>
                <p>Upload your company logo (Required)</p>
            </div>
            <div class="form-group">
                <label class="file-upload" onclick="document.getElementById('logo').click();">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <p class="file-upload-text">Click to upload company logo<br><small>Max size: 10MB (JPG, PNG)</small></p>
                </label>
                <input type="file" id="logo" name="logo" accept="image/*" style="display: none;">
                <div class="file-preview" id="logoPreview">
                    <img id="logoImage" src="" alt="Logo Preview">
                </div>
                <span class="error" id="errorLogo">Please upload company logo</span>
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" id="btnPrev5">
                    <i class="fas fa-arrow-left"></i> Previous
                </button>
                <button type="button" class="btn btn-primary" id="btnNext5">
                    Next <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </div>

        <!-- Step 6: Review & Submit -->
        <div class="card" id="step6">
            <div class="card-header">
                <h2><i class="fas fa-check-circle"></i> Review & Submit</h2>
                <p>Please review your information before submitting</p>
            </div>
            <div id="reviewContent">
                <!-- Populated by JavaScript -->
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" id="btnPrev6">
                    <i class="fas fa-arrow-left"></i> Previous
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> Complete Setup
                </button>
            </div>
        </div>

    </form>
</div>

<script>
    var currentStep = 1;

    // Show specific step
    function showStep(stepNum) {
        // Hide all cards
        for (var i = 1; i <= 6; i++) {
            var card = document.getElementById('step' + i);
            if (card) {
                card.classList.remove('active');
            }
        }

        // Show target step
        var targetCard = document.getElementById('step' + stepNum);
        if (targetCard) {
            targetCard.classList.add('active');
        }

        // Update progress
        currentStep = stepNum;
        document.getElementById('currentStepDisplay').textContent = stepNum;
        var progress = (stepNum / 6) * 100;
        document.getElementById('progressBar').style.width = progress + '%';

        // Populate review if step 6
        if (stepNum === 6) {
            populateReview();
        }

        window.scrollTo(0, 0);
    }

    // Validate step
    function validateCurrentStep() {
        // Hide all errors
        var errors = document.querySelectorAll('.error');
        for (var i = 0; i < errors.length; i++) {
            errors[i].style.display = 'none';
        }

        var isValid = true;

        if (currentStep === 1) {
            var companyName = document.getElementById('companyName').value.trim();
            var industry = document.getElementById('industry').value.trim();

            if (companyName === '') {
                document.getElementById('errorCompanyName').style.display = 'block';
                isValid = false;
            }
            if (industry === '') {
                document.getElementById('errorIndustry').style.display = 'block';
                isValid = false;
            }
        }

        if (currentStep === 2) {
            var email = document.getElementById('companyEmail').value.trim();
            var phone = document.getElementById('contactNumber').value.trim();

            if (email === '') {
                document.getElementById('errorCompanyEmail').style.display = 'block';
                isValid = false;
            }
            if (phone === '') {
                document.getElementById('errorContactNumber').style.display = 'block';
                isValid = false;
            }
        }

        if (currentStep === 3) {
            var size = document.getElementById('companySize').value;

            if (size === '') {
                document.getElementById('errorCompanySize').style.display = 'block';
                isValid = false;
            }
        }

        if (currentStep === 4) {
            var workMode = document.getElementById('workMode').value;
            var checkboxes = document.querySelectorAll('input[name="employmentTypes"]:checked');

            if (workMode === '') {
                document.getElementById('errorWorkMode').style.display = 'block';
                isValid = false;
            }
            if (checkboxes.length === 0) {
                document.getElementById('errorEmploymentTypes').style.display = 'block';
                isValid = false;
            }
        }

        if (currentStep === 5) {
            var logo = document.getElementById('logo').files;

            if (logo.length === 0) {
                document.getElementById('errorLogo').style.display = 'block';
                isValid = false;
            }
        }

        return isValid;
    }

    // Populate review
    function populateReview() {
        var html = '<h3>Company Information</h3>';

        html += '<p><strong>Company Name:</strong> ' + document.getElementById('companyName').value + '</p>';
        html += '<p><strong>Industry:</strong> ' + document.getElementById('industry').value + '</p>';
        html += '<p><strong>Company Email:</strong> ' + document.getElementById('companyEmail').value + '</p>';
        html += '<p><strong>Contact Number:</strong> ' + document.getElementById('contactNumber').value + '</p>';
        html += '<p><strong>Company Size:</strong> ' + document.getElementById('companySize').value + '</p>';
        html += '<p><strong>Work Mode:</strong> ' + document.getElementById('workMode').value + '</p>';

        var types = [];
        var checkboxes = document.querySelectorAll('input[name="employmentTypes"]:checked');
        for (var i = 0; i < checkboxes.length; i++) {
            types.push(checkboxes[i].value);
        }
        html += '<p><strong>Employment Types:</strong> ' + types.join(', ') + '</p>';

        var logoFile = document.getElementById('logo').files[0];
        html += '<p><strong>Logo:</strong> ' + (logoFile ? logoFile.name : 'Not uploaded') + '</p>';

        document.getElementById('reviewContent').innerHTML = html;
    }

    // Logo preview
    document.getElementById('logo').addEventListener('change', function(e) {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('logoImage').src = e.target.result;
                document.getElementById('logoPreview').style.display = 'block';
            };
            reader.readAsDataURL(this.files[0]);
        }
    });

    // Button event listeners
    document.getElementById('btnNext1').addEventListener('click', function() {
        if (validateCurrentStep()) {
            showStep(2);
        }
    });

    document.getElementById('btnNext2').addEventListener('click', function() {
        if (validateCurrentStep()) {
            showStep(3);
        }
    });

    document.getElementById('btnPrev2').addEventListener('click', function() {
        showStep(1);
    });

    document.getElementById('btnNext3').addEventListener('click', function() {
        if (validateCurrentStep()) {
            showStep(4);
        }
    });

    document.getElementById('btnPrev3').addEventListener('click', function() {
        showStep(2);
    });

    document.getElementById('btnNext4').addEventListener('click', function() {
        if (validateCurrentStep()) {
            showStep(5);
        }
    });

    document.getElementById('btnPrev4').addEventListener('click', function() {
        showStep(3);
    });

    document.getElementById('btnNext5').addEventListener('click', function() {
        if (validateCurrentStep()) {
            showStep(6);
        }
    });

    document.getElementById('btnPrev5').addEventListener('click', function() {
        showStep(4);
    });

    document.getElementById('btnPrev6').addEventListener('click', function() {
        showStep(5);
    });
</script>
</body>
</html>