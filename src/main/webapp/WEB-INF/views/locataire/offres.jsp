<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Offres disponibles — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Offres de location disponibles</span>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>

            <%-- Filtres --%>
            <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-5">
                <form method="get" action="${pageContext.request.contextPath}/locataire/offres">
                    <div class="flex flex-wrap items-end gap-4">
                        <div class="flex flex-col gap-1">
                            <label class="text-sm font-medium text-gray-700">Ville</label>
                            <input type="text" name="ville" placeholder="Dakar" value="${param.ville}"
                                   class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label class="text-sm font-medium text-gray-700">Nb de pieces</label>
                            <select name="pieces"
                                    class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400">
                                <option value="">Toutes</option>
                                <option value="1" ${param.pieces eq '1' ? 'selected' : ''}>1 piece</option>
                                <option value="2" ${param.pieces eq '2' ? 'selected' : ''}>2 pieces</option>
                                <option value="3" ${param.pieces eq '3' ? 'selected' : ''}>3 pieces</option>
                                <option value="4" ${param.pieces eq '4' ? 'selected' : ''}>4+ pieces</option>
                            </select>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label class="text-sm font-medium text-gray-700">Loyer max (F CFA)</label>
                            <input type="number" name="loyerMax" placeholder="500000" value="${param.loyerMax}"
                                   class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"/>
                        </div>
                        <div class="flex items-center gap-2">
                            <button type="submit"
                                    class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                                Filtrer
                            </button>
                            <a href="${pageContext.request.contextPath}/locataire/offres"
                               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                Reinitialiser
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <c:if test="${empty unites}">
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-12 text-center">
                    <p class="text-gray-800 font-medium mb-1">Aucune offre disponible</p>
                    <p class="text-gray-400 text-sm">Aucune unite ne correspond a vos criteres pour le moment.</p>
                </div>
            </c:if>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
            <c:forEach var="u" items="${unites}">
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm flex flex-col">
                    <div class="px-5 py-4 border-b border-gray-100">
                        <h3 class="font-semibold text-gray-800 text-base">${u.immeuble.nom} — Unite ${u.numero}</h3>
                        <div class="text-xl font-bold text-indigo-700 mt-1">
                            <fmt:formatNumber value="${u.loyerMensuel}" pattern="#,##0"/> F CFA
                            <span class="text-sm font-normal text-gray-400">/mois</span>
                        </div>
                    </div>
                    <div class="px-5 py-4 flex-1">
                        <div class="grid grid-cols-2 gap-3 mb-3">
                            <div>
                                <div class="text-xs text-gray-400 uppercase font-semibold">Pieces</div>
                                <div class="text-sm font-medium text-gray-700 mt-0.5">${u.nbPieces} piece(s)</div>
                            </div>
                            <div>
                                <div class="text-xs text-gray-400 uppercase font-semibold">Superficie</div>
                                <div class="text-sm font-medium text-gray-700 mt-0.5">
                                    <fmt:formatNumber value="${u.superficie}" pattern="#,##0.##"/> m²
                                </div>
                            </div>
                            <div class="col-span-2">
                                <div class="text-xs text-gray-400 uppercase font-semibold">Adresse</div>
                                <div class="text-sm font-medium text-gray-700 mt-0.5">${u.immeuble.adresse}, ${u.immeuble.ville}</div>
                            </div>
                        </div>
                        <c:if test="${not empty u.description}">
                            <p class="text-xs text-gray-400 italic">${u.description}</p>
                        </c:if>
                    </div>
                    <div class="px-5 py-4 border-t border-gray-100">
                        <form method="post" action="${pageContext.request.contextPath}/locataire/demandes">
                            <input type="hidden" name="uniteId" value="${u.id}"/>
                            <textarea name="message" rows="2" placeholder="Message au proprietaire (optionnel)..."
                                      class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm resize-none focus:outline-none focus:ring-2 focus:ring-indigo-400 mb-2"></textarea>
                            <button type="submit"
                                    class="w-full flex items-center justify-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                                Envoyer une demande
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
