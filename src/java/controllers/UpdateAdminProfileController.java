package controllers;

import entities.Admin;
import services.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UpdateAdminProfileController", urlPatterns = {"/UpdateAdminProfileController"})
public class UpdateAdminProfileController extends HttpServlet {

    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();  // ⚡ Attention : tu dois avoir un service AdminService
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("user");  // L'administrateur connecté
        
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/views/users/login.jsp");
            return;
        }

        try {
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");

            admin.setNom(nom);
            admin.setEmail(email);

            adminService.update(admin);  // 🔥 Mise à jour en base

            session.setAttribute("user", admin);  // ⚡ Mettre à jour la session aussi
            response.sendRedirect(request.getContextPath() + "/admin/parametres?success=update");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/parametres?error=update_failed");
        }
    }
}
