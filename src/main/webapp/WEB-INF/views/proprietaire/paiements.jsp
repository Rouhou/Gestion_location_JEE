<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Paiements — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Suivi des Paiements</span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>

            <%-- Compteurs rapides --%>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="bg-white rounded-xl border-l-4 border-l-amber-500 border border-gray-200 p-4 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${nbEnAttente}</div>
                    <div class="text-xs text-gray-500 mt-0.5">En attente</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-green-500 border border-gray-200 p-4 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${nbValides}</div>
                    <div class="text-xs text-gray-500 mt-0.5">Valides</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-red-500 border border-gray-200 p-4 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">${nbRejetes}</div>
                    <div class="text-xs text-gray-500 mt-0.5">Rejetes</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-indigo-500 border border-gray-200 p-4 shadow-sm">
                    <div class="text-2xl font-bold text-gray-800">
                        <fmt:formatNumber value="${totalValide}" pattern="#,##0"/> F
                    </div>
                    <div class="text-xs text-gray-500 mt-0.5">Total encaisse</div>
                </div>
            </div>

            <%-- Filtres --%>
            <div class="flex items-center gap-3 flex-wrap">
                <input type="text" id="searchInput" placeholder="Locataire, unite..." onkeyup="filterTable()"
                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
                <select id="statutFilter" onchange="filterTable()"
                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400">
                    <option value="">Tous les statuts</option>
                    <option value="en_attente">En attente</option>
                    <option value="valide">Valide</option>
                    <option value="rejete">Rejete</option>
                </select>
                <input type="month" id="moisFilter" onchange="filterTable()" title="Filtrer par mois"
                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
            </div>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Liste des paiements (${paiements.size()})</h2>
                </div>
                <div class="overflow-x-auto">
                    <table id="payTable" class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Locataire</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Immeuble / Unite</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mois concerne</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Montant</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mode</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date paiement</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:if test="${empty paiements}">
                            <tr><td colspan="8" class="text-center px-5 py-8 text-gray-400">Aucun paiement enregistre.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${paiements}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3">
                                    <div class="font-medium text-gray-800">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</div>
                                    <div class="text-xs text-gray-400">${p.contrat.locataire.telephone}</div>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="text-gray-800">${p.contrat.unite.immeuble.nom}</div>
                                    <div class="text-xs text-gray-400">Unite ${p.contrat.unite.numero}</div>
                                </td>
                                <td class="px-5 py-3 text-gray-600">${p.moisConcerne}</td>
                                <td class="px-5 py-3 font-semibold text-gray-800">
                                    <fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F CFA
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
                                <td class="px-5 py-3">
                                    <c:if test="${p.statut eq 'EN_ATTENTE'}">
                                        <div class="flex items-center gap-2">
                                            <form method="post" action="${pageContext.request.contextPath}/proprietaire/paiements" class="inline">
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <input type="hidden" name="action" value="valider"/>
                                                <button type="submit" class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 transition-colors">Valider</button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/proprietaire/paiements" class="inline">
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <input type="hidden" name="action" value="rejeter"/>
                                                <button type="submit" onclick="return confirm('Rejeter ce paiement ?')"
                                                        class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">Rejeter</button>
                                            </form>
                                        </div>
                                    </c:if>
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
<script>
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    const s = document.getElementById('statutFilter').value.toLowerCase();
    const m = document.getElementById('moisFilter').value;
    document.querySelectorAll('#payTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!s || t.includes(s)) && (!m || t.includes(m))) ? '' : 'none';
    });
}
</script>
</body>
</html>
