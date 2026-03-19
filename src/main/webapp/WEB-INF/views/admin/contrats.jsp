<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Contrats — GestionLoc Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Gestion des Contrats</span>
            <a href="${pageContext.request.contextPath}/admin/contrat/new"
               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                + Nouveau contrat
            </a>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>

            <div class="flex items-center gap-3">
                <input type="text" id="searchInput" placeholder="Locataire, unite..." onkeyup="filterTable()"
                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
                <select id="statutFilter" onchange="filterTable()"
                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400">
                    <option value="">Tous les statuts</option>
                    <option value="actif">Actif</option>
                    <option value="termine">Termine</option>
                    <option value="resilie">Resilie</option>
                </select>
            </div>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Liste des contrats (${contrats.size()})</h2>
                </div>
                <div class="overflow-x-auto">
                    <table id="contratsTable" class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">#</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Locataire</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Immeuble / Unite</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Proprietaire</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date debut</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Loyer convenu</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:if test="${empty contrats}">
                            <tr><td colspan="8" class="text-center px-5 py-8 text-gray-400">Aucun contrat trouve.</td></tr>
                        </c:if>
                        <c:forEach var="c" items="${contrats}" varStatus="vs">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3 text-gray-400 text-xs">${vs.count}</td>
                                <td class="px-5 py-3">
                                    <div class="font-medium text-gray-800">${c.locataire.prenom} ${c.locataire.nom}</div>
                                    <div class="text-xs text-gray-400">${c.locataire.email}</div>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="text-gray-800">${c.unite.immeuble.nom}</div>
                                    <div class="text-xs text-gray-400">Unite ${c.unite.numero}</div>
                                </td>
                                <td class="px-5 py-3 text-gray-600">${c.unite.immeuble.proprietaire.prenom} ${c.unite.immeuble.proprietaire.nom}</td>
                                <td class="px-5 py-3 text-gray-600">${c.dateDebutFormattee}</td>
                                <td class="px-5 py-3 font-semibold text-gray-800">
                                    <fmt:formatNumber value="${c.loyerConvenu}" pattern="#,##0"/> F
                                </td>
                                <td class="px-5 py-3">
                                    <c:choose>
                                        <c:when test="${c.statut eq 'ACTIF'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Actif</span></c:when>
                                        <c:when test="${c.statut eq 'TERMINE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-600">Termine</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Resilie</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="flex items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/contrat/${c.id}"
                                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                            Detail
                                        </a>
                                        <c:if test="${c.statut eq 'ACTIF'}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/contrats" class="inline">
                                                <input type="hidden" name="action" value="resilier"/>
                                                <input type="hidden" name="id" value="${c.id}"/>
                                                <button type="submit" onclick="return confirm('Resilier ce contrat ?')"
                                                        class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">
                                                    Resilier
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
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
    document.querySelectorAll('#contratsTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!s || t.includes(s))) ? '' : 'none';
    });
}
</script>
</body>
</html>
