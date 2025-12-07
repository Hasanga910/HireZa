=<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JobSeeker, model.Profile" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    Profile profile = (Profile) request.getAttribute("profile");

    if (jobSeeker == null) {
        response.sendRedirect("../signin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View CV - HireZa</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
<h2>Your CV</h2>
<div class="card p-3">
    <h4><%= jobSeeker.getFullName() %></h4>
    <p><b>Email:</b> <%= jobSeeker.getEmail() %></p>
    <p><b>Title:</b> <%= profile.getTitle() %></p>
    <p><b>Location:</b> <%= profile.getLocation() %></p>
    <p><b>About:</b> <%= profile.getAbout() %></p>
    <p><b>Education:</b> <%= profile.getEducation() %></p>
    <p><b>Experience:</b> <%= profile.getExperience() %></p>
    <p><b>Skills:</b> <%= profile.getSkills() %></p>
</div>

<a href="../DownloadCV" class="btn btn-primary mt-3">
    <i class="fas fa-download"></i> Download as PDF
</a>
</body>
</html>
