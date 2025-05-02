package controllers;

import entities.Cours;
import entities.Formation;
import services.CoursService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import services.FormationService;

@WebServlet(name = "CoursController", urlPatterns = {"/cours"})
public class CoursController extends HttpServlet {

    private final CoursService coursService = new CoursService();
    private final FormationService formationService = new FormationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Cours> coursList = coursService.findAll();
        request.setAttribute("coursList", coursList);
        request.getRequestDispatcher("/views/admin/cours.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String action = request.getParameter("action");

    if ("ajouter".equals(action)) {
        String titre = request.getParameter("titre");
        String contenu = request.getParameter("contenu");
        int formationId = Integer.parseInt(request.getParameter("formationId"));
        
        // ✅ Récupérer l'objet Formation à partir de l'ID
        Formation formation = formationService.findById(formationId);
        
        // ✅ Créer le cours avec l'objet Formation
        coursService.create(new Cours(titre, contenu, formation));
    }

    response.sendRedirect("cours");
}
}
