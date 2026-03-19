<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Détail contrat — GestionLoc Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">📄 Détail du Contrat #${contrat.id}</span>
            <div style="display:flex;gap:.6rem">
                <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-outline btn-sm">← Retour</a>
                <c:if test="${contrat.statut eq 'ACTIF'}">
                    <form method="post" action="${pageContext.request.contextPath}/admin/contrats">
                        <input type="hidden" name="action" value="resilier"/>
                        <input type="hidden" name="id" value="${contrat.id}"/>
                        <button class="btn btn-danger btn-sm"
                                onclick="return confirm('Résilier ce contrat ?')">🚫 Résilier</button>
                    </form>
                </c:if>
            </div>
        </div>
        <div class="page-body">
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.3rem">

                <%-- Infos contrat --%>
                <div class="card">
                    <div class="card-header"><h2>📋 Informations du contrat</h2></div>
                    <div class="card-body">
                        <table style="width:100%;font-size:.9rem">
                            <tr><td style="color:#9e9e9e;padding:.4rem 0">Statut</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${contrat.statut eq 'ACTIF'}"><span class="badge badge-green">✅ Actif</span></c:when>
                                        <c:when test="${contrat.statut eq 'TERMINE'}"><span class="badge badge-gray">Terminé</span></c:when>
                                        <c:otherwise><span class="badge badge-red">🚫 Résilié</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><td style="color:#9e9e9e;padding:.4rem 0">Date début</td>
                                <td><td>${contrat.dateDebutFormattee}</td></td></tr>
                            <tr><td style="color:#9e9e9e;padding:.4rem 0">Date fin</td>
                                <td>${not empty contrat.dateDebutFormattee ? contrat.dateDebutFormattee : '—'}</td></tr>
                            <tr><td style="color:#9e9e9e;padding:.4rem 0">Loyer convenu</td>
                                <td><strong><fmt:formatNumber value="${contrat.loyerConvenu}" pattern="#,##0"/> F CFA</strong></td></tr>
                            <tr><td style="color:#9e9e9e;padding:.4rem 0">Dépôt de garantie</td>
                                <td><fmt:formatNumber value="${contrat.depotGarantie}" pattern="#,##0"/> F CFA</td></tr>
                        </table>
                    </div>
                </div>

                <%-- Parties --%>
                <div class="card">
                    <div class="card-header"><h2>👥 Parties concernées</h2></div>
                    <div class="card-body">
                        <p style="font-size:.8rem;color:#9e9e9e;text-transform:uppercase;margin-bottom:.3rem">Locataire</p>
                        <p><strong>${contrat.locataire.prenom} ${contrat.locataire.nom}</strong></p>
                        <p style="color:#9e9e9e;font-size:.85rem">${contrat.locataire.email}</p>
                        <p style="color:#9e9e9e;font-size:.85rem">${contrat.locataire.telephone}</p>
                        <hr style="margin:1rem 0;border:none;border-top:1px solid #e0e0e0"/>
                        <p style="font-size:.8rem;color:#9e9e9e;text-transform:uppercase;margin-bottom:.3rem">Unité</p>
                        <p><strong>${contrat.unite.immeuble.nom}</strong> — Unité ${contrat.unite.numero}</p>
                        <p style="color:#9e9e9e;font-size:.85rem">${contrat.unite.immeuble.adresse}, ${contrat.unite.immeuble.ville}</p>
                        <p style="color:#9e9e9e;font-size:.85rem">${contrat.unite.nbPieces} pièces — <fmt:formatNumber value="${contrat.unite.superficie}" pattern="#,##0.##"/> m²</p>
                        <hr style="margin:1rem 0;border:none;border-top:1px solid #e0e0e0"/>
                        <p style="font-size:.8rem;color:#9e9e9e;text-transform:uppercase;margin-bottom:.3rem">Propriétaire</p>
                        <p><strong>${contrat.unite.immeuble.proprietaire.prenom} ${contrat.unite.immeuble.proprietaire.nom}</strong></p>
                        <p style="color:#9e9e9e;font-size:.85rem">${contrat.unite.immeuble.proprietaire.email}</p>
                    </div>
                </div>
            </div>

            <%-- Historique paiements --%>
            <div class="card" style="margin-top:1.3rem">
                <div class="card-header"><h2>💳 Historique des paiements</h2></div>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Mois</th><th>Montant</th><th>Mode</th><th>Date paiement</th><th>Statut</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty contrat.paiements}">
                            <tr><td colspan="6" style="text-align:center;padding:1.5rem;color:#9e9e9e">Aucun paiement enregistré.</td></tr>
                        </c:if>
                        <c:forEach var="p" items="${contrat.paiements}">
                            <tr>
                                <td>${p.moisConcerne}</td>
                                <td><strong><fmt:formatNumber value="${p.montant}" pattern="#,##0"/> F</strong></td>
                                <td>${p.modePaiement}</td>
                                <td><fmt:formatDate value="${p.datePaiement}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.statut eq 'VALIDE'}"><span class="badge badge-green">✅ Validé</span></c:when>
                                        <c:when test="${p.statut eq 'REJETE'}"><span class="badge badge-red">❌ Rejeté</span></c:when>
                                        <c:otherwise><span class="badge badge-orange">⏳ En attente</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${p.statut eq 'EN_ATTENTE'}">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/paiements" style="display:inline">
                                            <input type="hidden" name="id" value="${p.id}"/>
                                            <input type="hidden" name="action" value="valider"/>
                                            <button class="btn btn-success btn-sm">✅</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/paiements" style="display:inline">
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
</body>
</html>
