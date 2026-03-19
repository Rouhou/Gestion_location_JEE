<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Tableau de bord Admin — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <%-- Topbar --%>
        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Tableau de bord</span>
            <span class="text-sm text-gray-400">
                <fmt:formatDate value="${now}" pattern="EEEE dd MMMM yyyy"/>
            </span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">

            <%-- Stats --%>
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4">
                <div class="bg-white rounded-xl border-l-4 border-l-blue-500 border border-gray-200 p-5 flex flex-col gap-1 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.totalUtilisateurs}</div>
                    <div class="text-sm text-gray-500">Utilisateurs</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-teal-500 border border-gray-200 p-5 flex flex-col gap-1 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.totalImmeubles}</div>
                    <div class="text-sm text-gray-500">Immeubles</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-green-500 border border-gray-200 p-5 flex flex-col gap-1 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.contratsActifs}</div>
                    <div class="text-sm text-gray-500">Contrats actifs</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-amber-500 border border-gray-200 p-5 flex flex-col gap-1 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">
                        <fmt:formatNumber value="${stats.paiementsEnAttente}" pattern="#,##0"/> F
                    </div>
                    <div class="text-sm text-gray-500">Paiements en attente</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-red-500 border border-gray-200 p-5 flex flex-col gap-1 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.unitesDisponibles}</div>
                    <div class="text-sm text-gray-500">Unites disponibles</div>
                </div>
            </div>

            <%-- Deux colonnes --%>
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">

                <%-- Derniers utilisateurs --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Derniers inscrits</h2>
                        <a href="${pageContext.request.contextPath}/admin/utilisateurs"
                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                            Voir tout
                        </a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Nom</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Role</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                            <c:forEach var="u" items="${derniersUtilisateurs}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-5 py-3">
                                        <div class="font-medium text-gray-800">${u.prenom} ${u.nom}</div>
                                        <div class="text-xs text-gray-400">${u.email}</div>
                                    </td>
                                    <td class="px-5 py-3">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">${u.role}</span>
                                    </td>
                                    <td class="px-5 py-3">
                                        <c:choose>
                                            <c:when test="${u.actif}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Actif</span></c:when>
                                            <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-600">Inactif</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <%-- Paiements recents --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Paiements recents</h2>
                        <a href="${pageContext.request.contextPath}/admin/paiements"
                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                            Voir tout
                        </a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Locataire</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Montant</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                            <c:forEach var="p" items="${derniersPaiements}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-5 py-3">
                                        <div class="font-medium text-gray-800">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</div>
                                        <div class="text-xs text-gray-400">${p.moisConcerne}</div>
                                    </td>
                                    <td class="px-5 py-3 font-semibold text-gray-800">
                                        <fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F
                                    </td>
                                    <td class="px-5 py-3">
                                        <c:choose>
                                            <c:when test="${p.statut eq 'VALIDE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Valide</span></c:when>
                                            <c:when test="${p.statut eq 'REJETE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Rejete</span></c:when>
                                            <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">En attente</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
