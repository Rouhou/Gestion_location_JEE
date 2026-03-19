<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes paiements — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <!-- <div class="topbar">
            <span class="topbar-title">💸 Mes Paiements</span>
            <a href="${pageContext.request.contextPath}/locataire/paiement/new" class="btn btn-primary btn-sm">+ Nouveau paiement</a>
        </div> -->
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>

            <div class="stats-grid" style="margin-bottom:1.5rem">
                <div class="stat-card green">
                    <span class="stat-icon">✅</span>
                    <span class="stat-value">${stats.nbValides}</span>
                    <span class="stat-label">Paiements validés</span>
                </div>
                <div class="stat-card orange">
                    <span class="stat-icon">⏳</span>
                    <span class="stat-value">${stats.nbEnAttente}</span>
                    <span class="stat-label">En attente</span>
                </div>
                <div class="stat-card blue">
                    <span class="stat-icon">💰</span>
                    <span class="stat-value"><fmt:formatNumber value="${stats.totalPaye}" pattern="#,##0"/> F</span>
                    <span class="stat-label">Total payé</span>
                </div>
            </div>

            <div class="card">
                <div class="card-header"><h2>Historique complet</h2></div>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Unité</th><th>Mois concerné</th><th>Montant</th><th>Mode</th><th>Date</th><th>Statut</th></tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty paiements}">
                            <tr><td colspan="6" style="text-align:center;padding:2rem;color:#9e9e9e">Aucun paiement enregistré.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${paiements}">
                            <tr>
                                <td>${p.contrat.unite.numero} — ${p.contrat.unite.immeuble.nom}</td>
                                <td>${p.moisConcerne}</td>
                                <td><strong><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</strong></td>
                                <td>${p.modePaiement}</td>
                                <td>${p.datePaiementFormattee}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.statut eq 'VALIDE'}"><span class="badge badge-green">✅ Validé</span></c:when>
                                        <c:when test="${p.statut eq 'REJETE'}"><span class="badge badge-red">❌ Rejeté</span></c:when>
                                        <c:otherwise><span class="badge badge-orange">⏳ En attente</span></c:otherwise>
                                    </c:choose>
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
