package controllers;

import entities.Apprenant;
import entities.Formation;
import services.ApprenantService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AfficherAffecterApprenantController", urlPatterns = {"/admin/affecter-apprenant"})
public class AfficherAffecterApprenantController extends HttpServlet {

    private ApprenantService apprenantService = new ApprenantService();
    private FormationService formationService = new FormationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Charger tous les apprenants
        List<Apprenant> apprenants = apprenantService.findAll();

        // Charger toutes les formations
        List<Formation> formations = formationService.findAll();

        // Mettre dans la requête
        request.setAttribute("apprenants", apprenants);
        request.setAttribute("formations", formations);

        // Envoyer vers la JSP
        request.getRequestDispatcher("/views/admin/affecter-apprenant.jsp").forward(request, response);
    }
}
