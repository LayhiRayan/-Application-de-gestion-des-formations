package controllers;

import entities.Apprenant;
import entities.Formation;
import entities.Inscription;
import services.FormationService;
import services.InscriptionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet(name = "InscrireFormationController", urlPatterns = {"/inscrireFormation"})
public class InscrireFormationController extends HttpServlet {

    private FormationService formationService;
    private InscriptionService inscriptionService;

    @Override
    public void init() throws ServletException {
        formationService = new FormationService();
        inscriptionService = new InscriptionService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        try {
            if (op == null) {
                // ➡ Inscription simple

                HttpSession session = request.getSession();
                Apprenant apprenant = (Apprenant) session.getAttribute("user");
                String idFormation = request.getParameter("formationId");

                if (apprenant != null && idFormation != null) {
                    int formationId = Integer.parseInt(idFormation);
                    Formation formation = formationService.findById(formationId);

                    if (formation != null) {
                        boolean dejaInscrit = inscriptionService.isApprenantInscrit(apprenant.getId(), formationId);

                        if (dejaInscrit) {
                            response.sendRedirect("views/apprenants/dashboard.jsp?error=deja_inscrit");
                        } else {
                            Inscription inscription = new Inscription();
                            inscription.setApprenant(apprenant);
                            inscription.setFormation(formation);
                            inscription.setDateInscription(new Date());
                            inscriptionService.create(inscription);

                            response.sendRedirect("views/apprenants/dashboard.jsp?success=inscrit");
                        }
                    } else {
                        response.sendRedirect("views/apprenants/dashboard.jsp?error=formation_inexistante");
                    }
                } else {
                    response.sendRedirect("views/apprenants/dashboard.jsp?error=session_expiree");
                }

            } else if (op.equals("delete")) {
                // ➡ Suppression d'une inscription (par admin par exemple)

                int id = Integer.parseInt(request.getParameter("id"));
                Inscription inscription = inscriptionService.findById(id);

                if (inscription != null) {
                    inscriptionService.delete(inscription);
                    response.sendRedirect("Route?page=inscriptions&success=supprime");
                } else {
                    response.sendRedirect("Route?page=inscriptions&error=not_found");
                }

            } else if (op.equals("update")) {
                // ➡ Préparation pour update (optionnel ici)

                int id = Integer.parseInt(request.getParameter("id"));
                Inscription inscription = inscriptionService.findById(id);

                if (inscription != null) {
                    // Tu pourrais rediriger vers une page update
                    response.sendRedirect("Route?page=modifierInscription&id=" + inscription.getId());
                } else {
                    response.sendRedirect("Route?page=inscriptions&error=not_found");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/apprenants/dashboard.jsp?error=internal_error");
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
        return "Inscrire Formation Controller";
    }
}
