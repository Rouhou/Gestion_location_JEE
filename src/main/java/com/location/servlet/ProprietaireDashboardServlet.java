package com.location.servlet;

import com.location.entities.Utilisateur;
import com.location.services.implementations.ContratLocationServiceImpl;
import com.location.services.implementations.DemandeLocationServiceImpl;
import com.location.services.implementations.ImmeubleServiceImpl;
import com.location.services.implementations.PaiementServiceImpl;
import com.location.services.implementations.UniteLocationServiceImpl;
import com.location.services.serviceInterfaces.ContratLocationService;
import com.location.services.serviceInterfaces.DemandeLocationService;
import com.location.services.serviceInterfaces.ImmeubleService;
import com.location.services.serviceInterfaces.PaiementService;
import com.location.services.serviceInterfaces.UniteLocationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "ProprietaireDashboardServlet", urlPatterns = {"/proprietaire/dashboard"})
public class ProprietaireDashboardServlet extends HttpServlet {

    private ImmeubleService        immeubleService;
    private UniteLocationService   uniteService;
    private ContratLocationService contratService;
    private PaiementService        paiementService;
    private DemandeLocationService demandeService;

    @Override
    public void init() {
        immeubleService = new ImmeubleServiceImpl();
        uniteService    = new UniteLocationServiceImpl();
        contratService  = new ContratLocationServiceImpl();
        paiementService = new PaiementServiceImpl();
        demandeService  = new DemandeLocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Utilisateur proprietaire = (Utilisateur) req.getSession().getAttribute("utilisateur");
        Long pid = proprietaire.getId();

        // ── Stats ──
        var immeubles = immeubleService.findByProprietaire(pid);
        var toutesUnites = immeubles.stream()
                .flatMap(i -> uniteService.findByImmeuble(i.getId()).stream())
                .collect(Collectors.toList());

        long unitesOccupees  = toutesUnites.stream().filter(u -> !u.isDisponible()).count();
        long unitesLibres    = toutesUnites.stream().filter(u -> u.isDisponible()).count();

        // Revenus du mois (paiements validés des contrats actifs)
        BigDecimal revenusMois = contratService.findByProprietaire(pid).stream()
                .flatMap(c -> c.getPaiements().stream())
                .filter(p -> p.getStatut().name().equals("VALIDE"))
                .map(p -> p.getMontant())
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalImmeubles",   immeubles.size());
        stats.put("totalUnites",      toutesUnites.size());
        stats.put("unitesOccupees",   unitesOccupees);
        stats.put("unitesDisponibles",unitesLibres);
        stats.put("revenusMois",      revenusMois);
        req.setAttribute("stats", stats);

        // ── Demandes en attente (5 max) ──
        var demandes = demandeService.findByProprietaire(pid);
        req.setAttribute("demandes", demandes.stream().limit(5).collect(Collectors.toList()));

        // ── Paiements en attente (5 max) ──
        var paiementsAttente = paiementService.findByProprietaire(pid).stream()
                .filter(p -> p.getStatut().name().equals("EN_ATTENTE"))
                .limit(5)
                .collect(Collectors.toList());
        req.setAttribute("paiementsAttente", paiementsAttente);

        req.getRequestDispatcher("/WEB-INF/views/proprietaire/dashboard.jsp").forward(req, resp);
    }
}
