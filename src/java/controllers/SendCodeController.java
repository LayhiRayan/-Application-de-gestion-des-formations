package controllers;

import entities.User;
import services.SendMail;
import services.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet(name = "SendCodeController", urlPatterns = {"/send-code"})
public class SendCodeController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        HttpSession session = request.getSession();

        // Vérifie si l'utilisateur existe
        User user = userService.findByEmail(email);
        if (user == null) {
            response.sendRedirect("views/users/forgotPassword.jsp?error=email");
            return;
        }

        // ✅ Génération du code aléatoire
        String code = String.valueOf(new Random().nextInt(900000) + 100000);

        // Stockage en session
        session.setAttribute("user_reset", user);
        session.setAttribute("code", code);
        session.setAttribute("code_timestamp", System.currentTimeMillis());
        session.setAttribute("attemptsLeft", 3); // pour la validation du code

        // Envoi du mail
        SendMail.envoyerCode(email, code);

        // Redirection
        response.sendRedirect("views/users/verifier-code.jsp");
    }
}
