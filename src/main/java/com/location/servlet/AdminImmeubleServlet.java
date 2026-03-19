package com.location.servlet;

import com.location.entities.Immeuble;
import com.location.entities.Utilisateur;
import com.location.services.implementations.ImmeubleServiceImpl;
import com.location.services.implementations.UtilisateurServiceImpl;
import com.location.services.serviceInterfaces.ImmeubleService;
import com.location.services.serviceInterfaces.UtilisateurService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminImmeubleServlet",
        urlPatterns = {"/admin/immeubles", "/admin/immeuble/*"})
public class AdminImmeubleServlet extends HttpServlet {

    private ImmeubleService    immeubleService;
    private UtilisateurService utilisateurService;

    @Override
    public void init() {
        immeubleService    = new ImmeubleServiceImpl();
        utilisateurService = new UtilisateurServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String servletPath = req.getServletPath();
        String pathInfo    = req.getPathInfo();

        // ── Liste de tous les immeubles : GET /admin/immeubles ──
        if ("/admin/immeubles".equals(servletPath)) {
            List<Immeuble> immeubles = immeubleService.findAll();
            req.setAttribute("immeubles", immeubles);
            req.getRequestDispatcher("/WEB-INF/views/admin/immeubles.jsp").forward(req, resp);

        // ── Formulaire édition : GET /admin/immeuble/edit/{id} ──
        } else if (pathInfo != null && pathInfo.startsWith("/edit/")) {
            Long id = Long.parseLong(pathInfo.replace("/edit/", ""));
            immeubleService.findById(id).ifPresent(i -> req.setAttribute("immeuble", i));
            chargerProprietaires(req);
            req.getRequestDispatcher("/WEB-INF/views/admin/immeuble-form.jsp").forward(req, resp);

        // ── Formulaire nouvel immeuble : GET /admin/immeuble/new ──
        } else {
            chargerProprietaires(req);
            req.getRequestDispatcher("/WEB-INF/views/admin/immeuble-form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("supprimer".equals(action)) {
            Long id = Long.parseLong(req.getParameter("id"));
            immeubleService.supprimer(id);

        } else {
            Immeuble immeuble = new Immeuble();
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isBlank()) {
                immeuble.setId(Long.parseLong(idParam));
            }
            immeuble.setNom(req.getParameter("nom"));
            immeuble.setAdresse(req.getParameter("adresse"));
            immeuble.setVille(req.getParameter("ville"));
            immeuble.setCodePostal(req.getParameter("codePostal"));
            immeuble.setDescription(req.getParameter("description"));

            // L'admin peut assigner n'importe quel propriétaire
            String propId = req.getParameter("proprietaireId");
            if (propId != null && !propId.isBlank()) {
                utilisateurService.findById(Long.parseLong(propId))
                        .ifPresent(immeuble::setProprietaire);
            }

            if (immeuble.getId() == null) {
                immeubleService.ajouter(immeuble);
            } else {
                immeubleService.modifier(immeuble);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/immeubles");
    }

    private void chargerProprietaires(HttpServletRequest req) {
        req.setAttribute("proprietaires",
                utilisateurService.findByRole(Utilisateur.RoleUtilisateur.PROPRIETAIRE));
    }
}
