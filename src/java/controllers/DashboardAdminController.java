package controllers;

import entities.Apprenant;
import entities.Formateur;
import entities.Formation;
import services.ApprenantService;
import services.FormateurService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardAdminController", urlPatterns = {"/admin/dashboard-admin"})
public class DashboardAdminController extends HttpServlet {

    private ApprenantService apprenantService = new ApprenantService();
    private FormateurService formateurService = new FormateurService();
    private FormationService formationService = new FormationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Charger les listes
        List<Apprenant> apprenants = apprenantService.findAll();
        List<Formateur> formateurs = formateurService.findAll();
        List<Formation> formations = formationService.findAll();

        // Ajouter aux attributs de la requête
        request.setAttribute("apprenants", apprenants);
        request.setAttribute("formateurs", formateurs);
        request.setAttribute("formations", formations);

        // Forward vers dashboard JSP
        request.getRequestDispatcher("/views/admin/dashboard-admin.jsp").forward(request, response);
    }
}
