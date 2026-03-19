package com.location.servlet;

import com.location.entities.ContratLocation;
import com.location.entities.Utilisateur;
import com.location.services.implementations.ContratLocationServiceImpl;
import com.location.services.serviceInterfaces.ContratLocationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "LocataireContratServlet", urlPatterns = {"/locataire/mes-contrats"})
public class LocataireContratServlet extends HttpServlet {

    private ContratLocationService contratService;

    @Override
    public void init() {
        contratService = new ContratLocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");

        // Chargement des contrats avec leurs paiements (eager ou via service)
        List<ContratLocation> contrats = contratService.findByLocataireWithPaiements(u.getId());
        req.setAttribute("contrats", contrats);
        req.getRequestDispatcher("/WEB-INF/views/locataire/mes-contrats.jsp").forward(req, resp);
    }
}
