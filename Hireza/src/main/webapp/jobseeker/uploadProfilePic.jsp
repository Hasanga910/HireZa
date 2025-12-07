<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    if (jobSeeker == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Profile Picture</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Upload Profile Picture</h2>
    <form action="UploadPhotoServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="photo" class="form-label">Select Image:</label>
            <input type="file" name="photo" id="photo" class="form-control" accept="image/*" required>
        </div>
        <input type="hidden" name="seekerId" value="<%= jobSeeker.getId() %>">
        <button type="submit" class="btn btn-primary">Upload</button>
    </form>
</div>
</body>
</html>
