<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Paiements — GestionLoc Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">💰 Gestion des Paiements</span>
            <a href="${pageContext.request.contextPath}/admin/paiement/new"
               class="btn btn-primary btn-sm">+ Enregistrer un paiement</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>

            <%-- Compteurs rapides --%>
            <div class="stats-grid" style="margin-bottom:1.5rem">
                <a href="${pageContext.request.contextPath}/admin/paiements" class="stat-card blue" style="text-decoration:none">
                    <span class="stat-icon">📋</span>
                    <span class="stat-value">${paiements.size()}</span>
                    <span class="stat-label">Total affiché</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements?statut=EN_ATTENTE" class="stat-card orange" style="text-decoration:none">
                    <span class="stat-icon">⏳</span>
                    <span class="stat-value">${nbEnAttente}</span>
                    <span class="stat-label">En attente</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements?statut=VALIDE" class="stat-card green" style="text-decoration:none">
                    <span class="stat-icon">✅</span>
                    <span class="stat-value">${nbValides}</span>
                    <span class="stat-label">Validés</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/paiements?statut=REJETE" class="stat-card red" style="text-decoration:none">
                    <span class="stat-icon">❌</span>
                    <span class="stat-value">${nbRejetes}</span>
                    <span class="stat-label">Rejetés</span>
                </a>
            </div>

            <%-- Filtres --%>
            <div class="filter-bar">
                <input type="text" id="searchInput" placeholder="🔍 Rechercher..." onkeyup="filterTable()"/>
                <input type="month" id="moisFilter" onchange="filterTable()" title="Filtrer par mois"/>
                <c:if test="${not empty statutActif}">
                    <a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-outline btn-sm">✕ Effacer le filtre</a>
                </c:if>
            </div>

            <div class="card">
                <div class="card-header">
                    <h2>
                        Liste des paiements
                        <c:if test="${not empty statutActif}">
                            — filtre : <span class="badge badge-orange">${statutActif}</span>
                        </c:if>
                    </h2>
                </div>
                <div class="table-wrap">
                    <table id="payTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Locataire</th>
                                <th>Unité / Immeuble</th>
                                <th>Mois</th>
                                <th>Montant</th>
                                <th>Mode</th>
                                <th>Date paiement</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty paiements}">
                            <tr><td colspan="9" style="text-align:center;padding:2rem;color:#9e9e9e">Aucun paiement trouvé.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${paiements}" varStatus="vs">
                            <tr>
                                <td>${vs.count}</td>
                                <td>
                                    <strong>${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</strong><br>
                                    <small style="color:#9e9e9e">${p.contrat.locataire.email}</small>
                                </td>
                                <td>
                                    ${p.contrat.unite.immeuble.nom}<br>
                                    <small style="color:#9e9e9e">Unité ${p.contrat.unite.numero}</small>
                                </td>
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
                                <td>
                                    <c:if test="${p.statut eq 'EN_ATTENTE'}">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/paiements"
                                              style="display:inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="valider"/>
                                            <button class="btn btn-success btn-sm">✅</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/paiements"
                                              style="display:inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="rejeter"/>
                                            <button class="btn btn-danger btn-sm">❌</button>
                                        </form>
                                    </c:if>
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
<script>
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    const m = document.getElementById('moisFilter').value;
    document.querySelectorAll('#payTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!m || t.includes(m))) ? '' : 'none';
    });
}
</script>
</body>
</html>
