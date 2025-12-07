package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Invalidate the current session
        HttpSession session = req.getSession(false); // don't create if it doesn't exist
        if (session != null) {
            session.invalidate();
        }
        // Redirect to login page
        resp.sendRedirect(req.getContextPath() + "/jobseeker/signin.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle POST requests the same as GET
        doGet(req, resp);
    }
}