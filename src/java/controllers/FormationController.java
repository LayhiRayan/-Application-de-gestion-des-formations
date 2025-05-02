package controllers;

import entities.Formation;
import entities.Formateur;
import services.FormationService;
import services.FormateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "FormationController", urlPatterns = {"/FormationController"})
public class FormationController extends HttpServlet {

    private FormationService formationService;
    private FormateurService formateurService;

    @Override
    public void init() throws ServletException {
        formationService = new FormationService();
        formateurService = new FormateurService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String op = request.getParameter("op");

            if (op == null && request.getMethod().equals("GET")) {
                // ✅ Par défaut : afficher la page des formations
                List<Formation> formations = formationService.findAll();
                List<Formateur> formateurs = formateurService.findAll();
                request.setAttribute("formations", formations);
                request.setAttribute("formateurs", formateurs);
                request.getRequestDispatcher("/views/admin/formations.jsp").forward(request, response);
                return;
            }

            if ("delete".equals(op)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Formation formation = formationService.findById(id);
                if (formation != null) {
                    formationService.delete(formation);
                }
                response.sendRedirect(request.getContextPath() + "/FormationController");

            } else if ("update".equals(op)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Formation formation = formationService.findById(id);
                if (formation != null) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/affecter-formateur.jsp?id=" 
                        + formation.getId() + "&titre=" + formation.getTitre()
                        + "&description=" + formation.getDescription()
                        + "&duree=" + formation.getDuree()
                        + "&formateurId=" + (formation.getFormateur() != null ? formation.getFormateur().getId() : ""));
                } else {
                    response.sendRedirect(request.getContextPath() + "/FormationController");
                }

            } else {
                // Créer ou modifier une formation
                String id = request.getParameter("id");
                String titre = request.getParameter("titre");
                String description = request.getParameter("description");
                int duree = Integer.parseInt(request.getParameter("duree"));
                int formateurId = Integer.parseInt(request.getParameter("formateurId"));

                Formateur formateur = formateurService.findById(formateurId);
                if (formateur != null) {
                    if (id == null || id.isEmpty()) {
                        // ➕ Création
                        Formation formation = new Formation();
                        formation.setTitre(titre);
                        formation.setDescription(description);
                        formation.setDuree(duree);
                        formation.setFormateur(formateur);
                        formationService.create(formation);
                    } else {
                        // ✏️ Mise à jour
                        Formation formation = formationService.findById(Integer.parseInt(id));
                        if (formation != null) {
                            formation.setTitre(titre);
                            formation.setDescription(description);
                            formation.setDuree(duree);
                            formation.setFormateur(formateur);
                            formationService.update(formation);
                        }
                    }
                }

                response.sendRedirect(request.getContextPath() + "/FormationController");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("❌ Erreur : " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "FormationController - Gère les formations avec formateur affecté directement";
    }
}
