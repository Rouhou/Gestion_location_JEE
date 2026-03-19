<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes demandes — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Mes Demandes de Location</span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>

            <c:if test="${empty demandes}">
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-12 text-center">
                    <p class="text-gray-800 font-medium mb-1">Aucune demande envoyee</p>
                    <p class="text-gray-400 text-sm mb-4">Vous n'avez encore envoye aucune demande.</p>
                    <a href="${pageContext.request.contextPath}/locataire/offres"
                       class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                        Parcourir les offres
                    </a>
                </div>
            </c:if>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Immeuble</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Unite</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Loyer</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date demande</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Message</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:forEach var="d" items="${demandes}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3">
                                    <div class="font-medium text-gray-800">${d.unite.immeuble.nom}</div>
                                    <div class="text-xs text-gray-400">${d.unite.immeuble.adresse}</div>
                                </td>
                                <td class="px-5 py-3 text-gray-600">${d.unite.numero} — ${d.unite.nbPieces} piece(s)</td>
                                <td class="px-5 py-3 font-semibold text-gray-800">
                                    <fmt:formatNumber value="${d.unite.loyerMensuel}" pattern="#,##0"/> F
                                </td>
                                <td class="px-5 py-3 text-gray-600">${d.dateDemandeFormattee}</td>
                                <td class="px-5 py-3">
                                    <c:choose>
                                        <c:when test="${d.statut eq 'ACCEPTEE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Acceptee</span></c:when>
                                        <c:when test="${d.statut eq 'REFUSEE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Refusee</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">En attente</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-5 py-3 text-gray-500 text-xs max-w-xs truncate">${d.message}</td>
                                <td class="px-5 py-3">
                                    <c:if test="${d.statut eq 'EN_ATTENTE'}">
                                        <form method="post" action="${pageContext.request.contextPath}/locataire/demandes">
                                            <input type="hidden" name="action" value="annuler"/>
                                            <input type="hidden" name="id" value="${d.id}"/>
                                            <button type="submit" onclick="return confirm('Annuler cette demande ?')"
                                                    class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">
                                                Annuler
                                            </button>
                                        </form>
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
</body>
</html>
