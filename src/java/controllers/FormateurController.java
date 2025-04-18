package controllers;

import entities.Formateur;
import services.FormateurService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "FormateurController", urlPatterns = {"/FormateurController"})
public class FormateurController extends HttpServlet {

    private FormateurService fs;

    @Override
    public void init() throws ServletException {
        super.init();
        fs = new FormateurService();  // Initialisation du service Formateur
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op == null) {  // Si aucune opération n'est spécifiée, c'est une création ou une mise à jour
            String id = request.getParameter("id");
            if (id == null) {
                // Créer un nouveau Formateur
                String nom = request.getParameter("nom");
                String email = request.getParameter("email");
                String motDePasse = request.getParameter("motDePasse");
                String specialite = request.getParameter("specialite");
                Formateur formateur = new Formateur(nom, email, motDePasse, specialite);
                fs.create(formateur);  // Créer le formateur
                response.sendRedirect("formateurs/page.jsp");
            } else {
                // Mettre à jour un formateur existant
                String nom = request.getParameter("nom");
                String email = request.getParameter("email");
                String motDePasse = request.getParameter("motDePasse");
                String specialite = request.getParameter("specialite");

                Formateur formateur = new Formateur(nom, email, motDePasse, specialite);
                formateur.setId(Integer.parseInt(id));
                fs.update(formateur);  // Mettre à jour le formateur
                response.sendRedirect("formateurs/page.jsp");
            }
        } else if (op.equals("delete")) {  // Si l'opération est de suppression
            String id = request.getParameter("id");
            Formateur formateur = fs.findById(Integer.parseInt(id));
            fs.delete(formateur);  // Supprimer le formateur
            response.sendRedirect("formateurs/page.jsp");
        } else if (op.equals("update")) {  // Si l'opération est de modification
            String id = request.getParameter("id");
            Formateur formateur = fs.findById(Integer.parseInt(id));
            response.sendRedirect("formateurs/page.jsp?id=" + formateur.getId() + "&nom=" + formateur.getNom() +
                "&email=" + formateur.getEmail() + "&specialite=" + formateur.getSpecialite());
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
        return "FormateurController - Gère l'inscription, la mise à jour et la suppression des formateurs";
    }
}
