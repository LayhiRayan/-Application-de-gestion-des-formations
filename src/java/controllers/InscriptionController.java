package controllers;

import entities.Apprenant;
import entities.Formateur;
import services.ApprenantService;
import services.FormateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "InscriptionController", urlPatterns = {"/InscriptionController"})
public class InscriptionController extends HttpServlet {

    private ApprenantService apprenantService;
    private FormateurService formateurService;

    @Override
    public void init() throws ServletException {
        apprenantService = new ApprenantService();
        formateurService = new FormateurService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String role = request.getParameter("role");
        String specialite = request.getParameter("specialite");

        if ("apprenant".equals(role)) {
            Apprenant a = new Apprenant(nom, email, motDePasse);
            a.setRole("apprenant");
            apprenantService.create(a);
        } else if ("formateur".equals(role)) {
            Formateur f = new Formateur(nom, email, motDePasse, specialite);
            f.setRole("formateur");
            formateurService.create(f);
        }

        response.sendRedirect("views/users/login.jsp?success=1");
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
}
