package controllers;

import entities.Apprenant;
import services.ApprenantService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ApprenantController", urlPatterns = {"/ApprenantController"})
public class ApprenantController extends HttpServlet {

    private ApprenantService as;

    @Override
    public void init() throws ServletException {
        super.init();
        as = new ApprenantService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op == null) {
            String id = request.getParameter("id");
            if (id == null) {
                String nom = request.getParameter("nom");
                String email = request.getParameter("email");
                String motDePasse = request.getParameter("motDePasse");
                as.create(new Apprenant(nom, email, motDePasse));
                response.sendRedirect("apprenants/page.jsp");
            } else {
                String nom = request.getParameter("nom");
                String email = request.getParameter("email");
                String motDePasse = request.getParameter("motDePasse");
                Apprenant a = new Apprenant(nom, email, motDePasse);
                a.setId(Integer.parseInt(id));
                as.update(a);
                response.sendRedirect("apprenants/page.jsp");
            }
        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            as.delete(as.findById(Integer.parseInt(id)));
            response.sendRedirect("apprenants/page.jsp");
        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            Apprenant a = as.findById(Integer.parseInt(id));
            response.sendRedirect("apprenants/page.jsp?id=" + a.getId() + "&nom=" + a.getNom() + "&email=" + a.getEmail());
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
        return "Short description";
    }
}
