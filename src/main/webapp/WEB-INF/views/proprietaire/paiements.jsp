<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Paiements — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">💰 Suivi des Paiements</span>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>

            <%-- Compteurs rapides --%>
            <div class="stats-grid" style="margin-bottom:1.5rem">
                <div class="stat-card orange">
                    <span class="stat-icon">⏳</span>
                    <span class="stat-value">${nbEnAttente}</span>
                    <span class="stat-label">En attente</span>
                </div>
                <div class="stat-card green">
                    <span class="stat-icon">✅</span>
                    <span class="stat-value">${nbValides}</span>
                    <span class="stat-label">Validés</span>
                </div>
                <div class="stat-card red">
                    <span class="stat-icon">❌</span>
                    <span class="stat-value">${nbRejetes}</span>
                    <span class="stat-label">Rejetés</span>
                </div>
                <div class="stat-card blue">
                    <span class="stat-icon">💵</span>
                    <span class="stat-value"><fmt:formatNumber value="${totalValide}" pattern="#,##0"/> F</span>
                    <span class="stat-label">Total encaissé</span>
                </div>
            </div>

            <%-- Filtres --%>
            <div class="filter-bar">
                <input type="text" id="searchInput" placeholder="🔍 Locataire, unité..." onkeyup="filterTable()"/>
                <select id="statutFilter" onchange="filterTable()">
                    <option value="">Tous les statuts</option>
                    <option value="en_attente">En attente</option>
                    <option value="valide">Validé</option>
                    <option value="rejete">Rejeté</option>
                </select>
                <input type="month" id="moisFilter" onchange="filterTable()" title="Filtrer par mois"/>
            </div>

            <div class="card">
                <div class="card-header"><h2>Liste des paiements (${paiements.size()})</h2></div>
                <div class="table-wrap">
                    <table id="payTable">
                        <thead>
                            <tr>
                                <th>Locataire</th>
                                <th>Immeuble / Unité</th>
                                <th>Mois concerné</th>
                                <th>Montant</th>
                                <th>Mode</th>
                                <th>Date paiement</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty paiements}">
                            <tr>
                                <td colspan="8" style="text-align:center;padding:2.5rem;color:#9e9e9e">
                                    Aucun paiement enregistré.
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach var="p" items="${paiements}">
                            <tr>
                                <td>
                                    <strong>${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</strong><br>
                                    <small style="color:#9e9e9e">${p.contrat.locataire.telephone}</small>
                                </td>
                                <td>
                                    ${p.contrat.unite.immeuble.nom}<br>
                                    <small style="color:#9e9e9e">Unité ${p.contrat.unite.numero}</small>
                                </td>
                                <td>${p.moisConcerne}</td>
                                <td><strong><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F CFA</strong></td>
                                <td>${p.modePaiement}</td>
                                <td>${p.datePaiementFormattee}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.statut eq 'VALIDE'}">
                                            <span class="badge badge-green">✅ Validé</span>
                                        </c:when>
                                        <c:when test="${p.statut eq 'REJETE'}">
                                            <span class="badge badge-red">❌ Rejeté</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-orange">⏳ En attente</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${p.statut eq 'EN_ATTENTE'}">
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/proprietaire/paiements"
                                              style="display:inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="valider"/>
                                            <button type="submit" class="btn btn-success btn-sm"
                                                    title="Valider ce paiement">✅</button>
                                        </form>
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/proprietaire/paiements"
                                              style="display:inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="rejeter"/>
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                    title="Rejeter ce paiement"
                                                    onclick="return confirm('Rejeter ce paiement ?')">❌</button>
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
    const s = document.getElementById('statutFilter').value.toLowerCase();
    const m = document.getElementById('moisFilter').value;
    document.querySelectorAll('#payTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!s || t.includes(s)) && (!m || t.includes(m))) ? '' : 'none';
    });
}
</script>
</body>
</html>
