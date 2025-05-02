package controllers;

import com.google.gson.Gson;
import entities.Formation;
import services.FormationService;
import services.InscriptionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "StatistiquesController", urlPatterns = {"/StatistiquesController"})
public class StatistiquesController extends HttpServlet {

    private FormationService formationService;
    private InscriptionService inscriptionService;

    @Override
    public void init() throws ServletException {
        formationService = new FormationService();
        inscriptionService = new InscriptionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Formation> formations = formationService.findAll();
            Map<String, Integer> statistiques = new LinkedHashMap<String, Integer>();

            for (Formation formation : formations) {
                int nbInscriptions = inscriptionService.countByFormation(formation.getId());
                statistiques.put(formation.getTitre(), nbInscriptions);
            }

            response.setContentType("application/json;charset=UTF-8");

            Gson gson = new Gson();
            String json = gson.toJson(statistiques);

            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
