<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Rapports — GestionLoc Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .progress-bar-wrap { background:#e0e0e0; border-radius:20px; height:10px; overflow:hidden; }
        .progress-bar      { height:100%; border-radius:20px; background:var(--primary);
                             transition:width .6s ease; }
        .rapport-section   { margin-bottom:1.5rem; }
    </style>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">📈 Rapports & Statistiques</span>
            <span style="font-size:.85rem;color:#757575">Vue d'ensemble de la plateforme</span>
        </div>
        <div class="page-body">

            <%-- ══ 1. Statistiques globales ══ --%>
            <div class="rapport-section">
                <h2 style="font-size:1rem;color:#1a237e;margin-bottom:1rem">📊 Statistiques globales</h2>
                <div class="stats-grid">
                    <div class="stat-card blue">
                        <span class="stat-icon">🏗️</span>
                        <span class="stat-value">${statsGlobales.totalImmeubles}</span>
                        <span class="stat-label">Immeubles</span>
                    </div>
                    <div class="stat-card teal">
                        <span class="stat-icon">🚪</span>
                        <span class="stat-value">${statsGlobales.totalUnites}</span>
                        <span class="stat-label">Unités au total</span>
                    </div>
                    <div class="stat-card green">
                        <span class="stat-icon">🔓</span>
                        <span class="stat-value">${statsGlobales.unitesDisponibles}</span>
                        <span class="stat-label">Unités disponibles</span>
                    </div>
                    <div class="stat-card blue">
                        <span class="stat-icon">📄</span>
                        <span class="stat-value">${statsGlobales.contratsActifs}</span>
                        <span class="stat-label">Contrats actifs</span>
                    </div>
                    <div class="stat-card orange">
                        <span class="stat-icon">👤</span>
                        <span class="stat-value">${statsGlobales.totalLocataires}</span>
                        <span class="stat-label">Locataires</span>
                    </div>
                    <div class="stat-card teal">
                        <span class="stat-icon">🏠</span>
                        <span class="stat-value">${statsGlobales.totalProprietaires}</span>
                        <span class="stat-label">Propriétaires</span>
                    </div>
                </div>
            </div>

            <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.3rem">

                <%-- ══ 2. Revenus par mois ══ --%>
                <div class="card rapport-section">
                    <div class="card-header">
                        <h2>💰 Revenus validés par mois</h2>
                        <strong style="color:#1a237e">
                            Total : <fmt:formatNumber value="${totalRevenus}" pattern="#,##0"/> F CFA
                        </strong>
                    </div>
                    <div class="table-wrap">
                        <table>
                            <thead><tr><th>Mois</th><th>Montant</th></tr></thead>
                            <tbody>
                            <c:if test="${empty revenuParMois}">
                                <tr><td colspan="2" style="text-align:center;padding:1.5rem;color:#9e9e9e">Aucun paiement validé.</td></tr>
                            </c:if>
                            <c:forEach var="entry" items="${revenuParMois}">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><strong><fmt:formatNumber value="${entry.value}" pattern="#,##0"/> F CFA</strong></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <%-- ══ 3. Taux d'occupation par immeuble ══ --%>
                <div class="card rapport-section">
                    <div class="card-header"><h2>🏗️ Taux d'occupation</h2></div>
                    <div class="card-body">
                        <c:if test="${empty tauxOccupation}">
                            <p style="color:#9e9e9e;text-align:center">Aucun immeuble enregistré.</p>
                        </c:if>
                        <c:forEach var="entry" items="${tauxOccupation}">
                            <div style="margin-bottom:1rem">
                                <div style="display:flex;justify-content:space-between;margin-bottom:.3rem;font-size:.87rem">
                                    <span><strong>${entry.key}</strong></span>
                                    <span style="color:#1a237e;font-weight:700">${entry.value.taux}%</span>
                                </div>
                                <div class="progress-bar-wrap">
                                    <div class="progress-bar" style="width:${entry.value.taux}%;
                                        background:${entry.value.taux >= 80 ? '#2e7d32' : entry.value.taux >= 50 ? '#1a237e' : '#e65100'}">
                                    </div>
                                </div>
                                <div style="font-size:.78rem;color:#9e9e9e;margin-top:.2rem">
                                    ${entry.value.unitesOccupees} / ${entry.value.totalUnites} unités occupées
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <%-- ══ 4. Paiements en retard ══ --%>
            <div class="card rapport-section">
                <div class="card-header">
                    <h2>⚠️ Paiements en retard <small style="font-weight:400;color:#9e9e9e">(en attente depuis plus de 30 jours)</small></h2>
                    <span class="badge ${empty paiementsEnRetard ? 'badge-green' : 'badge-red'}">
                        ${paiementsEnRetard.size()} dossier(s)
                    </span>
                </div>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Locataire</th><th>Unité</th><th>Mois</th><th>Montant</th><th>Date paiement</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty paiementsEnRetard}">
                            <tr><td colspan="6" style="text-align:center;padding:1.5rem;color:#2e7d32">✅ Aucun paiement en retard.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${paiementsEnRetard}">
                            <tr>
                                <td><strong>${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</strong></td>
                                <td>${p.contrat.unite.immeuble.nom} — Unité ${p.contrat.unite.numero}</td>
                                <td>${p.moisConcerne}</td>
                                <td><strong><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</strong></td>
                                <td><fmt:formatDate value="${p.datePaiement}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/paiements"
                                          style="display:inline">
                                        <input type="hidden" name="id" value="${p.id}"/>
                                        <input type="hidden" name="action" value="valider"/>
                                        <button class="btn btn-success btn-sm">✅ Valider</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/paiements"
                                          style="display:inline">
                                        <input type="hidden" name="id" value="${p.id}"/>
                                        <input type="hidden" name="action" value="rejeter"/>
                                        <button class="btn btn-danger btn-sm">❌ Rejeter</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <%-- ══ 5. Résumé résiliations ══ --%>
            <div class="card rapport-section">
                <div class="card-header"><h2>📉 Résiliations ce mois</h2></div>
                <div class="card-body" style="text-align:center;padding:1.5rem">
                    <span style="font-size:2.5rem;font-weight:800;
                        color:${contratsResiliesMois > 0 ? '#c62828' : '#2e7d32'}">
                        ${contratsResiliesMois}
                    </span>
                    <p style="color:#757575;margin-top:.3rem">contrat(s) résilié(s) ce mois-ci</p>
                </div>
            </div>

        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
