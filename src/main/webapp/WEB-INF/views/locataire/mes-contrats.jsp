<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes contrats — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Mes Contrats</span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">

            <c:if test="${empty contrats}">
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-12 text-center">
                    <p class="text-gray-800 font-medium mb-1">Aucun contrat de location actif</p>
                    <p class="text-gray-400 text-sm mb-4">Vous n'avez aucun contrat de location pour le moment.</p>
                    <a href="${pageContext.request.contextPath}/locataire/offres"
                       class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                        Voir les offres disponibles
                    </a>
                </div>
            </c:if>

            <c:forEach var="c" items="${contrats}">
            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="flex items-center justify-between px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">${c.unite.immeuble.nom} — Unite ${c.unite.numero}</h2>
                    <c:choose>
                        <c:when test="${c.statut eq 'ACTIF'}"><span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">Actif</span></c:when>
                        <c:when test="${c.statut eq 'TERMINE'}"><span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-600">Termine</span></c:when>
                        <c:otherwise><span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-red-100 text-red-800">Resilie</span></c:otherwise>
                    </c:choose>
                </div>
                <div class="p-5">
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-5">
                        <div>
                            <div class="text-xs text-gray-400 uppercase font-semibold">Adresse</div>
                            <p class="text-sm font-medium text-gray-700 mt-0.5">${c.unite.immeuble.adresse}, ${c.unite.immeuble.ville}</p>
                        </div>
                        <div>
                            <div class="text-xs text-gray-400 uppercase font-semibold">Date de debut</div>
                            <p class="text-sm font-medium text-gray-700 mt-0.5">${c.dateDebutFormattee}</p>
                        </div>
                        <div>
                            <div class="text-xs text-gray-400 uppercase font-semibold">Loyer mensuel</div>
                            <p class="text-sm font-bold text-indigo-700 mt-0.5">
                                <fmt:formatNumber value="${c.loyerConvenu}" pattern="#,##0"/> F CFA
                            </p>
                        </div>
                        <div>
                            <div class="text-xs text-gray-400 uppercase font-semibold">Depot de garantie</div>
                            <p class="text-sm font-medium text-gray-700 mt-0.5">
                                <fmt:formatNumber value="${c.depotGarantie}" pattern="#,##0"/> F CFA
                            </p>
                        </div>
                    </div>

                    <%-- Historique paiements --%>
                    <h3 class="text-sm font-semibold text-indigo-700 mb-3">Historique des paiements</h3>
                    <c:if test="${empty c.paiements}">
                        <p class="text-sm text-gray-400">Aucun paiement enregistre.</p>
                    </c:if>
                    <div class="flex flex-col gap-2">
                        <c:forEach var="p" items="${c.paiements}">
                            <div class="flex items-center gap-3 p-3 rounded-lg bg-gray-50 border border-gray-100">
                                <div class="w-2 h-2 rounded-full shrink-0
                                    ${p.statut eq 'VALIDE' ? 'bg-green-500' : p.statut eq 'REJETE' ? 'bg-red-500' : 'bg-amber-500'}">
                                </div>
                                <div class="flex-1 text-sm">
                                    <span class="font-semibold text-gray-800">
                                        <fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F
                                    </span>
                                    <span class="text-gray-400 mx-1">—</span>
                                    <span class="text-gray-600">${p.moisConcerne}</span>
                                    <span class="text-gray-400 mx-1">—</span>
                                    <span class="text-gray-600">${p.modePaiement}</span>
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${p.statut eq 'VALIDE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Valide</span></c:when>
                                        <c:when test="${p.statut eq 'REJETE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Rejete</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">En attente</span></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-xs text-gray-400">${p.datePaiementFormattee}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
