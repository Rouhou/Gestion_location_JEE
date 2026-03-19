<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Immeubles — GestionLoc Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Gestion des Immeubles</span>
            <a href="${pageContext.request.contextPath}/admin/immeuble/new"
               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                + Ajouter
            </a>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>
            <c:if test="${not empty erreur}"><div class="px-4 py-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm">${erreur}</div></c:if>

            <%-- Filtres --%>
            <div class="flex items-center gap-3">
                <input type="text" id="searchInput" placeholder="Rechercher..." onkeyup="filterTable()"
                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
                <select id="villeFilter" onchange="filterTable()"
                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400">
                    <option value="">Toutes les villes</option>
                    <c:forEach var="imm" items="${immeubles}">
                        <option value="${imm.ville}">${imm.ville}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Liste des immeubles (${immeubles.size()})</h2>
                </div>
                <div class="overflow-x-auto">
                    <table id="immeublesTable" class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">#</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Nom</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Adresse</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Ville</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Proprietaire</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Unites</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:if test="${empty immeubles}">
                            <tr><td colspan="7" class="text-center px-5 py-8 text-gray-400">Aucun immeuble enregistre.</td></tr>
                        </c:if>
                        <c:forEach var="imm" items="${immeubles}" varStatus="vs">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3 text-gray-400 text-xs">${vs.count}</td>
                                <td class="px-5 py-3 font-medium text-gray-800">${imm.nom}</td>
                                <td class="px-5 py-3 text-gray-600">${imm.adresse}</td>
                                <td class="px-5 py-3 text-gray-600">${imm.ville}</td>
                                <td class="px-5 py-3 text-gray-600">
                                    <c:if test="${not empty imm.proprietaire}">
                                        ${imm.proprietaire.prenom} ${imm.proprietaire.nom}
                                    </c:if>
                                </td>
                                <td class="px-5 py-3">
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">${imm.nbUnites}</span>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="flex items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/immeuble/edit/${imm.id}"
                                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                            Modifier
                                        </a>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/immeubles" class="inline">
                                            <input type="hidden" name="action" value="supprimer"/>
                                            <input type="hidden" name="id" value="${imm.id}"/>
                                            <button type="submit"
                                                    onclick="return confirm('Supprimer cet immeuble et toutes ses unites ?')"
                                                    class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">
                                                Supprimer
                                            </button>
                                        </form>
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
    const v = document.getElementById('villeFilter').value.toLowerCase();
    document.querySelectorAll('#immeublesTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!v || t.includes(v))) ? '' : 'none';
    });
}
</script>
</body>
</html>
