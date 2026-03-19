<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Unites de location — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Unites — ${immeuble.nom}</span>
            <div class="flex items-center gap-2">
                <a href="${pageContext.request.contextPath}/proprietaire/immeubles"
                   class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                    Immeubles
                </a>
                <a href="${pageContext.request.contextPath}/proprietaire/unite/new?immeubleId=${immeuble.id}"
                   class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                    + Ajouter une unite
                </a>
            </div>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Liste des unites (${unites.size()})</h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Numero</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Pieces</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Superficie</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Loyer mensuel</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Disponibilite</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:if test="${empty unites}">
                            <tr><td colspan="6" class="text-center px-5 py-8 text-gray-400">Aucune unite dans cet immeuble.</td></tr>
                        </c:if>
                        <c:forEach var="u" items="${unites}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3 font-medium text-gray-800">${u.numero}</td>
                                <td class="px-5 py-3 text-gray-600">${u.nbPieces} piece(s)</td>
                                <td class="px-5 py-3 text-gray-600">
                                    <fmt:formatNumber value="${u.superficie}" pattern="#,##0.##"/> m²
                                </td>
                                <td class="px-5 py-3 font-semibold text-gray-800">
                                    <fmt:formatNumber value="${u.loyerMensuel}" pattern="#,##0"/> F CFA
                                </td>
                                <td class="px-5 py-3">
                                    <c:choose>
                                        <c:when test="${u.disponible}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Disponible</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Occupee</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-3">
                                    <div class="flex items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/proprietaire/unite/edit/${u.id}"
                                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                            Modifier
                                        </a>
                                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/unites" class="inline">
                                            <input type="hidden" name="action" value="supprimer"/>
                                            <input type="hidden" name="id" value="${u.id}"/>
                                            <input type="hidden" name="immeubleId" value="${immeuble.id}"/>
                                            <button type="submit"
                                                    onclick="return confirm('Supprimer cette unite ?')"
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
</body>
</html>
