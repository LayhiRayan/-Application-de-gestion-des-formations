package controllers;

import entities.Apprenant;
import entities.Formation;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "FormationsDisponiblesController", urlPatterns = {"/formations-disponibles"})
public class FormationsDisponiblesController extends HttpServlet {

    private final FormationService formationService = new FormationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Apprenant apprenant = (Apprenant) session.getAttribute("user");

        if (apprenant == null) {
            response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
            return;
        }

        // ✅ Charger les formations non inscrites
        List<Formation> nonInscrites = formationService.findFormationsNonInscrites(apprenant.getId());
        request.setAttribute("formations", nonInscrites);

        // ✅ Corriger ici vers ton bon fichier JSP
        request.getRequestDispatcher("/views/apprenants/nonInscritFormations.jsp").forward(request, response);
    }
    
}
