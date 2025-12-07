<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sign In - HireLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet"/>
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body, html {
            height: 100%;
            width: 100%;
            overflow: hidden;
        }

        /* Background video */
        .bg-video {
            position: fixed;
            top: 0;
            left: 0;
            min-width: 100%;
            min-height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        /* Dark overlay so form is visible */
        .overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 0;
        }

        /* Sign-in box */
        .signin-box {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem 2rem;
            border-radius: 12px;
            width: 100%;
            max-width: 380px;
            margin: auto;
            top: 50%;
            transform: translateY(-50%);
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
            text-align: center;
        }

        .signin-box h2 {
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

        .form-group input {
            width: 100%;
            padding: 0.65rem 0.85rem;
            border: 1.5px solid #d1d5db;
            border-radius: 6px;
            font-size: 0.95rem;
            transition: all 0.2s;
        }

        .form-group input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.15);
            outline: none;
        }

        .forgot-password {
            text-align: right;
            margin-bottom: 1.2rem;
        }

        .forgot-password a {
            font-size: 0.85rem;
            color: #2563eb;
            text-decoration: none;
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
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .signup-link {
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: #6b7280;
        }

        .signup-link a {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
        .form-group select {
            width: 100%;
            padding: 0.65rem 0.85rem;
            border: 1.5px solid #d1d5db;
            border-radius: 6px;
            font-size: 0.95rem;
            background-color: #fff;
            transition: all 0.2s;
            appearance: none;
        }

        .form-group select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.15);
            outline: none;
        }

        .required {
            color: red;
            margin-left: 2px;
        }


    </style>
</head>
<body>
<!-- Background video -->
<video autoplay muted loop class="bg-video">
    <source src="background2.mp4" type="video/mp4">
    Your browser does not support HTML5 video.
</video>

<!-- Dark overlay -->
<div class="overlay"></div>

<!-- Sign-in box -->
<div class="signin-box">
    <h2>Sign in to HireZa</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="form-group">
            <label for="username">Username <span class="required">*</span></label>
            <input type="text" id="username" name="username" placeholder="Enter username" required class="form-control" />
        </div>

        <div class="form-group">
            <label for="password">Password <span style="color:red">*</span></label>
            <input type="password" id="password" name="password" placeholder="Enter password" required class="form-control" />
        </div>

        <div class="form-group">
            <label for="role">Login As</label>
            <select id="role" name="role" required class="form-control">
                <option value="JobSeeker" selected>Job Seeker</option>
                <option value="AdminAssistant">Admin Assistant</option>
                <option value="Recruiter">Recruiter</option>
                <option value="Employer">Employer</option>
                <option value="JobCounsellor">Job Counsellor</option>
            </select>
        </div>

        <div class="forgot-password" style="text-align: right; margin-bottom: 1rem;">
            <a href="#" style="color: #2563eb; text-decoration: none; font-size: 0.9rem;">Forgot your password?</a>
        </div>


        <button type="submit" class="btn-submit">Sign In</button>

        <div class="signup-link" style="margin-top: 1rem; font-size: 0.9rem; color: #6b7280;">
            Don't have an account? <a href="signup.jsp" style="color: #2563eb; font-weight: 600; text-decoration: none;">Sign Up</a>
        </div>
    </form>

</div>
</body>
</html>
