<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Nouveau contrat — GestionLoc Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Nouveau Contrat de Location</span>
            <a href="${pageContext.request.contextPath}/admin/contrats"
               class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                Retour
            </a>
        </div>

        <div class="flex-1 p-6">
            <c:if test="${not empty erreur}">
                <div class="px-4 py-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm mb-5">${erreur}</div>
            </c:if>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm max-w-2xl mx-auto">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Creer un contrat</h2>
                </div>
                <div class="p-5">
                    <form method="post" action="${pageContext.request.contextPath}/admin/contrats">
                        <div class="grid grid-cols-2 gap-4">
                            <div class="flex flex-col gap-1 col-span-2">
                                <label class="text-sm font-medium text-gray-700">Locataire *</label>
                                <select name="locataireId" required
                                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent">
                                    <option value="">-- Selectionner un locataire --</option>
                                    <c:forEach var="l" items="${locataires}">
                                        <option value="${l.id}">${l.prenom} ${l.nom} (${l.email})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="flex flex-col gap-1 col-span-2">
                                <label class="text-sm font-medium text-gray-700">Unite disponible *</label>
                                <select name="uniteId" required
                                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent">
                                    <option value="">-- Selectionner une unite --</option>
                                    <c:forEach var="u" items="${unitesDisponibles}">
                                        <option value="${u.id}">
                                            ${u.immeuble.nom} — Unite ${u.numero}
                                            (${u.nbPieces} pieces,
                                            <fmt:formatNumber value="${u.loyerMensuel}" pattern="#,##0"/> F/mois)
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Date de debut *</label>
                                <input type="date" name="dateDebut" required
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Date de fin (optionnel)</label>
                                <input type="date" name="dateFin"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Loyer convenu (F CFA) *</label>
                                <input type="number" name="loyerConvenu" required min="0" placeholder="350000"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Depot de garantie (F CFA)</label>
                                <input type="number" name="depotGarantie" min="0" placeholder="700000"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 mt-6">
                            <button type="submit"
                                    class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                                Creer le contrat
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/contrats"
                               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
