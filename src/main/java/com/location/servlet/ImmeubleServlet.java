package com.location.servlet;

import com.location.entities.Immeuble;
import com.location.entities.Utilisateur;
import com.location.services.implementations.ImmeubleServiceImpl;
import com.location.services.serviceInterfaces.ImmeubleService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ImmeubleServlet", urlPatterns = {"/proprietaire/immeubles", "/proprietaire/immeuble/*"})
public class ImmeubleServlet extends HttpServlet {

    private ImmeubleService immeubleService;

    @Override
    public void init() {
        immeubleService = new ImmeubleServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");
        String pathInfo = req.getPathInfo();

        if ("/proprietaire/immeubles".equals(req.getServletPath())) {
            List<Immeuble> immeubles = immeubleService.findByProprietaire(u.getId());
            req.setAttribute("immeubles", immeubles);
            req.getRequestDispatcher("/WEB-INF/views/proprietaire/immeubles.jsp").forward(req, resp);
        } else if (pathInfo != null && pathInfo.startsWith("/edit/")) {
            Long id = Long.parseLong(pathInfo.replace("/edit/", ""));
            immeubleService.findById(id).ifPresent(i -> req.setAttribute("immeuble", i));
            req.getRequestDispatcher("/WEB-INF/views/proprietaire/immeuble-form.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/views/proprietaire/immeuble-form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        Utilisateur proprietaire = (Utilisateur) req.getSession().getAttribute("utilisateur");

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
            immeuble.setProprietaire(proprietaire);

            if (immeuble.getId() == null) {
                immeubleService.ajouter(immeuble);
            } else {
                immeubleService.modifier(immeuble);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/proprietaire/immeubles");
    }
}
