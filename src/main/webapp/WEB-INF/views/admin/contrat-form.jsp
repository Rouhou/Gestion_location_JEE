<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Nouveau contrat — GestionLoc Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">📄 Nouveau Contrat de Location</span>
            <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-outline btn-sm">← Retour</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty erreur}"><div class="alert alert-danger">⚠️ ${erreur}</div></c:if>

            <div class="card" style="max-width:720px;margin:0 auto">
                <div class="card-header"><h2>Créer un contrat</h2></div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/contrats">
                        <div class="form-grid">
                            <div class="form-group full">
                                <label>Locataire *</label>
                                <select name="locataireId" required>
                                    <option value="">-- Sélectionner un locataire --</option>
                                    <c:forEach var="l" items="${locataires}">
                                        <option value="${l.id}">${l.prenom} ${l.nom} (${l.email})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group full">
                                <label>Unité disponible *</label>
                                <select name="uniteId" required>
                                    <option value="">-- Sélectionner une unité --</option>
                                    <c:forEach var="u" items="${unitesDisponibles}">
                                        <option value="${u.id}">
                                            ${u.immeuble.nom} — Unité ${u.numero}
                                            (${u.nbPieces} pièces,
                                            <fmt:formatNumber value="${u.loyerMensuel}" pattern="#,##0"/> F/mois)
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Date de début *</label>
                                <input type="date" name="dateDebut" required/>
                            </div>
                            <div class="form-group">
                                <label>Date de fin (optionnel)</label>
                                <input type="date" name="dateFin"/>
                            </div>
                            <div class="form-group">
                                <label>Loyer convenu (F CFA) *</label>
                                <input type="number" name="loyerConvenu" required
                                       min="0" placeholder="350000"/>
                            </div>
                            <div class="form-group">
                                <label>Dépôt de garantie (F CFA)</label>
                                <input type="number" name="depotGarantie"
                                       min="0" placeholder="700000"/>
                            </div>
                        </div>
                        <div style="display:flex;gap:.8rem;margin-top:1.3rem">
                            <button type="submit" class="btn btn-primary">💾 Créer le contrat</button>
                            <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-outline">Annuler</a>
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
