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

@WebServlet(name = "FormateursPageController", urlPatterns = {"/admin/formateurs"})
public class FormateursPageController extends HttpServlet {

    private FormationService formationService;
    private FormateurService formateurService;

    @Override
    public void init() throws ServletException {
        super.init();
        formationService = new FormationService();
        formateurService = new FormateurService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Formation> formations = formationService.findAll();
            List<Formateur> formateurs = formateurService.findAll();

            request.setAttribute("formations", formations);
            request.setAttribute("formateurs", formateurs);

            request.getRequestDispatcher("/views/admin/affecter-formateur.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp"); // Optionnel : page d'erreur
        }
    }
}
