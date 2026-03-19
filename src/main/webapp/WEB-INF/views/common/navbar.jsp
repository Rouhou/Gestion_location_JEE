<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="w-64 bg-indigo-900 text-white flex flex-col shrink-0 h-screen sticky top-0 overflow-y-auto">
    <div class="px-5 py-5 flex items-center gap-2 border-b border-indigo-800">
        <span class="font-bold text-lg tracking-tight">GestionLoc</span>
    </div>
    <nav class="flex-1 py-4 px-3 flex flex-col gap-0.5">
        <c:choose>
            <%-- ADMIN --%>
            <c:when test="${sessionScope.role eq 'ADMIN'}">
                <div class="text-xs font-semibold text-indigo-400 uppercase tracking-wider px-3 py-2 mt-1">Administration</div>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('dashboard') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Tableau de bord
                </a>
                <a href="${pageContext.request.contextPath}/admin/utilisateurs"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('utilisateur') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Utilisateurs
                </a>
                <div class="text-xs font-semibold text-indigo-400 uppercase tracking-wider px-3 py-2 mt-3">Gestion</div>
                <a href="${pageContext.request.contextPath}/admin/immeubles"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('immeuble') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Immeubles
                </a>
                <a href="${pageContext.request.contextPath}/admin/contrats"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('contrat') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Contrats
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('paiement') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Paiements
                </a>
                <a href="${pageContext.request.contextPath}/admin/rapports"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('rapport') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Rapports
                </a>
            </c:when>

            <%-- PROPRIETAIRE --%>
            <c:when test="${sessionScope.role eq 'PROPRIETAIRE'}">
                <div class="text-xs font-semibold text-indigo-400 uppercase tracking-wider px-3 py-2 mt-1">Mon Patrimoine</div>
                <a href="${pageContext.request.contextPath}/proprietaire/dashboard"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('dashboard') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Tableau de bord
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/immeubles"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('immeuble') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Mes Immeubles
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/unites"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('unite') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Unites de location
                </a>
                <div class="text-xs font-semibold text-indigo-400 uppercase tracking-wider px-3 py-2 mt-3">Locations</div>
                <a href="${pageContext.request.contextPath}/proprietaire/contrats"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('contrat') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Contrats
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/paiements"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('paiement') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Paiements
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/demandes"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('demande') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Demandes
                </a>
            </c:when>

            <%-- LOCATAIRE --%>
            <c:otherwise>
                <div class="text-xs font-semibold text-indigo-400 uppercase tracking-wider px-3 py-2 mt-1">Recherche</div>
                <a href="${pageContext.request.contextPath}/locataire/offres"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('offre') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Offres disponibles
                </a>
                <div class="text-xs font-semibold text-indigo-400 uppercase tracking-wider px-3 py-2 mt-3">Mon Espace</div>
                <a href="${pageContext.request.contextPath}/locataire/mes-contrats"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('contrat') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Mes contrats
                </a>
                <a href="${pageContext.request.contextPath}/locataire/mes-paiements"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('paiement') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Mes paiements
                </a>
                <a href="${pageContext.request.contextPath}/locataire/mes-demandes"
                   class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors
                   ${pageContext.request.servletPath.contains('demande') ? 'bg-indigo-700 text-white font-medium' : 'text-indigo-200 hover:bg-indigo-800 hover:text-white'}">
                    Mes demandes
                </a>
            </c:otherwise>
        </c:choose>
    </nav>
    <div class="px-4 py-4 border-t border-indigo-800 shrink-0">
        <p class="text-sm font-semibold text-white truncate">${sessionScope.utilisateur.prenom} ${sessionScope.utilisateur.nom}</p>
        <p class="text-xs text-indigo-300 mb-3">${sessionScope.role}</p>
        <a href="${pageContext.request.contextPath}/logout"
           class="block text-center px-4 py-2 rounded-lg border border-indigo-600 text-indigo-200 hover:bg-indigo-800 hover:text-white text-sm transition-colors">
            Deconnexion
        </a>
    </div>
</aside>
