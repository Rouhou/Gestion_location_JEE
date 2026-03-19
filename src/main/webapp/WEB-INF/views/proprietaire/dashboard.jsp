<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mon Tableau de bord — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">📊 Mon tableau de bord</span>
            <span style="font-size:.85rem;color:#757575;">Bienvenue, <strong>${sessionScope.utilisateur.prenom}</strong></span>
        </div>
        <div class="page-body">

            <div class="stats-grid">
                <div class="stat-card blue">
                    <span class="stat-icon">🏗️</span>
                    <span class="stat-value">${stats.totalImmeubles}</span>
                    <span class="stat-label">Immeubles</span>
                </div>
                <div class="stat-card teal">
                    <span class="stat-icon">🚪</span>
                    <span class="stat-value">${stats.totalUnites}</span>
                    <span class="stat-label">Unités au total</span>
                </div>
                <div class="stat-card green">
                    <span class="stat-icon">✅</span>
                    <span class="stat-value">${stats.unitesOccupees}</span>
                    <span class="stat-label">Unités occupées</span>
                </div>
                <div class="stat-card orange">
                    <span class="stat-icon">🔓</span>
                    <span class="stat-value">${stats.unitesDisponibles}</span>
                    <span class="stat-label">Unités libres</span>
                </div>
                <div class="stat-card blue">
                    <span class="stat-icon">💰</span>
                    <span class="stat-value"><fmt:formatNumber value="${stats.revenusMois}" pattern="#,##0"/> F</span>
                    <span class="stat-label">Revenus ce mois</span>
                </div>
            </div>

            <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.3rem">

                <%-- Demandes en attente --%>
                <div class="card">
                    <div class="card-header">
                        <h2>📬 Demandes en attente</h2>
                        <a href="${pageContext.request.contextPath}/proprietaire/demandes" class="btn btn-outline btn-sm">Voir tout</a>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead><tr><th>Locataire</th><th>Unité</th><th>Date</th><th>Action</th></tr></thead>
                            <tbody>
                            <c:if test="${empty demandes}">
                                <tr><td colspan="4" style="text-align:center;color:#9e9e9e;padding:1.5rem">Aucune demande en attente</td></tr>
                            </c:if>
                            <c:forEach var="d" items="${demandes}">
                                <tr>
                                    <td>${d.locataire.prenom} ${d.locataire.nom}</td>
                                    <td>${d.unite.numero} — ${d.unite.immeuble.nom}</td>
                                    <td><fmt:formatDate value="${d.dateDemande}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/demandes" style="display:inline">
                                            <input type="hidden" name="id" value="${d.id}"/>
                                            <input type="hidden" name="action" value="accepter"/>
                                            <button class="btn btn-success btn-sm">✅</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/demandes" style="display:inline">
                                            <input type="hidden" name="id" value="${d.id}"/>
                                            <input type="hidden" name="action" value="refuser"/>
                                            <button class="btn btn-danger btn-sm">❌</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <%-- Paiements en attente --%>
                <div class="card">
                    <div class="card-header">
                        <h2>💳 Paiements à valider</h2>
                        <a href="${pageContext.request.contextPath}/proprietaire/paiements" class="btn btn-outline btn-sm">Voir tout</a>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead><tr><th>Locataire</th><th>Mois</th><th>Montant</th><th>Action</th></tr></thead>
                            <tbody>
                            <c:if test="${empty paiementsAttente}">
                                <tr><td colspan="4" style="text-align:center;color:#9e9e9e;padding:1.5rem">Aucun paiement en attente</td></tr>
                            </c:if>
                            <c:forEach var="p" items="${paiementsAttente}">
                                <tr>
                                    <td>${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</td>
                                    <td>${p.moisConcerne}</td>
                                    <td><strong><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</strong></td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/paiements" style="display:inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="valider"/>
                                            <button class="btn btn-success btn-sm">✅</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
