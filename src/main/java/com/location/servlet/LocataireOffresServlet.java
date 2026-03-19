package com.location.servlet;

import com.location.entities.UniteLocation;
import com.location.services.implementations.UniteLocationServiceImpl;
import com.location.services.serviceInterfaces.UniteLocationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "LocataireOffresServlet", urlPatterns = {"/locataire/offres"})
public class LocataireOffresServlet extends HttpServlet {

    private UniteLocationService uniteService;

    @Override
    public void init() {
        uniteService = new UniteLocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Récupérer tous les paramètres de filtre
        String ville    = req.getParameter("ville");
        String piecesP  = req.getParameter("pieces");
        String loyerMax = req.getParameter("loyerMax");

        List<UniteLocation> unites = uniteService.findAllDisponibles();

        // Filtre ville (immeuble)
        if (ville != null && !ville.isBlank()) {
            final String v = ville.trim().toLowerCase();
            unites = unites.stream()
                    .filter(u -> u.getImmeuble().getVille().toLowerCase().contains(v))
                    .collect(Collectors.toList());
        }

        // Filtre nombre de pièces
        if (piecesP != null && !piecesP.isBlank()) {
            int pieces = Integer.parseInt(piecesP);
            if (pieces >= 4) {
                unites = unites.stream()
                        .filter(u -> u.getNbPieces() >= 4)
                        .collect(Collectors.toList());
            } else {
                unites = unites.stream()
                        .filter(u -> u.getNbPieces() == pieces)
                        .collect(Collectors.toList());
            }
        }

        // Filtre loyer maximum
        if (loyerMax != null && !loyerMax.isBlank()) {
            BigDecimal max = new BigDecimal(loyerMax);
            unites = unites.stream()
                    .filter(u -> u.getLoyerMensuel().compareTo(max) <= 0)
                    .collect(Collectors.toList());
        }

        // Message flash (après soumission d'une demande)
        String flash = (String) req.getSession().getAttribute("flash_success");
        if (flash != null) {
            req.setAttribute("message", flash);
            req.getSession().removeAttribute("flash_success");
        }

        req.setAttribute("unites", unites);
        req.getRequestDispatcher("/WEB-INF/views/locataire/offres.jsp").forward(req, resp);
    }
}
