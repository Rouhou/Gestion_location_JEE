<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mon Tableau de bord — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Mon tableau de bord</span>
            <span class="text-sm text-gray-400">Bienvenue, <strong class="text-gray-700">${sessionScope.utilisateur.prenom}</strong></span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">

            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4">
                <div class="bg-white rounded-xl border-l-4 border-l-blue-500 border border-gray-200 p-5 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.totalImmeubles}</div>
                    <div class="text-sm text-gray-500 mt-0.5">Immeubles</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-teal-500 border border-gray-200 p-5 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.totalUnites}</div>
                    <div class="text-sm text-gray-500 mt-0.5">Unites au total</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-green-500 border border-gray-200 p-5 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.unitesOccupees}</div>
                    <div class="text-sm text-gray-500 mt-0.5">Unites occupees</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-amber-500 border border-gray-200 p-5 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.unitesDisponibles}</div>
                    <div class="text-sm text-gray-500 mt-0.5">Unites libres</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-indigo-500 border border-gray-200 p-5 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">
                        <fmt:formatNumber value="${stats.revenusMois}" pattern="#,##0"/> F
                    </div>
                    <div class="text-sm text-gray-500 mt-0.5">Revenus ce mois</div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">

                <%-- Demandes en attente --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Demandes en attente</h2>
                        <a href="${pageContext.request.contextPath}/proprietaire/demandes"
                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                            Voir tout
                        </a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Locataire</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Unite</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                            <c:if test="${empty demandes}">
                                <tr><td colspan="4" class="text-center px-5 py-6 text-gray-400">Aucune demande en attente</td></tr>
                            </c:if>
                            <c:forEach var="d" items="${demandes}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-5 py-3 text-gray-800">${d.locataire.prenom} ${d.locataire.nom}</td>
                                    <td class="px-5 py-3 text-gray-600">${d.unite.numero} — ${d.unite.immeuble.nom}</td>
                                    <td class="px-5 py-3 text-gray-500 text-xs">
                                        <fmt:formatDate value="${d.dateDemande}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td class="px-5 py-3">
                                        <div class="flex items-center gap-2">
                                            <form method="post" action="${pageContext.request.contextPath}/proprietaire/demandes" class="inline">
                                                <input type="hidden" name="id" value="${d.id}"/>
                                                <input type="hidden" name="action" value="accepter"/>
                                                <button class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 transition-colors">Accepter</button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/proprietaire/demandes" class="inline">
                                                <input type="hidden" name="id" value="${d.id}"/>
                                                <input type="hidden" name="action" value="refuser"/>
                                                <button class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">Refuser</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <%-- Paiements en attente --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Paiements a valider</h2>
                        <a href="${pageContext.request.contextPath}/proprietaire/paiements"
                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                            Voir tout
                        </a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Locataire</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mois</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Montant</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                            <c:if test="${empty paiementsAttente}">
                                <tr><td colspan="4" class="text-center px-5 py-6 text-gray-400">Aucun paiement en attente</td></tr>
                            </c:if>
                            <c:forEach var="p" items="${paiementsAttente}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-5 py-3 text-gray-800">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</td>
                                    <td class="px-5 py-3 text-gray-600">${p.moisConcerne}</td>
                                    <td class="px-5 py-3 font-semibold text-gray-800">
                                        <fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F
                                    </td>
                                    <td class="px-5 py-3">
                                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/paiements" class="inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="valider"/>
                                            <button class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 transition-colors">Valider</button>
                                        </form>
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
