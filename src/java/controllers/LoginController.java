package controllers;

import entities.User;
import services.UserService;
import services.ApprenantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private UserService userService;
    private ApprenantService apprenantService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
        apprenantService = new ApprenantService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("mdp").trim();
        String roleFromForm = request.getParameter("role").trim();

        User user = userService.findByEmail(email);

        if (user != null) {
            if (user.getMotDePasse().equals(password)) {

                if (user.getRole().equalsIgnoreCase(roleFromForm)) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", user);
                    session.setAttribute("type", user.getRole());

                    switch (user.getRole()) {
                        case "apprenant":
                            session.setAttribute("formations", apprenantService.findFormationsByApprenant(user.getId()));
                            response.sendRedirect(request.getContextPath() + "/views/apprenants/dashboard.jsp");
                            break;

                        case "formateur":
                            response.sendRedirect(request.getContextPath() + "/views/formateurs/dashboard.jsp");
                            break;

                        case "admin":
                            response.sendRedirect(request.getContextPath() + "/admin");
                            break;

                        default:
                            response.sendRedirect("views/users/login.jsp?msg=Rôle non reconnu");
                    }
                } else {
                    response.sendRedirect("views/users/login.jsp?msg=Rôle incorrect pour cet utilisateur");
                }

            } else {
                response.sendRedirect("views/users/login.jsp?msg=Mot de passe incorrect");
            }
        } else {
            response.sendRedirect("views/users/login.jsp?msg=Email introuvable");
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
        return "LoginController - Gère l'authentification des utilisateurs selon le rôle";
    }
}
