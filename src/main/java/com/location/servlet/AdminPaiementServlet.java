package com.location.servlet;

import com.location.entities.ContratLocation;
import com.location.entities.Paiement;
import com.location.entities.Utilisateur;
import com.location.services.implementations.ContratLocationServiceImpl;
import com.location.services.implementations.PaiementServiceImpl;
import com.location.services.implementations.UtilisateurServiceImpl;
import com.location.services.serviceInterfaces.ContratLocationService;
import com.location.services.serviceInterfaces.PaiementService;
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
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "AdminPaiementServlet",
        urlPatterns = {"/admin/paiements", "/admin/paiement/*"})
public class AdminPaiementServlet extends HttpServlet {

    private PaiementService        paiementService;
    private ContratLocationService contratService;
    private UtilisateurService     utilisateurService;

    @Override
    public void init() {
        paiementService    = new PaiementServiceImpl();
        contratService     = new ContratLocationServiceImpl();
        utilisateurService = new UtilisateurServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String servletPath = req.getServletPath();
        String pathInfo    = req.getPathInfo();

        // ── Formulaire nouveau paiement : GET /admin/paiement/new ──
        if ("/admin/paiement".equals(servletPath) && "/new".equals(pathInfo)) {

            // Liste de tous les locataires pour Tom Select
            List<Utilisateur> locataires =
                    utilisateurService.findByRole(Utilisateur.RoleUtilisateur.LOCATAIRE);
            req.setAttribute("locataires", locataires);

            // Contrats actifs groupés par locataireId → alimentent le JS
            Map<Long, List<ContratLocation>> contratsParLocataire =
                    contratService.findActifs().stream()
                            .collect(Collectors.groupingBy(
                                    c -> c.getLocataire().getId()
                            ));
            req.setAttribute("contratsParLocataire", contratsParLocataire);

            req.getRequestDispatcher("/WEB-INF/views/admin/paiement-form.jsp")
               .forward(req, resp);

        // ── Liste des paiements : GET /admin/paiements ──
        } else {
            String statutParam = req.getParameter("statut");
            List<Paiement> paiements;

            if (statutParam != null && !statutParam.isBlank()) {
                try {
                    Paiement.StatutPaiement statut =
                            Paiement.StatutPaiement.valueOf(statutParam);
                    paiements = paiementService.findAllWithDetails().stream()
                            .filter(p -> p.getStatut() == statut)
                            .toList();
                } catch (IllegalArgumentException e) {
                    paiements = paiementService.findAllWithDetails();
                }
            } else {
                paiements = paiementService.findAllWithDetails();
            }

            long nbEnAttente = paiements.stream()
                    .filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_ATTENTE).count();
            long nbValides   = paiements.stream()
                    .filter(p -> p.getStatut() == Paiement.StatutPaiement.VALIDE).count();
            long nbRejetes   = paiements.stream()
                    .filter(p -> p.getStatut() == Paiement.StatutPaiement.REJETE).count();

            req.setAttribute("paiements",   paiements);
            req.setAttribute("nbEnAttente", nbEnAttente);
            req.setAttribute("nbValides",   nbValides);
            req.setAttribute("nbRejetes",   nbRejetes);
            req.setAttribute("statutActif", statutParam);

            req.getRequestDispatcher("/WEB-INF/views/admin/paiements.jsp")
               .forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        switch (action == null ? "" : action) {

            // ── Valider un paiement existant ──
            case "valider" -> {
                Long id = Long.parseLong(req.getParameter("id"));
                paiementService.valider(id);
            }

            // ── Rejeter un paiement existant ──
            case "rejeter" -> {
                Long id = Long.parseLong(req.getParameter("id"));
                paiementService.rejeter(id);
            }

            // ── Enregistrer un nouveau paiement ──
            case "enregistrer" -> {
                try {
                    Paiement paiement = new Paiement();

                    ContratLocation contrat = new ContratLocation();
                    contrat.setId(Long.parseLong(req.getParameter("contratId")));
                    paiement.setContrat(contrat);

                    paiement.setMontant(new BigDecimal(req.getParameter("montant")));
                    paiement.setDatePaiement(LocalDate.parse(req.getParameter("datePaiement")));
                    paiement.setModePaiement(req.getParameter("modePaiement"));
                    paiement.setMoisConcerne(req.getParameter("moisConcerne"));

                    paiementService.enregistrer(paiement);
                    req.getSession().setAttribute("flash_success",
                            "Paiement enregistré avec succès.");

                } catch (Exception e) {
                    req.getSession().setAttribute("flash_erreur",
                            "Erreur lors de l'enregistrement : " + e.getMessage());
                }
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/paiements");
    }
}
