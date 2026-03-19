package com.location.servlet;

import com.location.entities.ContratLocation;
import com.location.entities.Immeuble;
import com.location.entities.Paiement;
import com.location.entities.Utilisateur;
import com.location.services.implementations.ContratLocationServiceImpl;
import com.location.services.implementations.ImmeubleServiceImpl;
import com.location.services.implementations.PaiementServiceImpl;
import com.location.services.implementations.UtilisateurServiceImpl;
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
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "AdminRapportServlet", urlPatterns = {"/admin/rapports"})
public class AdminRapportServlet extends HttpServlet {

    private ImmeubleService        immeubleService;
    private ContratLocationService contratService;
    private PaiementService        paiementService;
    private UtilisateurService     utilisateurService;
    private UniteLocationService   uniteService;

    @Override
    public void init() {
        immeubleService    = new ImmeubleServiceImpl();
        contratService     = new ContratLocationServiceImpl();
        paiementService    = new PaiementServiceImpl();
        utilisateurService = new UtilisateurServiceImpl();
        uniteService       = new UniteLocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ── 1. Statistiques globales ──
        Map<String, Object> statsGlobales = new HashMap<>();
        statsGlobales.put("totalImmeubles",    immeubleService.findAll().size());
        statsGlobales.put("totalUnites",       uniteService.findAll().size());
        statsGlobales.put("unitesDisponibles", uniteService.findDisponibles().size());
        statsGlobales.put("contratsActifs",    contratService.findActifs().size());
        statsGlobales.put("totalLocataires",
                utilisateurService.findByRole(Utilisateur.RoleUtilisateur.LOCATAIRE).size());
        statsGlobales.put("totalProprietaires",
                utilisateurService.findByRole(Utilisateur.RoleUtilisateur.PROPRIETAIRE).size());
        req.setAttribute("statsGlobales", statsGlobales);

        // ── 2. Revenus par mois (paiements validés groupés par moisConcerne) ──
        Map<String, BigDecimal> revenuParMois = paiementService.findAll().stream()
                .filter(p -> p.getStatut() == Paiement.StatutPaiement.VALIDE)
                .collect(Collectors.groupingBy(
                        Paiement::getMoisConcerne,
                        LinkedHashMap::new,
                        Collectors.reducing(BigDecimal.ZERO, Paiement::getMontant, BigDecimal::add)
                ));
        req.setAttribute("revenuParMois", revenuParMois);

        // ── 3. Total des revenus validés ──
        BigDecimal totalRevenus = revenuParMois.values().stream()
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        req.setAttribute("totalRevenus", totalRevenus);

        // ── 4. Taux d'occupation par immeuble ──
        List<Immeuble> immeubles = immeubleService.findAll();
        Map<String, Map<String, Object>> tauxOccupation = new LinkedHashMap<>();
        for (Immeuble imm : immeubles) {
            List<?> unites = uniteService.findByImmeuble(imm.getId());
            long total     = unites.size();
            long occupees  = unites.stream()
                    .filter(u -> !((com.location.entities.UniteLocation) u).isDisponible())
                    .count();
            double taux    = total > 0 ? (occupees * 100.0 / total) : 0.0;
            Map<String, Object> info = new HashMap<>();
            info.put("totalUnites",  total);
            info.put("unitesOccupees", occupees);
            info.put("taux", Math.round(taux));
            tauxOccupation.put(imm.getNom(), info);
        }
        req.setAttribute("tauxOccupation", tauxOccupation);

        // ── 5. Paiements en retard (EN_ATTENTE depuis > 30 jours) ──
        List<Paiement> enRetard = paiementService.findAll().stream()
                .filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_ATTENTE
                          && p.getDatePaiement() != null
                          && p.getDatePaiement().isBefore(java.time.LocalDate.now().minusDays(30)))
                .collect(Collectors.toList());
        req.setAttribute("paiementsEnRetard", enRetard);

        // ── 6. Contrats résiliés ce mois ──
        String moisActuel = java.time.YearMonth.now().toString(); // YYYY-MM
        long contratsResiliesMois = contratService.findAllWithDetails().stream()
                .filter(c -> c.getStatut() == ContratLocation.StatutContrat.RESILIE
                          && c.getDateFin() != null
                          && c.getDateFin().toString().startsWith(moisActuel))
                .count();
        req.setAttribute("contratsResiliesMois", contratsResiliesMois);

        req.getRequestDispatcher("/WEB-INF/views/admin/rapports.jsp").forward(req, resp);
    }
}
