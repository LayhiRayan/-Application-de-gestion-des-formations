/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Inscription;
import entities.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.InscriptionService;

/**
 *
 * @author HP-PC
 */
@WebServlet("/calendrier")
public class CalendrierController extends HttpServlet {

    private InscriptionService inscriptionService;

    @Override
    public void init() {
        inscriptionService = new InscriptionService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && "apprenant".equals(session.getAttribute("type"))) {
            List<Inscription> inscriptions = inscriptionService.findByApprenant(user.getId());
            session.setAttribute("inscriptions", inscriptions);
            request.getRequestDispatcher("/views/apprenants/calendrier.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
        }
    }
}

