package controllers;

import entities.Formation;
import entities.Inscription;
import services.FormationService;
import services.InscriptionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListeApprenantsFormateurController", urlPatterns = {"/formateur/liste-apprenants"})
public class ListeApprenantsFormateurController extends HttpServlet {

    private final FormationService formationService = new FormationService();
    private final InscriptionService inscriptionService = new InscriptionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int formationId = Integer.parseInt(request.getParameter("formationId"));
            Formation formation = formationService.findById(formationId);

            if (formation != null) {
                // Utilise la méthode correcte
                List<Inscription> inscriptions = inscriptionService.findByFormation(formationId);

                request.setAttribute("formation", formation);
                request.setAttribute("inscriptions", inscriptions);
                request.getRequestDispatcher("/views/formateur/liste-apprenants.jsp").forward(request, response);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirection de secours si erreur
        response.sendRedirect(request.getContextPath() + "/formateur/dashboard-formateur.jsp");
    }
}
