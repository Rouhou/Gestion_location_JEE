<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Tableau de bord Admin — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">📊 Tableau de bord</span>
            <div class="topbar-actions">
                <span style="font-size:.85rem;color:#757575;">
                    <fmt:formatDate value="${now}" pattern="EEEE dd MMMM yyyy"/>
                </span>
            </div>
        </div>
        <div class="page-body">

            <%-- Stats --%>
            <div class="stats-grid">
                <div class="stat-card blue">
                    <span class="stat-icon">👥</span>
                    <span class="stat-value">${stats.totalUtilisateurs}</span>
                    <span class="stat-label">Utilisateurs</span>
                </div>
                <div class="stat-card teal">
                    <span class="stat-icon">🏗️</span>
                    <span class="stat-value">${stats.totalImmeubles}</span>
                    <span class="stat-label">Immeubles</span>
                </div>
                <div class="stat-card green">
                    <span class="stat-icon">📄</span>
                    <span class="stat-value">${stats.contratsActifs}</span>
                    <span class="stat-label">Contrats actifs</span>
                </div>
                <div class="stat-card orange">
                    <span class="stat-icon">💰</span>
                    <span class="stat-value"><fmt:formatNumber value="${stats.paiementsEnAttente}" pattern="#,##0"/> F</span>
                    <span class="stat-label">Paiements en attente</span>
                </div>
                <div class="stat-card red">
                    <span class="stat-icon">🚪</span>
                    <span class="stat-value">${stats.unitesDisponibles}</span>
                    <span class="stat-label">Unités disponibles</span>
                </div>
            </div>

            <%-- Deux colonnes --%>
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.3rem">

                <%-- Derniers utilisateurs --%>
                <div class="card">
                    <div class="card-header">
                        <h2>👤 Derniers inscrits</h2>
                        <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="btn btn-outline btn-sm">Voir tout</a>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead><tr><th>Nom</th><th>Rôle</th><th>Statut</th></tr></thead>
                            <tbody>
                            <c:forEach var="u" items="${derniersUtilisateurs}">
                                <tr>
                                    <td>${u.prenom} ${u.nom}<br><small style="color:#9e9e9e">${u.email}</small></td>
                                    <td><span class="badge badge-blue">${u.role}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.actif}"><span class="badge badge-green">Actif</span></c:when>
                                            <c:otherwise><span class="badge badge-red">Inactif</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <%-- Paiements récents --%>
                <div class="card">
                    <div class="card-header">
                        <h2>💳 Paiements récents</h2>
                        <a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-outline btn-sm">Voir tout</a>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead><tr><th>Locataire</th><th>Montant</th><th>Statut</th></tr></thead>
                            <tbody>
                            <c:forEach var="p" items="${derniersPaiements}">
                                <tr>
                                    <td>${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}<br>
                                        <small style="color:#9e9e9e">${p.moisConcerne}</small></td>
                                    <td><strong><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.statut eq 'VALIDE'}"><span class="badge badge-green">Validé</span></c:when>
                                            <c:when test="${p.statut eq 'REJETE'}"><span class="badge badge-red">Rejeté</span></c:when>
                                            <c:otherwise><span class="badge badge-orange">En attente</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div><!-- /page-body -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
