package controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ValiderCodeController", urlPatterns = {"/valider-code"})
public class ValiderCodeController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String codeSaisi = request.getParameter("code");
        String codeEnvoye = (String) session.getAttribute("code");
        Long codeTimestamp = (Long) session.getAttribute("code_timestamp");

        // Tentatives restantes
        Integer attemptsLeft = (Integer) session.getAttribute("attemptsLeft");
        if (attemptsLeft == null) {
            attemptsLeft = 3; // max 3 tentatives
        }

        // Vérification session
        if (codeEnvoye == null || codeTimestamp == null) {
            response.sendRedirect("views/users/verifier-code.jsp?error=session");
            return;
        }

        // Vérification expiration du code (5 minutes)
        long now = System.currentTimeMillis();
        if ((now - codeTimestamp) > 300000) {
            session.removeAttribute("code");
            session.removeAttribute("code_timestamp");
            session.removeAttribute("attemptsLeft");
            response.sendRedirect("views/users/verifier-code.jsp?error=expired");
            return;
        }

        // ✅ Si le code est correct
        if (codeSaisi != null && codeSaisi.equals(codeEnvoye)) {
            session.removeAttribute("attemptsLeft");
            response.sendRedirect("views/users/reset-password.jsp");

        } else {
            // ❌ Mauvais code
            attemptsLeft--;
            session.setAttribute("attemptsLeft", attemptsLeft);

            if (attemptsLeft <= 0) {
                // Bloquer pendant 10 minutes
                long blockedUntil = System.currentTimeMillis() + 10 * 60 * 1000;
                session.setAttribute("blocked_until", blockedUntil);

                session.removeAttribute("code");
                session.removeAttribute("code_timestamp");
                session.removeAttribute("attemptsLeft");

                response.sendRedirect("views/users/forgotPassword.jsp?error=limit");
            } else {
                // Renvoyer vers le formulaire avec le nombre de tentatives restantes
                response.sendRedirect("views/users/verifier-code.jsp?error=code&left=" + attemptsLeft);
            }
        }
    }
}
