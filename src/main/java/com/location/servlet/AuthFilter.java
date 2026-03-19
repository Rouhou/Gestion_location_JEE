package com.location.servlet;

import com.location.entities.Utilisateur;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/proprietaire/*", "/locataire/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  hReq  = (HttpServletRequest)  req;
        HttpServletResponse hResp = (HttpServletResponse) resp;

        HttpSession session = hReq.getSession(false);
        Utilisateur u = (session != null) ? (Utilisateur) session.getAttribute("utilisateur") : null;

        if (u == null) {
            hResp.sendRedirect(hReq.getContextPath() + "/login");
            return;
        }

        String path = hReq.getServletPath();
        boolean authorized = switch (u.getRole()) {
            case ADMIN        -> path.startsWith("/admin") || path.startsWith("/proprietaire") || path.startsWith("/locataire");
            case PROPRIETAIRE -> path.startsWith("/proprietaire");
            case LOCATAIRE    -> path.startsWith("/locataire");
        };

        if (!authorized) {
            hResp.sendError(HttpServletResponse.SC_FORBIDDEN);
        } else {
            chain.doFilter(req, resp);
        }
    }
}
