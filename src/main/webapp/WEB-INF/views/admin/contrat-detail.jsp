<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Detail contrat — GestionLoc Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Detail du Contrat #${contrat.id}</span>
            <div class="flex items-center gap-2">
                <a href="${pageContext.request.contextPath}/admin/contrats"
                   class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                    Retour
                </a>
                <c:if test="${contrat.statut eq 'ACTIF'}">
                    <form method="post" action="${pageContext.request.contextPath}/admin/contrats" class="inline">
                        <input type="hidden" name="action" value="resilier"/>
                        <input type="hidden" name="id" value="${contrat.id}"/>
                        <button class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors"
                                onclick="return confirm('Resilier ce contrat ?')">Resilier</button>
                    </form>
                </c:if>
            </div>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">

                <%-- Infos contrat --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Informations du contrat</h2>
                    </div>
                    <div class="p-5">
                        <dl class="divide-y divide-gray-50">
                            <div class="flex items-center justify-between py-2.5">
                                <dt class="text-sm text-gray-500">Statut</dt>
                                <dd>
                                    <c:choose>
                                        <c:when test="${contrat.statut eq 'ACTIF'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Actif</span></c:when>
                                        <c:when test="${contrat.statut eq 'TERMINE'}"><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-600">Termine</span></c:when>
                                        <c:otherwise><span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Resilie</span></c:otherwise>
                                    </c:choose>
                                </dd>
                            </div>
                            <div class="flex items-center justify-between py-2.5">
                                <dt class="text-sm text-gray-500">Date debut</dt>
                                <dd class="text-sm font-medium text-gray-800">${contrat.dateDebutFormattee}</dd>
                            </div>
                            <div class="flex items-center justify-between py-2.5">
                                <dt class="text-sm text-gray-500">Date fin</dt>
                                <dd class="text-sm text-gray-800">${not empty contrat.dateFinFormattee ? contrat.dateFinFormattee : '—'}</dd>
                            </div>
                            <div class="flex items-center justify-between py-2.5">
                                <dt class="text-sm text-gray-500">Loyer convenu</dt>
                                <dd class="text-sm font-bold text-indigo-700">
                                    <fmt:formatNumber value="${contrat.loyerConvenu}" pattern="#,##0"/> F CFA
                                </dd>
                            </div>
                            <div class="flex items-center justify-between py-2.5">
                                <dt class="text-sm text-gray-500">Depot de garantie</dt>
                                <dd class="text-sm text-gray-800">
                                    <fmt:formatNumber value="${contrat.depotGarantie}" pattern="#,##0"/> F CFA
                                </dd>
                            </div>
                        </dl>
                    </div>
                </div>

                <%-- Parties --%>
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                    <div class="px-5 py-4 border-b border-gray-100">
                        <h2 class="font-semibold text-gray-800">Parties concernees</h2>
                    </div>
                    <div class="p-5 flex flex-col gap-4">
                        <div>
                            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Locataire</p>
                            <p class="font-semibold text-gray-800">${contrat.locataire.prenom} ${contrat.locataire.nom}</p>
                            <p class="text-sm text-gray-500">${contrat.locataire.email}</p>
                            <p class="text-sm text-gray-500">${contrat.locataire.telephone}</p>
                        </div>
                        <hr class="border-gray-100"/>
                        <div>
                            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Unite</p>
                            <p class="font-semibold text-gray-800">${contrat.unite.immeuble.nom}
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 ml-1">Unite ${contrat.unite.numero}</span>
                            </p>
                            <p class="text-sm text-gray-500">${contrat.unite.immeuble.adresse}, ${contrat.unite.immeuble.ville}</p>
                            <p class="text-sm text-gray-500">${contrat.unite.nbPieces} pieces —
                                <fmt:formatNumber value="${contrat.unite.superficie}" pattern="#,##0.##"/> m²</p>
                        </div>
                        <hr class="border-gray-100"/>
                        <div>
                            <p class="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-1">Proprietaire</p>
                            <p class="font-semibold text-gray-800">${contrat.unite.immeuble.proprietaire.prenom} ${contrat.unite.immeuble.proprietaire.nom}</p>
                            <p class="text-sm text-gray-500">${contrat.unite.immeuble.proprietaire.email}</p>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Historique paiements --%>
            <div class="bg-white rounded-xl border border-gray-200 shadow-sm">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Historique des paiements</h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mois</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Montant</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Mode</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Date paiement</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Statut</th>
                                <th class="text-left text-xs font-semibold text-gray-500 uppercase tracking-wider px-5 py-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                        <c:if test="${empty contrat.paiements}">
                            <tr><td colspan="6" class="text-center px-5 py-8 text-gray-400">Aucun paiement enregistre.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${contrat.paiements}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="px-5 py-3 text-gray-700">${p.moisConcerne}</td>
                                <td class="px-5 py-3 font-semibold text-gray-800"><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</td>
                                <td class="px-5 py-3 text-gray-600">${p.modePaiement}</td>
                                <td class="px-5 py-3 text-gray-600"><fmt:formatDate value="${p.datePaiement}" pattern="dd/MM/yyyy"/></td>
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
                                            <form method="post" action="${pageContext.request.contextPath}/admin/paiements" class="inline">
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <input type="hidden" name="action" value="valider"/>
                                                <button class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 transition-colors">Valider</button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/paiements" class="inline">
                                                <input type="hidden" name="id" value="${p.id}"/>
                                                <input type="hidden" name="action" value="rejeter"/>
                                                <button class="inline-flex items-center px-3 py-1 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">Rejeter</button>
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
</body>
</html>
