package com.location.servlet;

import com.location.entities.Utilisateur;
import com.location.services.implementations.UtilisateurServiceImpl;
import com.location.services.serviceInterfaces.UtilisateurService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUtilisateurServlet",
        urlPatterns = {"/admin/utilisateurs", "/admin/utilisateur/*"})
public class AdminUtilisateurServlet extends HttpServlet {

    private UtilisateurService utilisateurService;

    @Override
    public void init() {
        utilisateurService = new UtilisateurServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String servletPath = req.getServletPath();
        String pathInfo    = req.getPathInfo();

        // Liste de tous les utilisateurs : GET /admin/utilisateurs
        if ("/admin/utilisateurs".equals(servletPath)) {
            List<Utilisateur> utilisateurs = utilisateurService.findAll();
            req.setAttribute("utilisateurs", utilisateurs);
            req.getRequestDispatcher("/WEB-INF/views/admin/utilisateurs.jsp").forward(req, resp);

        // Formulaire édition : GET /admin/utilisateur/edit/{id}
        } else if (pathInfo != null && pathInfo.startsWith("/edit/")) {
            Long id = Long.parseLong(pathInfo.replace("/edit/", ""));
            utilisateurService.findById(id).ifPresent(u -> req.setAttribute("utilisateur", u));
            req.getRequestDispatcher("/WEB-INF/views/admin/utilisateur-form.jsp").forward(req, resp);

        // Formulaire nouvel utilisateur : GET /admin/utilisateur/new
        } else {
            req.getRequestDispatcher("/WEB-INF/views/admin/utilisateur-form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        switch (action == null ? "" : action) {

            // Activer / désactiver un compte
            case "toggle" -> {
                Long id = Long.parseLong(req.getParameter("id"));
                utilisateurService.findById(id).ifPresent(u -> {
                    u.setActif(!u.isActif());
                    utilisateurService.modifier(u);
                });
            }

            // Supprimer un utilisateur
            case "supprimer" -> {
                Long id = Long.parseLong(req.getParameter("id"));
                utilisateurService.supprimer(id);
            }

            // Créer ou modifier
            default -> {
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isBlank()) {
                    // Modification
                    utilisateurService.findById(Long.parseLong(idParam)).ifPresent(u -> {
                        u.setNom(req.getParameter("nom"));
                        u.setPrenom(req.getParameter("prenom"));
                        u.setEmail(req.getParameter("email"));
                        u.setTelephone(req.getParameter("telephone"));
                        u.setRole(Utilisateur.RoleUtilisateur.valueOf(req.getParameter("role")));
                        utilisateurService.modifier(u);
                    });
                } else {
                    // Création par l'admin (peut créer n'importe quel rôle)
                    Utilisateur u = new Utilisateur();
                    u.setNom(req.getParameter("nom"));
                    u.setPrenom(req.getParameter("prenom"));
                    u.setEmail(req.getParameter("email"));
                    u.setMotDePasse(req.getParameter("password"));
                    u.setTelephone(req.getParameter("telephone"));
                    u.setRole(Utilisateur.RoleUtilisateur.valueOf(req.getParameter("role")));
                    utilisateurService.inscrire(u);
                }
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/utilisateurs");
    }
}
