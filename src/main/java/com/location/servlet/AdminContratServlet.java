package com.location.servlet;

import com.location.entities.ContratLocation;
import com.location.entities.Utilisateur;
import com.location.entities.UniteLocation;
import com.location.services.implementations.ContratLocationServiceImpl;
import com.location.services.implementations.UniteLocationServiceImpl;
import com.location.services.implementations.UtilisateurServiceImpl;
import com.location.services.serviceInterfaces.ContratLocationService;
import com.location.services.serviceInterfaces.UniteLocationService;
import com.location.services.serviceInterfaces.UtilisateurService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "AdminContratServlet",
        urlPatterns = {"/admin/contrats", "/admin/contrat/*"})
public class AdminContratServlet extends HttpServlet {

    private ContratLocationService contratService;
    private UniteLocationService   uniteService;
    private UtilisateurService     utilisateurService;

    @Override
    public void init() {
        contratService     = new ContratLocationServiceImpl();
        uniteService       = new UniteLocationServiceImpl();
        utilisateurService = new UtilisateurServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String servletPath = req.getServletPath();
        String pathInfo    = req.getPathInfo();

        // ── Liste de tous les contrats : GET /admin/contrats ──
        if ("/admin/contrats".equals(servletPath)) {
            List<ContratLocation> contrats = contratService.findAll();
            req.setAttribute("contrats", contrats);
            req.getRequestDispatcher("/WEB-INF/views/admin/contrats.jsp").forward(req, resp);

        // ── Détail d'un contrat : GET /admin/contrat/{id} ──
        } else if (pathInfo != null && pathInfo.matches("/\\d+")) {
            Long id = Long.parseLong(pathInfo.substring(1));
            contratService.findById(id).ifPresent(c -> req.setAttribute("contrat", c));
            req.getRequestDispatcher("/WEB-INF/views/admin/contrat-detail.jsp").forward(req, resp);

        // ── Formulaire nouveau contrat : GET /admin/contrat/new ──
        } else {
            req.setAttribute("unitesDisponibles", uniteService.findDisponibles());
            req.setAttribute("locataires",
                    utilisateurService.findByRole(Utilisateur.RoleUtilisateur.LOCATAIRE));
            req.getRequestDispatcher("/WEB-INF/views/admin/contrat-form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        switch (action == null ? "" : action) {

            // Résilier un contrat
            case "resilier" -> {
                Long id = Long.parseLong(req.getParameter("id"));
                contratService.resilier(id);
            }

            // Créer un nouveau contrat
            default -> {
                ContratLocation contrat = new ContratLocation();

                Utilisateur locataire = new Utilisateur();
                locataire.setId(Long.parseLong(req.getParameter("locataireId")));
                contrat.setLocataire(locataire);

                UniteLocation unite = new UniteLocation();
                unite.setId(Long.parseLong(req.getParameter("uniteId")));
                contrat.setUnite(unite);

                contrat.setDateDebut(LocalDate.parse(req.getParameter("dateDebut")));
                String dateFin = req.getParameter("dateFin");
                if (dateFin != null && !dateFin.isBlank()) {
                    contrat.setDateFin(LocalDate.parse(dateFin));
                }
                contrat.setLoyerConvenu(new BigDecimal(req.getParameter("loyerConvenu")));
                String depot = req.getParameter("depotGarantie");
                if (depot != null && !depot.isBlank()) {
                    contrat.setDepotGarantie(new BigDecimal(depot));
                }
                contratService.creerContrat(contrat);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/contrats");
    }
}
