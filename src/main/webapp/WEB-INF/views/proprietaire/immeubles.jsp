<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes Immeubles — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Mes Immeubles</span>
            <a href="${pageContext.request.contextPath}/proprietaire/immeuble/new"
               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                + Ajouter un immeuble
            </a>
        </div>

        <div class="flex-1 p-6 flex flex-col gap-5">
            <c:if test="${not empty message}"><div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm">${message}</div></c:if>
            <c:if test="${not empty erreur}"><div class="px-4 py-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm">${erreur}</div></c:if>

            <c:if test="${empty immeubles}">
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm p-12 text-center">
                    <p class="text-gray-400 mb-4">Aucun immeuble enregistre pour le moment.</p>
                    <a href="${pageContext.request.contextPath}/proprietaire/immeuble/new"
                       class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                        Ajouter mon premier immeuble
                    </a>
                </div>
            </c:if>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
            <c:forEach var="imm" items="${immeubles}">
                <div class="bg-white rounded-xl border border-gray-200 shadow-sm flex flex-col">
                    <div class="flex items-start justify-between px-5 py-4 border-b border-gray-100">
                        <div>
                            <h3 class="font-semibold text-gray-800">${imm.nom}</h3>
                            <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-indigo-100 text-indigo-800 mt-1">
                                ${imm.nbUnites} unite(s)
                            </span>
                        </div>
                    </div>
                    <div class="px-5 py-4 flex-1">
                        <p class="font-medium text-gray-700 text-sm">${imm.adresse}</p>
                        <p class="text-sm text-gray-500">${imm.ville}<c:if test="${not empty imm.codePostal}"> (${imm.codePostal})</c:if></p>
                        <c:if test="${not empty imm.description}">
                            <p class="text-xs text-gray-400 italic mt-2">${imm.description}</p>
                        </c:if>
                    </div>
                    <div class="flex items-center gap-2 px-5 py-3 border-t border-gray-100">
                        <a href="${pageContext.request.contextPath}/proprietaire/unites?immeubleId=${imm.id}"
                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                            Unites
                        </a>
                        <a href="${pageContext.request.contextPath}/proprietaire/immeuble/edit/${imm.id}"
                           class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                            Modifier
                        </a>
                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/immeubles" class="ml-auto">
                            <input type="hidden" name="action" value="supprimer"/>
                            <input type="hidden" name="id" value="${imm.id}"/>
                            <button type="submit"
                                    onclick="return confirm('Supprimer cet immeuble et toutes ses unites ?')"
                                    class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">
                                Supprimer
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
