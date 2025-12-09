package controller;

import dao.JobPostDAO;
import model.JobPost;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class JobDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jobIdStr = request.getParameter("jobId");
        String companyIdStr = request.getParameter("companyId");

        if (jobIdStr == null || companyIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing jobId or companyId");
            return;
        }

        JobPostDAO dao = new JobPostDAO();
        JobPost job = dao.getJobPostById(jobIdStr, companyIdStr);

        if (job == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Job not found");
            return;
        }

        request.setAttribute("job", job);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jobseeker/Jobdetails.jsp");
        dispatcher.forward(request, response);

        System.out.println("✅ Job details fetched: jobId = " + jobIdStr + ", companyId = " + companyIdStr);
    }
}


