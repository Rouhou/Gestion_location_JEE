<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>${empty immeuble ? 'Ajouter un immeuble' : 'Modifier immeuble'} — GestionLoc Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">
                ${empty immeuble ? 'Ajouter un immeuble' : 'Modifier l\'immeuble'}
            </span>
            <a href="${pageContext.request.contextPath}/admin/immeubles" class="btn btn-outline btn-sm">← Retour</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty erreur}"><div class="alert alert-danger">${erreur}</div></c:if>

            <div class="card" style="max-width:720px;margin:0 auto">
                <div class="card-header">
                    <h2>${empty immeuble ? 'Nouvel immeuble' : 'Modifier : '.concat(immeuble.nom)}</h2>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/immeubles">
                        <c:if test="${not empty immeuble}">
                            <input type="hidden" name="id" value="${immeuble.id}"/>
                        </c:if>
                        <div class="form-grid">
                            <div class="form-group full">
                                <label>Nom de l'immeuble *</label>
                                <input type="text" name="nom" required
                                       placeholder="Résidence Téranga" value="${immeuble.nom}"/>
                            </div>
                            <div class="form-group full">
                                <label>Adresse *</label>
                                <input type="text" name="adresse" required
                                       placeholder="Rue 10 x 23, Mermoz" value="${immeuble.adresse}"/>
                            </div>
                            <div class="form-group">
                                <label>Ville *</label>
                                <input type="text" name="ville" required
                                       placeholder="Dakar" value="${immeuble.ville}"/>
                            </div>
                            <div class="form-group">
                                <label>Code postal</label>
                                <input type="text" name="codePostal"
                                       placeholder="10000" value="${immeuble.codePostal}"/>
                            </div>
                            <div class="form-group full">
                                <label>Propriétaire *</label>
                                <select name="proprietaireId" required>
                                    <option value="">-- Sélectionner un propriétaire --</option>
                                    <c:forEach var="p" items="${proprietaires}">
                                        <option value="${p.id}"
                                            ${immeuble.proprietaire.id eq p.id ? 'selected' : ''}>
                                            ${p.prenom} ${p.nom} (${p.email})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group full">
                                <label>Description</label>
                                <textarea name="description"
                                          placeholder="Description de l'immeuble...">${immeuble.description}</textarea>
                            </div>
                        </div>
                        <div style="display:flex;gap:.8rem;margin-top:1.3rem">
                            <button type="submit" class="btn btn-primary">💾 Enregistrer</button>
                            <a href="${pageContext.request.contextPath}/admin/immeubles" class="btn btn-outline">Annuler</a>
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
