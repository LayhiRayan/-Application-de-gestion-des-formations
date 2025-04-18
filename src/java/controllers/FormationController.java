package controllers;

import entities.Formation;
import services.FormationService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "FormationController", urlPatterns = {"/FormationController"})
public class FormationController extends HttpServlet {

    private FormationService fs;

    @Override
    public void init() throws ServletException {
        super.init();
        fs = new FormationService();  // Initialisation du service Formation
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op == null) {  // Si aucune opération n'est spécifiée, c'est une création ou une mise à jour
            String id = request.getParameter("id");
            if (id == null) {
                // Créer une nouvelle Formation
                String titre = request.getParameter("titre");
                String description = request.getParameter("description");
                int duree = Integer.parseInt(request.getParameter("duree"));
                fs.create(new Formation(titre, description, duree));  // Créer la formation
                response.sendRedirect("formations/page.jsp");
            } else {
                // Mettre à jour une formation existante
                String titre = request.getParameter("titre");
                String description = request.getParameter("description");
                int duree = Integer.parseInt(request.getParameter("duree"));
                Formation formation = new Formation(titre, description, duree);
                formation.setId(Integer.parseInt(id));
                fs.update(formation);  // Mettre à jour la formation
                response.sendRedirect("formations/page.jsp");
            }
        } else if (op.equals("delete")) {  // Si l'opération est de suppression
            String id = request.getParameter("id");
            fs.delete(fs.findById(Integer.parseInt(id)));  // Supprimer la formation
            response.sendRedirect("formations/page.jsp");
        } else if (op.equals("update")) {  // Si l'opération est de modification
            String id = request.getParameter("id");
            Formation formation = fs.findById(Integer.parseInt(id));
            response.sendRedirect("formations/page.jsp?id=" + formation.getId() + "&titre=" + formation.getTitre() + 
                "&description=" + formation.getDescription() + "&duree=" + formation.getDuree());
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
        return "FormationController - Gère l'inscription, la mise à jour et la suppression des formations";
    }
}
