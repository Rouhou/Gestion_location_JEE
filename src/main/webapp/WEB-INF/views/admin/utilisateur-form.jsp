<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>${empty utilisateur ? 'Ajouter un utilisateur' : 'Modifier utilisateur'} — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">
                ${empty utilisateur ? 'Ajouter un utilisateur' : 'Modifier : '.concat(utilisateur.prenom).concat(' ').concat(utilisateur.nom)}
            </span>
            <a href="${pageContext.request.contextPath}/admin/utilisateurs"
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
                    <h2 class="font-semibold text-gray-800">
                        ${empty utilisateur ? 'Nouvel utilisateur' : 'Modifier le compte'}
                    </h2>
                </div>
                <div class="p-5">
                    <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs">
                        <c:if test="${not empty utilisateur}">
                            <input type="hidden" name="id" value="${utilisateur.id}"/>
                        </c:if>

                        <div class="grid grid-cols-2 gap-4">
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Prenom *</label>
                                <input type="text" name="prenom" required placeholder="Fatou" value="${utilisateur.prenom}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Nom *</label>
                                <input type="text" name="nom" required placeholder="Sarr" value="${utilisateur.nom}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1 col-span-2">
                                <label class="text-sm font-medium text-gray-700">Adresse email *</label>
                                <input type="email" name="email" required placeholder="fsarr@email.sn" value="${utilisateur.email}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Telephone</label>
                                <input type="tel" name="telephone" placeholder="77 000 00 00" value="${utilisateur.telephone}"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>
                            <div class="flex flex-col gap-1">
                                <label class="text-sm font-medium text-gray-700">Role *</label>
                                <select name="role" required class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent">
                                    <option value="">-- Selectionner --</option>
                                    <option value="ADMIN" ${utilisateur.role eq 'ADMIN' ? 'selected' : ''}>Admin</option>
                                    <option value="PROPRIETAIRE" ${utilisateur.role eq 'PROPRIETAIRE' ? 'selected' : ''}>Proprietaire</option>
                                    <option value="LOCATAIRE" ${utilisateur.role eq 'LOCATAIRE' ? 'selected' : ''}>Locataire</option>
                                </select>
                            </div>

                            <c:if test="${empty utilisateur}">
                                <div class="flex flex-col gap-1">
                                    <label class="text-sm font-medium text-gray-700">Mot de passe *</label>
                                    <input type="password" name="password" required placeholder="••••••••"
                                           class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                                </div>
                                <div class="flex flex-col gap-1">
                                    <label class="text-sm font-medium text-gray-700">Confirmer *</label>
                                    <input type="password" name="passwordConfirm" required placeholder="••••••••"
                                           class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                                </div>
                            </c:if>

                            <c:if test="${not empty utilisateur}">
                                <div class="col-span-2">
                                    <p class="text-sm font-medium text-gray-700 mb-2">Statut du compte</p>
                                    <div class="flex items-center gap-3">
                                        <c:choose>
                                            <c:when test="${utilisateur.actif}">
                                                <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">Compte actif</span>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs" class="inline">
                                                    <input type="hidden" name="action" value="toggle"/>
                                                    <input type="hidden" name="id" value="${utilisateur.id}"/>
                                                    <button type="submit" onclick="return confirm('Desactiver ce compte ?')"
                                                            class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-amber-100 text-amber-700 hover:bg-amber-200 transition-colors">
                                                        Desactiver
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-600">Compte inactif</span>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs" class="inline">
                                                    <input type="hidden" name="action" value="toggle"/>
                                                    <input type="hidden" name="id" value="${utilisateur.id}"/>
                                                    <button type="submit" onclick="return confirm('Activer ce compte ?')"
                                                            class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-green-100 text-green-700 hover:bg-green-200 transition-colors">
                                                        Activer
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <div class="flex items-center gap-3 mt-6">
                            <button type="submit"
                                    class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                                ${empty utilisateur ? 'Creer le compte' : 'Enregistrer les modifications'}
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/utilisateurs"
                               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                Annuler
                            </a>
                        </div>
                    </form>

                    <c:if test="${not empty utilisateur}">
                        <div class="mt-6 pt-6 border-t border-red-100 flex items-center justify-between">
                            <div>
                                <p class="font-semibold text-red-700 text-sm">Zone dangereuse</p>
                                <p class="text-xs text-gray-400 mt-0.5">La suppression est irreversible et supprime toutes les donnees liees.</p>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs">
                                <input type="hidden" name="action" value="supprimer"/>
                                <input type="hidden" name="id" value="${utilisateur.id}"/>
                                <button type="submit"
                                        onclick="return confirm('Supprimer definitivement ${utilisateur.prenom} ${utilisateur.nom} ?')"
                                        class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 transition-colors">
                                    Supprimer le compte
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
<script>
document.querySelector('form').addEventListener('submit', function(e) {
    const pwd     = document.querySelector('[name="password"]');
    const confirm = document.querySelector('[name="passwordConfirm"]');
    if (pwd && confirm && pwd.value !== confirm.value) {
        e.preventDefault();
        alert('Les mots de passe ne correspondent pas.');
        confirm.focus();
    }
});
</script>
</body>
</html>
