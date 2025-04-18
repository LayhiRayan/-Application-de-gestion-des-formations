package controllers;

import services.UserService;
import util.CodeGenerator;
import services.SendMail;
import entities.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/ForgotPasswordController"})
public class ForgotPasswordController extends HttpServlet {
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = userService.findByEmail(email);

        if (user != null) {
            String code = CodeGenerator.generateCode(6);
            HttpSession session = request.getSession();
            session.setAttribute("reset_code", code);
            session.setAttribute("reset_user", user);

            SendMail.envoyerCode(email, code);

            response.sendRedirect("views/users/verify-code.jsp");
        } else {
            response.sendRedirect("views/users/forgot-password.jsp?error=notfound");
        }
    }
}
