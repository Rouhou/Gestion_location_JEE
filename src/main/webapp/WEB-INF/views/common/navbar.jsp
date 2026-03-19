<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="sidebar">
    <div class="sidebar-brand">
        <span class="icon">🏢</span>
        <span>GestionLoc</span>
    </div>
    <nav class="sidebar-nav">
        <c:choose>
            <%-- ══ ADMIN ══ --%>
            <c:when test="${sessionScope.role eq 'ADMIN'}">
                <div class="sidebar-section">Administration</div>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="sidebar-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="nav-icon">📊</span><span>Tableau de bord</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/utilisateurs"
                   class="sidebar-link ${pageContext.request.servletPath.contains('utilisateur') ? 'active' : ''}">
                    <span class="nav-icon">👥</span><span>Utilisateurs</span>
                </a>
                <div class="sidebar-section">Gestion</div>
                <a href="${pageContext.request.contextPath}/admin/immeubles"
                   class="sidebar-link ${pageContext.request.servletPath.contains('immeuble') ? 'active' : ''}">
                    <span class="nav-icon">🏗️</span><span>Immeubles</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/contrats"
                   class="sidebar-link ${pageContext.request.servletPath.contains('contrat') ? 'active' : ''}">
                    <span class="nav-icon">📄</span><span>Contrats</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements"
                   class="sidebar-link ${pageContext.request.servletPath.contains('paiement') ? 'active' : ''}">
                    <span class="nav-icon">💰</span><span>Paiements</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/rapports"
                   class="sidebar-link ${pageContext.request.servletPath.contains('rapport') ? 'active' : ''}">
                    <span class="nav-icon">📈</span><span>Rapports</span>
                </a>
            </c:when>

            <%-- ══ PROPRIÉTAIRE ══ --%>
            <c:when test="${sessionScope.role eq 'PROPRIETAIRE'}">
                <div class="sidebar-section">Mon Patrimoine</div>
                <a href="${pageContext.request.contextPath}/proprietaire/dashboard"
                   class="sidebar-link ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                    <span class="nav-icon">📊</span><span>Tableau de bord</span>
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/immeubles"
                   class="sidebar-link ${pageContext.request.servletPath.contains('immeuble') ? 'active' : ''}">
                    <span class="nav-icon">🏗️</span><span>Mes Immeubles</span>
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/unites"
                   class="sidebar-link ${pageContext.request.servletPath.contains('unite') ? 'active' : ''}">
                    <span class="nav-icon">🚪</span><span>Unités de location</span>
                </a>
                <div class="sidebar-section">Locations</div>
                <a href="${pageContext.request.contextPath}/proprietaire/contrats"
                   class="sidebar-link ${pageContext.request.servletPath.contains('contrat') ? 'active' : ''}">
                    <span class="nav-icon">📄</span><span>Contrats</span>
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/paiements"
                   class="sidebar-link ${pageContext.request.servletPath.contains('paiement') ? 'active' : ''}">
                    <span class="nav-icon">💰</span><span>Paiements</span>
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/demandes"
                   class="sidebar-link ${pageContext.request.servletPath.contains('demande') ? 'active' : ''}">
                    <span class="nav-icon">📬</span><span>Demandes</span>
                </a>
            </c:when>

            <%-- ══ LOCATAIRE ══ --%>
            <c:otherwise>
                <div class="sidebar-section">Recherche</div>
                <a href="${pageContext.request.contextPath}/locataire/offres"
                   class="sidebar-link ${pageContext.request.servletPath.contains('offre') ? 'active' : ''}">
                    <span class="nav-icon">🔍</span><span>Offres disponibles</span>
                </a>
                <div class="sidebar-section">Mon Espace</div>
                <a href="${pageContext.request.contextPath}/locataire/mes-contrats"
                   class="sidebar-link ${pageContext.request.servletPath.contains('contrat') ? 'active' : ''}">
                    <span class="nav-icon">📄</span><span>Mes contrats</span>
                </a>
                <a href="${pageContext.request.contextPath}/locataire/mes-paiements"
                   class="sidebar-link ${pageContext.request.servletPath.contains('paiement') ? 'active' : ''}">
                    <span class="nav-icon">💸</span><span>Mes paiements</span>
                </a>
                <a href="${pageContext.request.contextPath}/locataire/mes-demandes"
                   class="sidebar-link ${pageContext.request.servletPath.contains('demande') ? 'active' : ''}">
                    <span class="nav-icon">📬</span><span>Mes demandes</span>
                </a>
            </c:otherwise>
        </c:choose>
    </nav>
    <div class="sidebar-footer">
        <div class="sidebar-user">
            <strong>${sessionScope.utilisateur.prenom} ${sessionScope.utilisateur.nom}</strong>
            ${sessionScope.role}
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm" style="width:100%;justify-content:center;">
            🚪 Déconnexion
        </a>
    </div>
</aside>
