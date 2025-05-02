package controllers;

import entities.Video;
import entities.Formation;
import services.VideoService;
import services.FormationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "VideoController", urlPatterns = {"/video"})
public class VideoController extends HttpServlet {

    private final VideoService videoService = new VideoService();
    private final FormationService formationService = new FormationService(); // ✅ pour récupérer une formation

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Video> videoList = videoService.findAll();
        request.setAttribute("videoList", videoList);

        List<Formation> formations = formationService.findAll(); // pour la liste des formations si besoin dans un select
        request.setAttribute("formations", formations);

        request.getRequestDispatcher("/views/admin/video.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            String titre = request.getParameter("titre");
            String url = request.getParameter("url");
            int formationId = Integer.parseInt(request.getParameter("formationId"));

            Formation formation = formationService.findById(formationId); // ✅ conversion int → Formation
            if (formation != null) {
                videoService.create(new Video(titre, url, formation));
            }

        } else if ("supprimer".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Video v = videoService.findById(id);
            if (v != null) videoService.delete(v);
        }

        response.sendRedirect("video");
    }
}
