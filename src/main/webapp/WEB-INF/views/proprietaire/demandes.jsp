<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Demandes de location — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Demandes de Location</span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>
            <c:if test="${not empty erreur}"><div class="px-4 py-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm">${erreur}</div></c:if>

            <%-- Compteurs --%>
            <div class="grid grid-cols-3 gap-4">
                <div class="bg-white rounded-xl border-l-4 border-l-amber-500 border border-gray-200 p-4 shadow-sm">
                    <c:set var="nbAttente" value="0"/>
                    <c:forEach var="d" items="${demandes}">
                        <c:if test="${d.statut eq 'EN_ATTENTE'}"><c:set var="nbAttente" value="${nbAttente + 1}"/></c:if>
                    </c:forEach>
                    <div class="text-2xl font-bold text-gray-800">${nbAttente}</div>
                    <div class="text-xs text-gray-500 mt-0.5">En attente</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-green-500 border border-gray-200 p-4 shadow-sm">
                    <c:set var="nbAcceptees" value="0"/>
                    <c:forEach var="d" items="${demandes}">
                        <c:if test="${d.statut eq 'ACCEPTEE'}"><c:set var="nbAcceptees" value="${nbAcceptees + 1}"/></c:if>
                    </c:forEach>
                    <div class="text-2xl font-bold text-gray-800">${nbAcceptees}</div>
                    <div class="text-xs text-gray-500 mt-0.5">Acceptees</div>
                </div>
                <div class="bg-white rounded-xl border-l-4 border-l-red-500 border border-gray-200 p-4 shadow-sm">
                    <c:set var="nbRefusees" value="0"/>
                    <c:forEach var="d" items="${demandes}">
                        <c:if test="${d.statut eq 'REFUSEE'}"><c:set var="nbRefusees" value="${nbRefusees + 1}"/></c:if>
                    </c:forEach>
                    <div class="text-2xl font-bold text-gray-800">${nbRefusees}</div>
                    <div class="text-xs text-gray-500 mt-0.5">Refusees</div>
                </div>
            </div>

            <%-- Filtres --%>
            <div class="flex items-center gap-3">
                <select id="statutFilter" onchange="filterTable()"
                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400">
                    <option value="">Tous les statuts</option>
                    <option value="en_attente">En attente</option>
                    <option value="acceptee">Acceptee</option>
                    <option value="refusee">Refusee</option>
                </select>
                <input type="text" id="searchInput" placeholder="Locataire, unite..." onkeyup="filterTable()"
                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
            </div>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Liste des demandes (${demandes.size()})</h2>
                </div>

                <c:if test="${empty demandes}">
                    <div class="text-center py-12 text-gray-400">
                        <p class="text-lg mb-1">Aucune demande recue</p>
                        <p class="text-sm">Les demandes de location apparaitront ici</p>
                    </div>
                </c:if>

                <div class="overflow-x-auto">
                    <table id="demandesTable" class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Locataire</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Immeuble / Unite</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Loyer</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Message</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date demande</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:forEach var="d" items="${demandes}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3">
                                    <div class="font-medium text-gray-800">${d.locataire.prenom} ${d.locataire.nom}</div>
                                    <div class="text-xs text-gray-400">${d.locataire.email}</div>
                                    <div class="text-xs text-gray-400">${d.locataire.telephone}</div>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="font-medium text-gray-800">${d.unite.immeuble.nom}</div>
                                    <div class="text-xs text-gray-400">Unite ${d.unite.numero} — ${d.unite.nbPieces} pieces</div>
                                </td>
                                <td class="px-5 py-3 font-semibold text-indigo-700">
                                    <fmt:formatNumber value="${d.unite.loyerMensuel}" pattern="#,##0"/> F
                                </td>
                                <td class="px-5 py-3 text-gray-600 max-w-xs">
                                    <c:choose>
                                        <c:when test="${not empty d.message}">
                                            <span title="${d.message}" class="cursor-help truncate block max-w-xs">
                                                ${d.message.length() > 40 ? d.message.substring(0,40).concat('...') : d.message}
                                            </span>
                                        </c:when>
                                        <c:otherwise><span class="text-gray-300">—</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="text-gray-700">${d.dateDemandeFormattee}</div>
                                    <div class="text-xs text-gray-400">${d.heureDemandeFormattee}</div>
                                </td>
                                <td class="px-5 py-3">
                                    <c:choose>
                                        <c:when test="${d.statut eq 'EN_ATTENTE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">En attente</span></c:when>
                                        <c:when test="${d.statut eq 'ACCEPTEE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Acceptee</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Refusee</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-3">
                                    <c:if test="${d.statut eq 'EN_ATTENTE'}">
                                        <div class="flex flex-col gap-1">
                                            <form method="post" action="${pageContext.request.contextPath}/proprietaire/demandes" class="inline">
                                                <input type="hidden" name="id" value="${d.id}"/>
                                                <input type="hidden" name="action" value="accepter"/>
                                                <button type="submit"
                                                        onclick="return confirm('Accepter la demande de ${d.locataire.prenom} ${d.locataire.nom} ?')"
                                                        class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 transition-colors">
                                                    Accepter
                                                </button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/proprietaire/demandes" class="inline">
                                                <input type="hidden" name="id" value="${d.id}"/>
                                                <input type="hidden" name="action" value="refuser"/>
                                                <button type="submit" onclick="return confirm('Refuser cette demande ?')"
                                                        class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">
                                                    Refuser
                                                </button>
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
    document.querySelectorAll('#demandesTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!s || t.includes(s))) ? '' : 'none';
    });
}
</script>
</body>
</html>
