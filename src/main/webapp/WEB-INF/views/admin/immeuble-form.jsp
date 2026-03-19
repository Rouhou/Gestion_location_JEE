<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>${empty immeuble ? 'Ajouter un immeuble' : 'Modifier immeuble'} — GestionLoc Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">
                ${empty immeuble ? 'Ajouter un immeuble' : 'Modifier l\'immeuble'}
            </span>
            <a href="${pageContext.request.contextPath}/admin/immeubles"
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
                    <h2 class="font-semibold text-gray-800">${empty immeuble ? 'Nouvel immeuble' : 'Modifier : '.concat(immeuble.nom)}</h2>
                </div>
                <div class="p-5">
                    <form method="post" action="${pageContext.request.contextPath}/admin/immeubles">
                        <c:if test="${not empty immeuble}">
                            <input type="hidden" name="id" value="${immeuble.id}"/>
                        </c:if>
                        <div class="grid grid-cols-2 gap-4">
                            <div class="flex flex-col gap-1 col-span-2">
                                <label class="text-sm font-medium text-gray-700">Nom de l'immeuble *</label>
                                <input type="text" name="nom" required placeholder="Residence Teranga" value="${immeuble.nom}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1 col-span-2">
                                <label class="text-sm font-medium text-gray-700">Adresse *</label>
                                <input type="text" name="adresse" required placeholder="Rue 10 x 23, Mermoz" value="${immeuble.adresse}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Ville *</label>
                                <input type="text" name="ville" required placeholder="Dakar" value="${immeuble.ville}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Code postal</label>
                                <input type="text" name="codePostal" placeholder="10000" value="${immeuble.codePostal}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1 col-span-2">
                                <label class="text-sm font-medium text-gray-700">Proprietaire *</label>
                                <select name="proprietaireId" required
                                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent">
                                    <option value="">-- Selectionner un proprietaire --</option>
                                    <c:forEach var="p" items="${proprietaires}">
                                        <option value="${p.id}" ${immeuble.proprietaire.id eq p.id ? 'selected' : ''}>
                                            ${p.prenom} ${p.nom} (${p.email})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="flex flex-col gap-1 col-span-2">
                                <label class="text-sm font-medium text-gray-700">Description</label>
                                <textarea name="description" rows="3" placeholder="Description de l'immeuble..."
                                          class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent resize-none">${immeuble.description}</textarea>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 mt-6">
                            <button type="submit"
                                    class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                                Enregistrer
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/immeubles"
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
