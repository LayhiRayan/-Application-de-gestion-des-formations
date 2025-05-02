package controllers;

import entities.Formation;
import entities.Formateur;
import services.FormationService;
import services.FormateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AffecterFormateurController", urlPatterns = {"/admin/affecter-formateur"})
public class AffecterFormateurController extends HttpServlet {

    private FormationService formationService;
    private FormateurService formateurService;

    @Override
    public void init() throws ServletException {
        formationService = new FormationService();
        formateurService = new FormateurService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int formationId = Integer.parseInt(request.getParameter("formationId"));
            int formateurId = Integer.parseInt(request.getParameter("formateurId"));

            Formation formation = formationService.findById(formationId);
            Formateur formateur = formateurService.findById(formateurId);

            if (formation != null && formateur != null) {
                formation.setFormateur(formateur);
                formationService.update(formation);

                // Rediriger après succès
                response.sendRedirect(request.getContextPath() + "/admin/formateurs");
            } else {
                // Si formation ou formateur introuvable
                response.sendRedirect(request.getContextPath() + "/admin/formateurs?error=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/formateurs?error=servererror");
        }
    }
}
