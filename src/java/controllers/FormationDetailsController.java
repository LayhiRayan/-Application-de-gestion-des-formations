package controllers;

import entities.Formation;
import services.CoursService;
import services.FormationService;
import services.TpService;
import services.VideoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "FormationDetailsController", urlPatterns = {"/formationDetails"})
public class FormationDetailsController extends HttpServlet {
    
    private final FormationService formationService = new FormationService();
    private final CoursService coursService = new CoursService();
    private final TpService tpService = new TpService();
    private final VideoService videoService = new VideoService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Formation f = formationService.findById(id);

                if (f != null) {
                    request.setAttribute("formation", f);
                    request.setAttribute("coursList", coursService.findByFormation(f));
                    request.setAttribute("tpList", tpService.findByFormation(f));
                    request.setAttribute("videoList", videoService.findByFormation(f));
                } else {
                    request.setAttribute("error", "Formation non trouvée.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de formation invalide.");
            }
        } else {
            request.setAttribute("error", "ID de formation manquant.");
        }

        request.getRequestDispatcher("/views/apprenants/formationDetails.jsp").forward(request, response);
    }
}
