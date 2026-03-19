<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Rapports — GestionLoc Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Rapports &amp; Statistiques</span>
            <span class="text-sm text-gray-400">Vue d'ensemble de la plateforme</span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">

            <%-- 1. Statistiques globales --%>
            <div>
                <h2 class="text-sm font-semibold text-indigo-700 uppercase tracking-wider mb-3">Statistiques globales</h2>
                <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
                    <div class="bg-white rounded-xl border-l-4 border-l-blue-500 border border-gray-200 p-4 shadow-sm">
                        <div class="text-2xl font-bold text-gray-800">${statsGlobales.totalImmeubles}</div>
                        <div class="text-xs text-gray-500 mt-0.5">Immeubles</div>
                    </div>
                    <div class="bg-white rounded-xl border-l-4 border-l-teal-500 border border-gray-200 p-4 shadow-sm">
                        <div class="text-2xl font-bold text-gray-800">${statsGlobales.totalUnites}</div>
                        <div class="text-xs text-gray-500 mt-0.5">Unites au total</div>
                    </div>
                    <div class="bg-white rounded-xl border-l-4 border-l-green-500 border border-gray-200 p-4 shadow-sm">
                        <div class="text-2xl font-bold text-gray-800">${statsGlobales.unitesDisponibles}</div>
                        <div class="text-xs text-gray-500 mt-0.5">Unites disponibles</div>
                    </div>
                    <div class="bg-white rounded-xl border-l-4 border-l-indigo-500 border border-gray-200 p-4 shadow-sm">
                        <div class="text-2xl font-bold text-gray-800">${statsGlobales.contratsActifs}</div>
                        <div class="text-xs text-gray-500 mt-0.5">Contrats actifs</div>
                    </div>
                    <div class="bg-white rounded-xl border-l-4 border-l-amber-500 border border-gray-200 p-4 shadow-sm">
                        <div class="text-2xl font-bold text-gray-800">${statsGlobales.totalLocataires}</div>
                        <div class="text-xs text-gray-500 mt-0.5">Locataires</div>
                    </div>
                    <div class="bg-white rounded-xl border-l-4 border-l-purple-500 border border-gray-200 p-4 shadow-sm">
                        <div class="text-2xl font-bold text-gray-800">${statsGlobales.totalProprietaires}</div>
                        <div class="text-xs text-gray-500 mt-0.5">Proprietaires</div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">

                <%-- 2. Revenus par mois --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Revenus valides par mois</h2>
                        <span class="text-sm font-bold text-indigo-700">
                            Total : <fmt:formatNumber value="${totalRevenus}" pattern="#,##0"/> F CFA
                        </span>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mois</th>
                                    <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Montant</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                            <c:if test="${empty revenuParMois}">
                                <tr><td colspan="2" class="text-center px-5 py-8 text-gray-400">Aucun paiement valide.</td></tr>
                            </c:if>
                            <c:forEach var="entry" items="${revenuParMois}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-5 py-3 text-gray-700">${entry.key}</td>
                                    <td class="px-5 py-3 font-semibold text-gray-800">
                                        <fmt:formatNumber value="${entry.value}" pattern="#,##0"/> F CFA
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <%-- 3. Taux d'occupation --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Taux d'occupation par immeuble</h2>
                    </div>
                    <div class="p-5 flex flex-col gap-4">
                        <c:if test="${empty tauxOccupation}">
                            <p class="text-gray-400 text-center py-4">Aucun immeuble enregistre.</p>
                        </c:if>
                        <c:forEach var="entry" items="${tauxOccupation}">
                            <div>
                                <div class="flex items-center justify-between mb-1.5 text-sm">
                                    <span class="font-medium text-gray-700">${entry.key}</span>
                                    <span class="font-bold text-indigo-700">${entry.value.taux}%</span>
                                </div>
                                <div class="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                                    <div class="h-2 rounded-full transition-all duration-500"
                                         style="width:${entry.value.taux}%;
                                         background-color:${entry.value.taux >= 80 ? '#16a34a' : entry.value.taux >= 50 ? '#4f46e5' : '#ea580c'}">
                                    </div>
                                </div>
                                <div class="text-xs text-gray-400 mt-1">
                                    ${entry.value.unitesOccupees} / ${entry.value.totalUnites} unites occupees
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>

            <%-- 4. Paiements en retard --%>
            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                    <div>
                        <h2 class="font-semibold text-gray-800">Paiements en retard
                            <span class="text-xs font-normal text-gray-400">(en attente depuis plus de 30 jours)</span>
                        </h2>
                    </div>
                    <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${empty paiementsEnRetard ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                        ${paiementsEnRetard.size()} dossier(s)
                    </span>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Locataire</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Unite</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mois</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Montant</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date paiement</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:if test="${empty paiementsEnRetard}">
                            <tr><td colspan="6" class="text-center px-5 py-6 text-green-700 text-sm">Aucun paiement en retard.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${paiementsEnRetard}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3 font-medium text-gray-800">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</td>
                                <td class="px-5 py-3 text-gray-600">${p.contrat.unite.immeuble.nom} — Unite ${p.contrat.unite.numero}</td>
                                <td class="px-5 py-3 text-gray-600">${p.moisConcerne}</td>
                                <td class="px-5 py-3 font-semibold text-gray-800"><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</td>
                                <td class="px-5 py-3 text-gray-600"><fmt:formatDate value="${p.datePaiement}" pattern="dd/MM/yyyy"/></td>
                                <td class="px-5 py-3">
                                    <div class="flex items-center gap-2">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/paiements" class="inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="valider"/>
                                            <button class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 transition-colors">Valider</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/paiements" class="inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="rejeter"/>
                                            <button class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">Rejeter</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <%-- 5. Resiliations ce mois --%>
            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Resiliations ce mois</h2>
                </div>
                <div class="p-8 text-center">
                    <div class="text-5xl font-extrabold ${contratsResiliesMois > 0 ? 'text-red-600' : 'text-green-600'}">
                        ${contratsResiliesMois}
                    </div>
                    <p class="text-sm text-gray-400 mt-2">contrat(s) resilie(s) ce mois-ci</p>
                </div>
            </div>

        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
