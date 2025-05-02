package controllers;

import entities.Cours;
import entities.Formation;
import services.CoursService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListeCoursController", urlPatterns = {"/formateur/liste-cours"})
public class ListeCoursController extends HttpServlet {

    private final CoursService coursService = new CoursService();
    private final FormationService formationService = new FormationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int formationId = Integer.parseInt(request.getParameter("formationId"));
            Formation formation = formationService.findById(formationId);

            if (formation != null) {
                List<Cours> coursList = coursService.findByFormation(formation);
                request.setAttribute("formation", formation);
                request.setAttribute("coursList", coursList);
                request.getRequestDispatcher("/views/formateur/liste-cours.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/formateur/dashboard");
    }
}
