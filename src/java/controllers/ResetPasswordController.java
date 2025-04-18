package controllers;

import entities.User;
import services.UserService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    private final UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user_reset");

        if (newPassword.equals(confirmPassword)) {
            user.setMotDePasse(newPassword);  // 🔒 tu peux ajouter du hash si tu veux
            userService.update(user);
            session.removeAttribute("user_reset");
            session.removeAttribute("code");
            response.sendRedirect("views/users/login.jsp?success=reset");
        } else {
            response.sendRedirect("views/users/reset-password.jsp?error=confirm");
        }
    }
}
