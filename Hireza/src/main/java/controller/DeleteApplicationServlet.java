package controller;

import dao.JobApplicationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteApplicationServlet")
public class DeleteApplicationServlet extends HttpServlet {

    private JobApplicationDAO jobAppDAO = new JobApplicationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String applicationId = request.getParameter("applicationId");

        if (applicationId != null && !applicationId.isEmpty()) {
            boolean deleted = jobAppDAO.deleteApplication(applicationId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?msg=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=delete_failed");
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/jobseeker/Myapplication?error=invalid_id");
        }
    }
}
