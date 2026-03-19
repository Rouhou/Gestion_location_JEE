package com.location.servlet;

import com.location.entities.Utilisateur;
import com.location.services.implementations.UtilisateurServiceImpl;
import com.location.services.serviceInterfaces.UtilisateurService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "AuthServlet", urlPatterns = {"/login", "/logout", "/register"})
public class AuthServlet extends HttpServlet {

    private UtilisateurService utilisateurService;

    @Override
    public void init() {
        utilisateurService = new UtilisateurServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/logout".equals(path)) {
            HttpSession session = req.getSession(false);
            if (session != null) session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.getRequestDispatcher("/WEB-INF/views/auth/" + getView(path)).forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        req.setCharacterEncoding("UTF-8");

        if ("/login".equals(path)) {
            handleLogin(req, resp);
        } else if ("/register".equals(path)) {
            handleRegister(req, resp);
        }
    }


    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Optional<Utilisateur> userOpt = utilisateurService.authentifier(email, password);
        if (userOpt.isPresent()) {
            HttpSession session = req.getSession(true);
            session.setAttribute("utilisateur", userOpt.get());
            session.setAttribute("role", userOpt.get().getRole().name());
            redirectByRole(userOpt.get(), req, resp);
        } else {
            req.setAttribute("erreur", "Email ou mot de passe incorrect.");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        String password = req.getParameter("password");
        String confirm = req.getParameter("passwordConfirm");

        if (!password.equals(confirm)) {
            throw new IllegalArgumentException("Les mots de passe ne correspondent pas");
        }
        try {
            Utilisateur u = new Utilisateur();
            u.setNom(req.getParameter("nom"));
            u.setPrenom(req.getParameter("prenom"));
            u.setEmail(req.getParameter("email"));
            u.setMotDePasse(password);
            u.setTelephone(req.getParameter("telephone"));
            u.setRole(Utilisateur.RoleUtilisateur.LOCATAIRE);
            utilisateurService.inscrire(u);
            resp.sendRedirect(req.getContextPath() + "/login?success=1");
        } catch (IllegalArgumentException e) {
            req.setAttribute("erreur", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        }
    }

    private void redirectByRole(Utilisateur u, HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String ctx = req.getContextPath();
        switch (u.getRole()) {
            case ADMIN       -> resp.sendRedirect(ctx + "/admin/dashboard");
            case PROPRIETAIRE -> resp.sendRedirect(ctx + "/proprietaire/immeubles");
            default          -> resp.sendRedirect(ctx + "/locataire/offres");
        }
    }

    private String getView(String path) {
        return switch (path) {
            case "/login"    -> "login.jsp";
            case "/register" -> "register.jsp";
            default          -> "login.jsp";
        };
    }
}
