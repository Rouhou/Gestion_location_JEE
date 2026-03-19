<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Utilisateurs — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Gestion des Utilisateurs</span>
            <a href="${pageContext.request.contextPath}/admin/utilisateur/new"
               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                + Ajouter
            </a>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}">
                <div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div>
            </c:if>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100 flex-wrap gap-3">
                    <h2 class="font-semibold text-gray-800">Liste des utilisateurs</h2>
                    <div class="flex items-center gap-3">
                        <input type="text" id="searchInput" placeholder="Rechercher..."
                               onkeyup="filterTable()"
                               class="border border-gray-300 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
                        <select id="roleFilter" onchange="filterTable()"
                                class="border border-gray-300 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400">
                            <option value="">Tous les roles</option>
                            <option value="ADMIN">Admin</option>
                            <option value="PROPRIETAIRE">Proprietaire</option>
                            <option value="LOCATAIRE">Locataire</option>
                        </select>
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <table id="usersTable" class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">#</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Nom complet</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Email</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Telephone</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Role</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:forEach var="u" items="${utilisateurs}" varStatus="vs">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3 text-gray-400 text-xs">${vs.count}</td>
                                <td class="px-5 py-3 font-medium text-gray-800">${u.prenom} ${u.nom}</td>
                                <td class="px-5 py-3 text-gray-600">${u.email}</td>
                                <td class="px-5 py-3 text-gray-600">${u.telephone}</td>
                                <td class="px-5 py-3">
                                    <c:choose>
                                        <c:when test="${u.role eq 'ADMIN'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">ADMIN</span></c:when>
                                        <c:when test="${u.role eq 'PROPRIETAIRE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">PROPRIETAIRE</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-teal-100 text-teal-800">LOCATAIRE</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-3">
                                    <c:choose>
                                        <c:when test="${u.actif}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Actif</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-600">Inactif</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="flex items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/utilisateur/edit/${u.id}"
                                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                            Modifier
                                        </a>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs" class="inline">
                                            <input type="hidden" name="action" value="toggle"/>
                                            <input type="hidden" name="id" value="${u.id}"/>
                                            <button type="submit"
                                                    onclick="return confirm('Modifier le statut ?')"
                                                    class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg transition-colors
                                                    ${u.actif ? 'bg-amber-100 text-amber-700 hover:bg-amber-200' : 'bg-green-100 text-green-700 hover:bg-green-200'}">
                                                ${u.actif ? 'Desactiver' : 'Activer'}
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
    const role = document.getElementById('roleFilter').value.toLowerCase();
    document.querySelectorAll('#usersTable tbody tr').forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = (text.includes(q) && (role === '' || text.includes(role))) ? '' : 'none';
    });
}
</script>
</body>
</html>
