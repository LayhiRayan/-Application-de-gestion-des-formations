package controllers;

import entities.Formateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ParametresFormateurController", urlPatterns = {"/formateur/parametres"})
public class ParametresFormateurController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Formateur formateur = (Formateur) session.getAttribute("user");

        if (formateur == null) {
            response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
            return;
        }

        request.getRequestDispatcher("/views/formateur/parametres.jsp").forward(request, response);
    }
}
