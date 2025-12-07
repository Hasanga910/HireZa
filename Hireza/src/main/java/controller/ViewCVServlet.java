package controller;

import dao.CVDAO;
import model.CV;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/recruiter/view-cv")
public class ViewCVServlet extends HttpServlet {
    private CVDAO cvDAO = new CVDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"Recruiter".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/signin.jsp");
            return;
        }

        int seekerId;
        try {
            seekerId = Integer.parseInt(request.getParameter("seekerId"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Recruiter/select_job.jsp");
            return;
        }

        CV cv = cvDAO.getCVBySeekerId(String.valueOf(user.getId()));

        if (cv == null) {
            response.sendRedirect(request.getContextPath() + "/company/applications?jobId=" + request.getParameter("jobId") + "&error=noCV");
            return;
        }

        request.setAttribute("cv", cv);
        request.getRequestDispatcher("/Recruiter/view_cv.jsp").forward(request, response);
    }
}