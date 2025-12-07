<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Professional CV Builder</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #9568f1;
            --primary-dark: #5a67d8;
            --secondary-color: #764ba2;
            --accent-color: #f093fb;
            --text-dark: #2d3748;
            --text-light: #718096;
            --bg-light: #f7fafc;
            --white: #ffffff;
            --border-color: #e2e8f0;
            --success-color: #48bb78;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            min-height: 100vh;
            padding: 2rem 0;
            line-height: 1.6;
        }

        .main-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .cv-builder-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header-section {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 3rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 30px 30px;
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .header-content {
            position: relative;
            z-index: 2;
        }

        .main-title {
            color: var(--white);
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 400;
            margin-bottom: 0;
        }

        .form-container {
            padding: 3rem 2rem 2rem;
        }

        .section-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .section-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .section-icon i {
            color: var(--white);
            font-size: 1.2rem;
        }

        .section-title {
            color: var(--text-dark);
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            color: var(--text-dark);
            font-weight: 500;
            margin-bottom: 0.5rem;
            display: block;
            font-size: 0.95rem;
        }

        .form-control {
            border: 2px solid var(--border-color);
            border-radius: 12px;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--white);
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
            transform: translateY(-1px);
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
            pointer-events: none;
        }

        .submit-section {
            text-align: center;
            padding: 2rem;
            background: var(--bg-light);
            margin: 2rem -2rem -2rem;
        }

        .submit-btn {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 1rem 3rem;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--white);
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .progress-indicator {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 2rem;
            padding: 0 2rem;
        }

        .progress-step {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--border-color);
            margin: 0 0.5rem;
            transition: all 0.3s ease;
        }

        .progress-step.active {
            background: var(--primary-color);
            transform: scale(1.2);
        }

        .progress-line {
            flex: 1;
            height: 2px;
            background: var(--border-color);
            margin: 0 0.5rem;
        }

        .progress-line.active {
            background: var(--primary-color);
        }

        .section-divider {
            margin: 3rem 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--border-color), transparent);
        }

        @media (max-width: 768px) {
            .main-title {
                font-size: 2rem;
            }

            .form-container {
                padding: 2rem 1rem;
            }

            .header-section {
                padding: 2rem 1rem;
            }

            .section-header {
                flex-direction: column;
                text-align: center;
            }

            .section-icon {
                margin-right: 0;
                margin-bottom: 1rem;
            }
        }

        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-circle {
            position: absolute;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(247, 250, 252, 0.1));
            animation: floatAnimation 15s ease-in-out infinite;
        }

        .circle-1 {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .circle-2 {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 10%;
            animation-delay: 5s;
        }

        .circle-3 {
            width: 60px;
            height: 60px;
            top: 80%;
            left: 20%;
            animation-delay: 10s;
        }

        @keyframes floatAnimation {
            0%, 100% {
                transform: translateY(0px) scale(1);
                opacity: 0.7;
            }
            50% {
                transform: translateY(-30px) scale(1.1);
                opacity: 0.3;
            }
        }
    </style>
</head>
<body>
<!-- Floating Background Elements -->
<div class="floating-elements">
    <div class="floating-circle circle-1"></div>
    <div class="floating-circle circle-2"></div>
    <div class="floating-circle circle-3"></div>
</div>

<div class="main-container">
    <div class="cv-builder-card">
        <!-- Header Section -->
        <div class="header-section">
            <div class="header-content">
                <h1 class="main-title">Professional CV Builder</h1>
                <p class="subtitle">Create your standout resume in minutes</p>
            </div>
        </div>

        <!-- Progress Indicator -->
        <div class="progress-indicator">
            <div class="progress-step active"></div>
            <div class="progress-line active"></div>
            <div class="progress-step active"></div>
            <div class="progress-line active"></div>
            <div class="progress-step active"></div>
            <div class="progress-line"></div>
            <div class="progress-step"></div>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/cv" method="POST">

            <!-- Personal Information Section -->
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3 class="section-title">Personal Information</h3>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <div class="input-group">
                                <input type="text" name="fullName" class="form-control" required placeholder="John Doe">
                                <i class="fas fa-user input-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <div class="input-group">
                                <input type="email" name="email" class="form-control" required placeholder="john@example.com">
                                <i class="fas fa-envelope input-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <div class="input-group">
                                <input type="text" name="phone" class="form-control" required placeholder="+1 (555) 123-4567">
                                <i class="fas fa-phone input-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">LinkedIn Profile</label>
                            <div class="input-group">
                                <input type="url" name="linkedin" class="form-control" placeholder="https://linkedin.com/in/johndoe">
                                <i class="fab fa-linkedin input-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-divider"></div>

                <!-- Education Section -->
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <h3 class="section-title">Education</h3>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Highest Qualification</label>
                            <div class="input-group">
                                <input type="text" name="education" class="form-control" required placeholder="Bachelor's in Computer Science">
                                <i class="fas fa-certificate input-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">University/Institute</label>
                            <div class="input-group">
                                <input type="text" name="institute" class="form-control" required placeholder="University of Technology">
                                <i class="fas fa-university input-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-divider"></div>

                <!-- Work Experience Section -->
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3 class="section-title">Work Experience</h3>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Job Title</label>
                            <div class="input-group">
                                <input type="text" name="jobTitle" class="form-control" placeholder="Software Engineer">
                                <i class="fas fa-id-badge input-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Company</label>
                            <div class="input-group">
                                <input type="text" name="company" class="form-control" placeholder="Tech Solutions Inc.">
                                <i class="fas fa-building input-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="form-label">Years of Experience</label>
                            <div class="input-group">
                                <input type="text" name="experienceYears" class="form-control" placeholder="3 years">
                                <i class="fas fa-calendar-alt input-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="section-divider"></div>

                <!-- Skills Section -->
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    <h3 class="section-title">Skills</h3>
                </div>

                <div class="form-group">
                    <label class="form-label">List your key skills (comma separated)</label>
                    <div class="input-group">
                        <input type="text" name="skills" class="form-control" placeholder="JavaScript, React, Node.js, Python, SQL">
                        <i class="fas fa-tools input-icon"></i>
                    </div>
                </div>

                <div class="section-divider"></div>

                <!-- Interests Section -->
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h3 class="section-title">Interests</h3>
                </div>

                <div class="form-group">
                    <label class="form-label">List your interests</label>
                    <div class="input-group">
                        <input type="text" name="interests" class="form-control" placeholder="Photography, Travel, Technology, Music">
                        <i class="fas fa-star input-icon"></i>
                    </div>
                </div>


                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3 class="section-title">Projects</h3>
                </div>
                <div class="form-group">

                    <div class="input-group">
                        <input type="text" name="projects" class="form-control" placeholder="projects">
                        <i class="fas fa-star input-icon"></i>
                    </div>
                </div>
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3 class="section-title">Certifications</h3>
                </div>
                <div class="form-group">

                    <div class="input-group">
                        <input type="text" name="certifications" class="form-control" placeholder="Certifications">
                        <i class="fas fa-star input-icon"></i>
                    </div>
                </div>


                <!-- Submit Section -->

                <button type="submit" name="action" value="download" class="submit-btn">
                    <i class="fas fa-rocket" style="margin-right: 0.5rem;"></i>
                    Build My CV
                </button>


            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Add smooth interactions
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.form-control');

        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // Simulate progress as user fills form
        const requiredInputs = document.querySelectorAll('input[required]');
        const progressSteps = document.querySelectorAll('.progress-step');
        const progressLines = document.querySelectorAll('.progress-line');

        function updateProgress() {
            const filledInputs = Array.from(requiredInputs).filter(input => input.value.trim() !== '');
            const progress = Math.ceil((filledInputs.length / requiredInputs.length) * progressSteps.length);

            progressSteps.forEach((step, index) => {
                if (index < progress) {
                    step.classList.add('active');
                } else {
                    step.classList.remove('active');
                }
            });

            progressLines.forEach((line, index) => {
                if (index < progress - 1) {
                    line.classList.add('active');
                } else {
                    line.classList.remove('active');
                }
            });
        }

        requiredInputs.forEach(input => {
            input.addEventListener('input', updateProgress);
        });
    });
</script>
</body>
</html>