<%-- /Employer/view_applicant_cv.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JobApplication, dao.JobApplicationDAO, model.CV, dao.CVDAO, model.JobSeekerProfile, dao.JobSeekerProfileDAO, model.User, dao.UserDAO, dao.JobPostDAO, model.JobPost, java.util.List" %>
<%@ page import="java.io.Serializable" %>
<!DOCTYPE html>
<html>
<head>
    <title>Applicant CV Details - Job Portal</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #007bff; }
        .section { margin-bottom: 20px; }
        .section h3 { color: #007bff; border-bottom: 2px solid #007bff; padding-bottom: 5px; }
        .btn { background-color: #007bff; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; }
        .btn:hover { background-color: #0056b3; }
        .btn-secondary { background-color: #6c757d; }
        .btn-secondary:hover { background-color: #545b62; }
        .no-data { color: #6c757d; font-style: italic; }
    </style>
</head>
<body>
<div class="container">
    <h2>Applicant CV and Profile Details</h2>
    <%
        String applicationId = request.getParameter("applicationId");
        String jobId = request.getParameter("jobId");
        JobApplicationDAO appDAO = new JobApplicationDAO();
        CVDAO cvDAO = new CVDAO();
        JobSeekerProfileDAO profileDAO = new JobSeekerProfileDAO();
        UserDAO userDAO = new UserDAO();
        JobPostDAO jobPostDAO = new JobPostDAO();

        JobApplication app = appDAO.getApplicationById(applicationId);
        String seekerId = app != null ? app.getSeekerId() : "0";
        CV cv = cvDAO.getCVBySeekerId(seekerId);
        JobSeekerProfile profile = profileDAO.getProfileBySeekerId(seekerId);
        User user = userDAO.getUserById(seekerId);
        JobPost job = jobPostDAO.getJobPostById(jobId);
    %>
    <div class="section">
        <h3>Applicant Information</h3>
        <% if (app != null && user != null) { %>
        <p><strong>Name:</strong> <%= app.getFullName() %></p>
        <p><strong>Email:</strong> <%= app.getEmail() %></p>
        <p><strong>Phone:</strong> <%= app.getPhone() != null ? app.getPhone() : "N/A" %></p>
        <p><strong>Job Applied:</strong> <%= job != null ? job.getJobTitle() : "N/A" %></p>
        <p><strong>Application Status:</strong> <%= app.getStatus() %></p>
        <% } else { %>
        <p class="no-data">Applicant information not found.</p>
        <% } %>
    </div>
    <div class="section">
        <h3>CV Details</h3>
        <% if (cv != null) { %>
        <p><strong>Full Name:</strong> <%= cv.getFullName() != null ? cv.getFullName() : "N/A" %></p>
        <p><strong>Email:</strong> <%= cv.getEmail() != null ? cv.getEmail() : "N/A" %></p>
        <p><strong>Phone:</strong> <%= cv.getPhone() != null ? cv.getPhone() : "N/A" %></p>
        <p><strong>LinkedIn:</strong> <%= cv.getLinkedin() != null ? cv.getLinkedin() : "N/A" %></p>
        <p><strong>Education:</strong> <%= cv.getEducation() != null ? cv.getEducation() : "N/A" %></p>
        <p><strong>Institute:</strong> <%= cv.getInstitute() != null ? cv.getInstitute() : "N/A" %></p>
        <p><strong>Job Title:</strong> <%= cv.getJobTitle() != null ? cv.getJobTitle() : "N/A" %></p>
        <p><strong>Company:</strong> <%= cv.getCompany() != null ? cv.getCompany() : "N/A" %></p>
        <p><strong>Experience Years:</strong> <%= cv.getExperienceYears() != null ? cv.getExperienceYears() : "N/A" %></p>
        <p><strong>Skills:</strong> <%= cv.getSkills() != null ? cv.getSkills() : "N/A" %></p>
        <p><strong>Projects:</strong> <%= cv.getProjects() != null ? cv.getProjects() : "N/A" %></p>
        <p><strong>Certifications:</strong> <%= cv.getCertifications() != null ? cv.getCertifications() : "N/A" %></p>
        <p><strong>Interests:</strong> <%= cv.getInterests() != null ? cv.getInterests() : "N/A" %></p>
        <% } else { %>
        <p class="no-data">No CV found for this applicant.</p>
        <% } %>
    </div>
    <div class="section">
        <h3>Profile Details</h3>
        <% if (profile != null) { %>
        <p><strong>Title:</strong> <%= profile.getTitle() != null ? profile.getTitle() : "N/A" %></p>
        <p><strong>Location:</strong> <%= profile.getLocation() != null ? profile.getLocation() : "N/A" %></p>
        <p><strong>About:</strong> <%= profile.getAbout() != null ? profile.getAbout() : "N/A" %></p>
        <p><strong>Experience:</strong> <%= profile.getExperience() != null ? profile.getExperience() : "N/A" %></p>
        <p><strong>Education:</strong> <%= profile.getEducation() != null ? profile.getEducation() : "N/A" %></p>
        <p><strong>Skills:</strong> <%= profile.getSkills() != null ? profile.getSkills() : "N/A" %></p>
        <% if (profile.getProfilePic() != null) { %>
        <p><strong>Profile Picture:</strong></p>
        <img src="${pageContext.request.contextPath}/<%= profile.getProfilePic() %>" alt="Profile Picture" width="100">
        <% } %>
        <% } else { %>
        <p class="no-data">No profile found for this applicant.</p>
        <% } %>
    </div>
    <a href="${pageContext.request.contextPath}/company/employer/applications?jobId=<%= jobId %>" class="btn btn-secondary">Back to Applications</a>
</div>


</body>
</html>