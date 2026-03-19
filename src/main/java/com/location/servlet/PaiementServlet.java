package com.location.servlet;

import com.location.entities.ContratLocation;
import com.location.entities.Paiement;
import com.location.entities.Utilisateur;
import com.location.services.implementations.ContratLocationServiceImpl;
import com.location.services.implementations.PaiementServiceImpl;
import com.location.services.serviceInterfaces.ContratLocationService;
import com.location.services.serviceInterfaces.PaiementService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "PaiementServlet",
        urlPatterns = {"/proprietaire/paiements", "/locataire/mes-paiements", "/locataire/paiement/*"})
public class PaiementServlet extends HttpServlet {

    private PaiementService         paiementService;
    private ContratLocationService  contratService;

    @Override
    public void init() {
        paiementService = new PaiementServiceImpl();
        contratService  = new ContratLocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String servletPath = req.getServletPath();
        String pathInfo    = req.getPathInfo();
        Utilisateur u      = (Utilisateur) req.getSession().getAttribute("utilisateur");

        switch (servletPath) {

            // ── Propriétaire : tous les paiements de ses contrats ──
            case "/proprietaire/paiements" -> {
                List<Paiement> paiements = paiementService.findByProprietaire(u.getId());
                req.setAttribute("paiements", paiements);
                req.getRequestDispatcher("/WEB-INF/views/proprietaire/paiements.jsp").forward(req, resp);
            }

            // // ── Locataire : son historique ──
            case "/locataire/mes-paiements" -> {
                List<Paiement> paiements = paiementService.findByLocataire(u.getId());
                req.setAttribute("paiements", paiements);
                req.setAttribute("stats", paiementService.getStatsLocataire(u.getId()));
                req.getRequestDispatcher("/WEB-INF/views/locataire/mes-paiements.jsp").forward(req, resp);
            }

            // ── Locataire : formulaire nouveau paiement ──
            default -> {
                if (pathInfo != null && pathInfo.equals("/new")) {
                    String contratId = req.getParameter("contratId");
                    if (contratId != null) {
                        contratService.findById(Long.parseLong(contratId))
                                .ifPresent(c -> req.setAttribute("contrat", c));
                    }
                    // Tous les contrats actifs du locataire pour le select
                    req.setAttribute("contratsActifs",
                            contratService.findByLocataire(u.getId()));
                    req.getRequestDispatcher("/WEB-INF/views/locataire/paiement-form.jsp").forward(req, resp);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String servletPath = req.getServletPath();
        String action      = req.getParameter("action");

        // ── Propriétaire : valider / rejeter ──
        if ("/proprietaire/paiements".equals(servletPath)) {
            Long id = Long.parseLong(req.getParameter("id"));
            if ("valider".equals(action)) {
                paiementService.valider(id);
            } else if ("rejeter".equals(action)) {
                paiementService.rejeter(id);
            }
            resp.sendRedirect(req.getContextPath() + "/proprietaire/paiements");

        // ── Locataire : enregistrer un nouveau paiement ──
        } else {
            Paiement paiement = new Paiement();

            ContratLocation contrat = new ContratLocation();
            contrat.setId(Long.parseLong(req.getParameter("contratId")));
            paiement.setContrat(contrat);

            paiement.setMontant(new BigDecimal(req.getParameter("montant")));
            paiement.setDatePaiement(LocalDate.parse(req.getParameter("datePaiement")));
            paiement.setModePaiement(req.getParameter("modePaiement"));
            paiement.setMoisConcerne(req.getParameter("moisConcerne"));

            paiementService.enregistrer(paiement);
            resp.sendRedirect(req.getContextPath() + "/locataire/mes-paiements");
        }
    }
}
