package controllers;

import entities.Admin;
import entities.Apprenant;
import entities.Formateur;
import entities.Formation;
import services.AdminService;
import services.ApprenantService;
import services.FormateurService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    private final ApprenantService apprenantService = new ApprenantService();
    private final FormateurService formateurService = new FormateurService();
    private final AdminService adminService = new AdminService();
    private final FormationService formationService = new FormationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Apprenant> apprenants = apprenantService.findAll();
        List<Formateur> formateurs = formateurService.findAll();
        List<Formation> formations = formationService.findAll();

        request.setAttribute("apprenants", apprenants);
        request.setAttribute("formateurs", formateurs);
        request.setAttribute("formations", formations);

        request.getRequestDispatcher("/views/admin/dashboard-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("ajouterApprenant".equals(action)) {
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String mdp = request.getParameter("motDePasse");
            apprenantService.create(new Apprenant(nom, email, mdp));
        }

        else if ("modifierApprenant".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Apprenant a = apprenantService.findById(id);
            if (a != null) {
                a.setNom(request.getParameter("nom"));
                a.setEmail(request.getParameter("email"));
                a.setMotDePasse(request.getParameter("motDePasse"));
                apprenantService.update(a);
            }
        }

        else if ("supprimerApprenant".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Apprenant a = apprenantService.findById(id);
            if (a != null) apprenantService.delete(a);
        }

        else if ("ajouterFormateur".equals(action)) {
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String mdp = request.getParameter("motDePasse");
            String specialite = request.getParameter("specialite");
            formateurService.create(new Formateur(nom, email, mdp, specialite));
        }

        else if ("modifierFormateur".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Formateur f = formateurService.findById(id);
            if (f != null) {
                f.setNom(request.getParameter("nom"));
                f.setEmail(request.getParameter("email"));
                f.setMotDePasse(request.getParameter("motDePasse"));
                f.setSpecialite(request.getParameter("specialite"));
                formateurService.update(f);
            }
        }

        else if ("supprimerFormateur".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Formateur f = formateurService.findById(id);
            if (f != null) formateurService.delete(f);
        }

        else if ("ajouterFormation".equals(action)) {
            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            int duree = Integer.parseInt(request.getParameter("duree"));
            int formateurId = Integer.parseInt(request.getParameter("formateurId"));

            Formateur formateur = formateurService.findById(formateurId);
            Formation formation = new Formation(titre, description, duree);
            formation.setFormateur(formateur);
            formationService.create(formation);
        }

        else if ("supprimerFormation".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Formation f = formationService.findById(id);
            if (f != null) formationService.delete(f);
        }

        else if ("modifierFormation".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Formation f = formationService.findById(id);
            if (f != null) {
                f.setTitre(request.getParameter("titre"));
                f.setDescription(request.getParameter("description"));
                f.setDuree(Integer.parseInt(request.getParameter("duree")));
                int formateurId = Integer.parseInt(request.getParameter("formateurId"));
                Formateur formateur = formateurService.findById(formateurId);
                f.setFormateur(formateur);
                formationService.update(f);
            }
        }

        response.sendRedirect("admin");
    }
}
