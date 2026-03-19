<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>${empty utilisateur ? 'Ajouter un utilisateur' : 'Modifier utilisateur'} — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">
                ${empty utilisateur ? '👤 Ajouter un utilisateur' : '✏️ Modifier : '.concat(utilisateur.prenom).concat(' ').concat(utilisateur.nom)}
            </span>
            <a href="${pageContext.request.contextPath}/admin/utilisateurs"
               class="btn btn-outline btn-sm">← Retour</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty erreur}">
                <div class="alert alert-danger">⚠️ ${erreur}</div>
            </c:if>

            <div class="card" style="max-width:640px;margin:0 auto">
                <div class="card-header">
                    <h2>
                        ${empty utilisateur ? 'Nouvel utilisateur' : 'Modifier le compte'}
                    </h2>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs">

                        <%-- ID caché pour le mode édition --%>
                        <c:if test="${not empty utilisateur}">
                            <input type="hidden" name="id" value="${utilisateur.id}"/>
                        </c:if>

                        <div class="form-grid">
                            <div class="form-group">
                                <label>Prénom *</label>
                                <input type="text" name="prenom" required
                                       placeholder="Fatou"
                                       value="${utilisateur.prenom}"/>
                            </div>
                            <div class="form-group">
                                <label>Nom *</label>
                                <input type="text" name="nom" required
                                       placeholder="Sarr"
                                       value="${utilisateur.nom}"/>
                            </div>
                            <div class="form-group full">
                                <label>Adresse email *</label>
                                <input type="email" name="email" required
                                       placeholder="fsarr@email.sn"
                                       value="${utilisateur.email}"/>
                            </div>
                            <div class="form-group">
                                <label>Téléphone</label>
                                <input type="tel" name="telephone"
                                       placeholder="77 000 00 00"
                                       value="${utilisateur.telephone}"/>
                            </div>
                            <div class="form-group">
                                <label>Rôle *</label>
                                <select name="role" required>
                                    <option value="">-- Sélectionner --</option>
                                    <option value="ADMIN"
                                        ${utilisateur.role eq 'ADMIN' ? 'selected' : ''}>
                                        Admin
                                    </option>
                                    <option value="PROPRIETAIRE"
                                        ${utilisateur.role eq 'PROPRIETAIRE' ? 'selected' : ''}>
                                        Propriétaire
                                    </option>
                                    <option value="LOCATAIRE"
                                        ${utilisateur.role eq 'LOCATAIRE' ? 'selected' : ''}>
                                        Locataire
                                    </option>
                                </select>
                            </div>

                            <%-- Mot de passe uniquement à la création --%>
                            <c:if test="${empty utilisateur}">
                                <div class="form-group">
                                    <label>Mot de passe *</label>
                                    <input type="password" name="password" required
                                           placeholder="••••••••"/>
                                </div>
                                <div class="form-group">
                                    <label>Confirmer *</label>
                                    <input type="password" name="passwordConfirm" required
                                           placeholder="••••••••"/>
                                </div>
                            </c:if>

                            <%-- Statut uniquement en mode édition --%>
                            <c:if test="${not empty utilisateur}">
                                <div class="form-group full">
                                    <label>Statut du compte</label>
                                    <div style="display:flex;align-items:center;gap:1rem;margin-top:.3rem">
                                        <c:choose>
                                            <c:when test="${utilisateur.actif}">
                                                <span class="badge badge-green" style="font-size:.85rem">✅ Compte actif</span>
                                                <form method="post"
                                                      action="${pageContext.request.contextPath}/admin/utilisateurs"
                                                      style="display:inline">
                                                    <input type="hidden" name="action" value="toggle"/>
                                                    <input type="hidden" name="id"     value="${utilisateur.id}"/>
                                                    <button type="submit" class="btn btn-warn btn-sm"
                                                            onclick="return confirm('Désactiver ce compte ?')">
                                                        🚫 Désactiver
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-gray" style="font-size:.85rem">🚫 Compte inactif</span>
                                                <form method="post"
                                                      action="${pageContext.request.contextPath}/admin/utilisateurs"
                                                      style="display:inline">
                                                    <input type="hidden" name="action" value="toggle"/>
                                                    <input type="hidden" name="id"     value="${utilisateur.id}"/>
                                                    <button type="submit" class="btn btn-success btn-sm"
                                                            onclick="return confirm('Activer ce compte ?')">
                                                        ✅ Activer
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <div style="display:flex;gap:.8rem;margin-top:1.5rem">
                            <button type="submit" class="btn btn-primary">
                                💾 ${empty utilisateur ? 'Créer le compte' : 'Enregistrer les modifications'}
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/utilisateurs"
                               class="btn btn-outline">Annuler</a>
                        </div>
                    </form>

                    <%-- Zone suppression (édition seulement) --%>
                    <c:if test="${not empty utilisateur}">
                        <hr style="margin:1.5rem 0;border:none;border-top:1px solid #ffcdd2"/>
                        <div style="display:flex;align-items:center;justify-content:space-between">
                            <div>
                                <p style="font-weight:600;color:#c62828;font-size:.9rem">Zone dangereuse</p>
                                <p style="font-size:.82rem;color:#9e9e9e">
                                    La suppression est irréversible et supprime toutes les données liées.
                                </p>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs">
                                <input type="hidden" name="action" value="supprimer"/>
                                <input type="hidden" name="id"     value="${utilisateur.id}"/>
                                <button type="submit" class="btn btn-danger btn-sm"
                                        onclick="return confirm('Supprimer définitivement ${utilisateur.prenom} ${utilisateur.nom} ?')">
                                    🗑️ Supprimer le compte
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
// Validation confirmation mot de passe (création uniquement)
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
