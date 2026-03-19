<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes paiements — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Mes Paiements</span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>

            <div class="grid grid-cols-3 gap-4">
                <div class="bg-white rounded-xl border-l-4 border-l-green-500 border border-gray-200 p-4 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.nbValides}</div>
                    <div class="text-xs text-gray-500 mt-0.5">Paiements valides</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-amber-500 border border-gray-200 p-4 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${stats.nbEnAttente}</div>
                    <div class="text-xs text-gray-500 mt-0.5">En attente</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-indigo-500 border border-gray-200 p-4 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">
                        <fmt:formatNumber value="${stats.totalPaye}" pattern="#,##0"/> F
                    </div>
                    <div class="text-xs text-gray-500 mt-0.5">Total paye</div>
                </div>
            </div>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Historique complet</h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Unite</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mois concerne</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Montant</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mode</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:if test="${empty paiements}">
                            <tr><td colspan="6" class="text-center px-5 py-8 text-gray-400">Aucun paiement enregistre.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${paiements}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3 text-gray-700">${p.contrat.unite.numero} — ${p.contrat.unite.immeuble.nom}</td>
                                <td class="px-5 py-3 text-gray-600">${p.moisConcerne}</td>
                                <td class="px-5 py-3 font-semibold text-gray-800">
                                    <fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F
                                </td>
                                <td class="px-5 py-3 text-gray-600">${p.modePaiement}</td>
                                <td class="px-5 py-3 text-gray-600">${p.datePaiementFormattee}</td>
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
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
