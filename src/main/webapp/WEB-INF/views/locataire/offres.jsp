<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Offres disponibles — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">🔍 Offres de location disponibles</span>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>

            <%-- Filtres --%>
            <div class="card" style="margin-bottom:1.3rem">
                <div class="card-body">
                    <form method="get" action="${pageContext.request.contextPath}/locataire/offres">
                        <div style="display:flex;gap:.8rem;flex-wrap:wrap;align-items:flex-end">
                            <div class="form-group" style="margin-bottom:0">
                                <label>Ville</label>
                                <input type="text" name="ville" placeholder="Dakar" value="${param.ville}"/>
                            </div>
                            <div class="form-group" style="margin-bottom:0">
                                <label>Nb de pièces</label>
                                <select name="pieces">
                                    <option value="">Toutes</option>
                                    <option value="1" ${param.pieces eq '1' ? 'selected' : ''}>1 pièce</option>
                                    <option value="2" ${param.pieces eq '2' ? 'selected' : ''}>2 pièces</option>
                                    <option value="3" ${param.pieces eq '3' ? 'selected' : ''}>3 pièces</option>
                                    <option value="4" ${param.pieces eq '4' ? 'selected' : ''}>4+ pièces</option>
                                </select>
                            </div>
                            <div class="form-group" style="margin-bottom:0">
                                <label>Loyer max (F CFA)</label>
                                <input type="number" name="loyerMax" placeholder="500000" value="${param.loyerMax}"/>
                            </div>
                            <button type="submit" class="btn btn-primary">🔍 Filtrer</button>
                            <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-outline">Réinitialiser</a>
                        </div>
                    </form>
                </div>
            </div>

            <c:if test="${empty unites}">
                <div class="card" style="text-align:center;padding:3rem">
                    <p style="font-size:3rem">🏠</p>
                    <p style="color:#757575">Aucune offre disponible pour le moment.</p>
                </div>
            </c:if>

            <div class="offre-grid">
            <c:forEach var="u" items="${unites}">
                <div class="offre-card">
                    <div class="offre-card-top">
                        <h3>${u.immeuble.nom} — Unité ${u.numero}</h3>
                        <div class="offre-price"><fmt:formatNumber value="${u.loyerMensuel}" pattern="#,##0"/> F CFA<span style="font-size:.75rem;font-weight:400">/mois</span></div>
                    </div>
                    <div class="offre-card-body">
                        <div class="offre-meta">
                            <div class="offre-meta-item">
                                <span class="offre-meta-label">Pièces</span>
                                <span class="offre-meta-value">🛏️ ${u.nbPieces} pièce(s)</span>
                            </div>
                            <div class="offre-meta-item">
                                <span class="offre-meta-label">Superficie</span>
                                <span class="offre-meta-value">📐 <fmt:formatNumber value="${u.superficie}" pattern="#,##0.##"/> m²</span>
                            </div>
                            <div class="offre-meta-item" style="grid-column:1/-1">
                                <span class="offre-meta-label">Adresse</span>
                                <span class="offre-meta-value">📍 ${u.immeuble.adresse}, ${u.immeuble.ville}</span>
                            </div>
                        </div>
                        <c:if test="${not empty u.description}">
                            <p style="font-size:.82rem;color:#757575;font-style:italic">${u.description}</p>
                        </c:if>
                        <form method="post" action="${pageContext.request.contextPath}/locataire/demandes" style="margin-top:.8rem">
                            <input type="hidden" name="uniteId" value="${u.id}"/>
                            <textarea name="message" rows="2" placeholder="Message au propriétaire (optionnel)..."
                                      style="width:100%;margin-bottom:.5rem;padding:.5rem;border:1.5px solid #e0e0e0;border-radius:6px;font-size:.82rem;resize:vertical"></textarea>
                            <button type="submit" class="btn btn-primary btn-full">📬 Envoyer une demande</button>
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
