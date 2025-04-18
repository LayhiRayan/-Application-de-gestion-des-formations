package controllers;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet(name = "VerifyCodeController", urlPatterns = {"/VerifyCodeController"})
public class VerifyCodeController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codeInput = request.getParameter("code");
        HttpSession session = request.getSession();
        String code = (String) session.getAttribute("reset_code");

        if (code != null && code.equals(codeInput)) {
            response.sendRedirect("views/users/update-password.jsp");
        } else {
            response.sendRedirect("views/users/verify-code.jsp?error=invalid");
        }
    }
}
