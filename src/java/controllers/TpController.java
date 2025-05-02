package controllers;

import entities.Tp;
import entities.Formation;
import services.TpService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TpController", urlPatterns = {"/tp"})
public class TpController extends HttpServlet {

    private final TpService tpService = new TpService();
    private final FormationService formationService = new FormationService(); // ✅ Pour récupérer l'objet Formation

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Tp> tpList = tpService.findAll();
        request.setAttribute("tpList", tpList);

        List<Formation> formations = formationService.findAll(); // Pour afficher les formations dans un select si nécessaire
        request.setAttribute("formations", formations);

        request.getRequestDispatcher("/views/admin/tp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            String sujet = request.getParameter("sujet");
            int formationId = Integer.parseInt(request.getParameter("formationId"));

            // ✅ Récupérer l'objet Formation avant de créer le TP
            Formation formation = formationService.findById(formationId);

            if (formation != null) {
                tpService.create(new Tp(sujet, formation));
            }

        } else if ("supprimer".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Tp tp = tpService.findById(id);
            if (tp != null) tpService.delete(tp);
        }

        response.sendRedirect("tp");
    }
}
