package com.location.servlet;

import com.location.services.implementations.ImmeubleServiceImpl;
import com.location.services.implementations.PaiementServiceImpl;
import com.location.services.implementations.UtilisateurServiceImpl;
import com.location.services.implementations.ContratLocationServiceImpl;
import com.location.services.implementations.UniteLocationServiceImpl;
import com.location.services.serviceInterfaces.ContratLocationService;
import com.location.services.serviceInterfaces.ImmeubleService;
import com.location.services.serviceInterfaces.PaiementService;
import com.location.services.serviceInterfaces.UniteLocationService;
import com.location.services.serviceInterfaces.UtilisateurService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private UtilisateurService     utilisateurService;
    private ImmeubleService        immeubleService;
    private ContratLocationService contratService;
    private PaiementService        paiementService;
    private UniteLocationService   uniteService;

    @Override
    public void init() {
        utilisateurService = new UtilisateurServiceImpl();
        immeubleService    = new ImmeubleServiceImpl();
        contratService     = new ContratLocationServiceImpl();
        paiementService    = new PaiementServiceImpl();
        uniteService       = new UniteLocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ── Statistiques globales ──
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUtilisateurs", utilisateurService.findAll().size());
        stats.put("totalImmeubles",    immeubleService.findAll().size());
        stats.put("contratsActifs",    contratService.findActifs().size());
        stats.put("unitesDisponibles", uniteService.findDisponibles().size());

        long paiementsEnAttente = paiementService.findEnAttente().size();
        stats.put("paiementsEnAttente", paiementsEnAttente);

        req.setAttribute("stats", stats);

        // ── Derniers inscrits (5 max) ──
        var tousUtilisateurs = utilisateurService.findAll();
        int nbDerniers = Math.min(5, tousUtilisateurs.size());
        req.setAttribute("derniersUtilisateurs",
                tousUtilisateurs.subList(tousUtilisateurs.size() - nbDerniers, tousUtilisateurs.size()));

        // ── Derniers paiements (5 max) ──
        var derniersPaiements = paiementService.findDerniersAvecDetails(5);
        req.setAttribute("derniersPaiements", derniersPaiements);

        req.setAttribute("now", new java.util.Date());
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}
