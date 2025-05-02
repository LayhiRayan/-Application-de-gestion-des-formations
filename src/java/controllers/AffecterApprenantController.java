package controllers;

import entities.Apprenant;
import entities.Formation;
import entities.Inscription;
import entities.InscriptionPK;
import services.ApprenantService;
import services.FormationService;
import services.InscriptionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AffecterApprenantController", urlPatterns = {"/AffecterApprenantController"})
public class AffecterApprenantController extends HttpServlet {

    private final InscriptionService inscriptionService = new InscriptionService();
    private final ApprenantService apprenantService = new ApprenantService();
    private final FormationService formationService = new FormationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int apprenantId = Integer.parseInt(request.getParameter("apprenantId"));
            String[] formationIds = request.getParameterValues("formationIds");

            if (formationIds != null && formationIds.length > 0) {
                // ✅ Charger l'apprenant existant
                Apprenant apprenant = apprenantService.findById(apprenantId);

                if (apprenant != null) {
                    for (String formationIdStr : formationIds) {
                        int formationId = Integer.parseInt(formationIdStr);
                        Formation formation = formationService.findById(formationId);

                        if (formation != null) {
                            // ✅ Vérifier si déjà inscrit
                            boolean dejaInscrit = inscriptionService.isApprenantInscrit(apprenant.getId(), formation.getId());
                            if (!dejaInscrit) {
                                // ✅ Créer inscription et ID composite
                                Inscription inscription = new Inscription();
                                inscription.setApprenant(apprenant);
                                inscription.setFormation(formation);
                                inscription.setDateInscription(new Date());
                                inscription.setId(new InscriptionPK(apprenant.getId(), formation.getId())); // 💥 Important

                                inscriptionService.create(inscription);
                            }
                        }
                    }
                    request.setAttribute("successMessage", "✅ Affectation réussie !");
                } else {
                    request.setAttribute("errorMessage", "❌ Apprenant introuvable.");
                }
            } else {
                request.setAttribute("errorMessage", "⚠ Vous devez sélectionner au moins une formation.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "❌ Une erreur est survenue lors de l'affectation.");
        }

        // ✅ Toujours recharger après traitement
        List<Apprenant> apprenants = apprenantService.findAll();
        List<Formation> formations = formationService.findAll();

        request.setAttribute("apprenants", apprenants);
        request.setAttribute("formations", formations);

        // ✅ Forward (PAS de redirect sinon on perd les messages)
        request.getRequestDispatcher("/views/admin/affecter-apprenant.jsp").forward(request, response);
    }
}
