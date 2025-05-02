package controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ParametresAdminController", urlPatterns = {"/admin/parametres"})
public class ParametresAdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 🚀 Juste afficher la page parametres.jsp
        request.getRequestDispatcher("/views/admin/parametres.jsp").forward(request, response);
    }
}
