<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes contrats — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar"><span class="topbar-title">📄 Mes Contrats</span></div>
        <div class="page-body">
            <c:if test="${empty contrats}">
                <div class="card" style="text-align:center;padding:3rem">
                    <p style="font-size:3rem">📄</p>
                    <p style="color:#757575">Vous n'avez aucun contrat de location actif.</p>
                    <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-primary" style="margin-top:1rem">Voir les offres disponibles</a>
                </div>
            </c:if>

            <c:forEach var="c" items="${contrats}">
            <div class="card" style="margin-bottom:1.3rem">
                <div class="card-header">
                    <h2>📍 ${c.unite.immeuble.nom} — Unité ${c.unite.numero}</h2>
                    <c:choose>
                        <c:when test="${c.statut eq 'ACTIF'}"><span class="badge badge-green">🟢 Actif</span></c:when>
                        <c:when test="${c.statut eq 'TERMINE'}"><span class="badge badge-gray">Terminé</span></c:when>
                        <c:otherwise><span class="badge badge-red">Résilié</span></c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body">
                    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(180px,1fr));gap:1rem;margin-bottom:1.2rem">
                        <div>
                            <span style="font-size:.75rem;color:#9e9e9e;text-transform:uppercase">Adresse</span>
                            <p style="font-weight:600">${c.unite.immeuble.adresse}, ${c.unite.immeuble.ville}</p>
                        </div>
                        <div>
                            <span style="font-size:.75rem;color:#9e9e9e;text-transform:uppercase">Date de début</span>
                            <p style="font-weight:600">${c.dateDebutFormattee}</p>
                        </div>
                        <div>
                            <span style="font-size:.75rem;color:#9e9e9e;text-transform:uppercase">Loyer mensuel</span>
                            <p style="font-weight:600;color:#1a237e"><fmt:formatNumber value="${c.loyerConvenu}" pattern="#,##0"/> F CFA</p>
                        </div>
                        <div>
                            <span style="font-size:.75rem;color:#9e9e9e;text-transform:uppercase">Dépôt de garantie</span>
                            <p style="font-weight:600"><fmt:formatNumber value="${c.depotGarantie}" pattern="#,##0"/> F CFA</p>
                        </div>
                    </div>

                    <%-- Historique paiements --%>
                    <h3 style="font-size:.9rem;color:#1a237e;margin-bottom:.8rem">💳 Historique des paiements</h3>
                    <c:if test="${empty c.paiements}">
                        <p style="color:#9e9e9e;font-size:.87rem">Aucun paiement enregistré.</p>
                    </c:if>
                    <div class="timeline">
                        <c:forEach var="p" items="${c.paiements}">
                            <div class="timeline-item">
                                <div class="timeline-dot ${p.statut eq 'VALIDE' ? 'green' : p.statut eq 'REJETE' ? 'red' : 'orange'}"></div>
                                <div class="timeline-content">
                                    <strong><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</strong>
                                    — ${p.moisConcerne} — ${p.modePaiement}
                                    <c:choose>
                                        <c:when test="${p.statut eq 'VALIDE'}"><span class="badge badge-green" style="font-size:.7rem">Validé</span></c:when>
                                        <c:when test="${p.statut eq 'REJETE'}"><span class="badge badge-red" style="font-size:.7rem">Rejeté</span></c:when>
                                        <c:otherwise><span class="badge badge-orange" style="font-size:.7rem">En attente</span></c:otherwise>
                                    </c:choose>
                                    <div class="timeline-date">${p.datePaiementFormattee}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- <c:if test="${c.statut eq 'ACTIF'}">
                        <a href="${pageContext.request.contextPath}/locataire/paiement/new?contratId=${c.id}" class="btn btn-primary btn-sm" style="margin-top:1rem">
                            💸 Enregistrer un paiement
                        </a>
                    </c:if> -->
                </div>
            </div>
            </c:forEach>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
