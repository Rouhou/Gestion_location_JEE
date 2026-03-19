<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes demandes — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar"><span class="topbar-title">📬 Mes Demandes de Location</span></div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>

            <c:if test="${empty demandes}">
                <div class="card" style="text-align:center;padding:3rem">
                    <p style="font-size:3rem">📬</p>
                    <p style="color:#757575">Vous n'avez encore envoyé aucune demande.</p>
                    <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-primary" style="margin-top:1rem">Parcourir les offres</a>
                </div>
            </c:if>

            <div class="card">
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Immeuble</th><th>Unité</th><th>Loyer</th><th>Date demande</th><th>Statut</th><th>Message</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="d" items="${demandes}">
                            <tr>
                                <td><strong>${d.unite.immeuble.nom}</strong><br><small style="color:#9e9e9e">${d.unite.immeuble.adresse}</small></td>
                                <td>${d.unite.numero} — ${d.unite.nbPieces} pièce(s)</td>
                                <td><fmt:formatNumber value="${d.unite.loyerMensuel}" pattern="#,##0"/> F</td>
                                <td>${d.dateDemandeFormattee}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.statut eq 'ACCEPTEE'}"><span class="badge badge-green">✅ Acceptée</span></c:when>
                                        <c:when test="${d.statut eq 'REFUSEE'}"><span class="badge badge-red">❌ Refusée</span></c:when>
                                        <c:otherwise><span class="badge badge-orange">⏳ En attente</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${d.message}</td>
                                <td>
                                    <c:if test="${d.statut eq 'EN_ATTENTE'}">
                                        <form method="post" action="${pageContext.request.contextPath}/locataire/demandes">
                                            <input type="hidden" name="action" value="annuler"/>
                                            <input type="hidden" name="id" value="${d.id}"/>
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Annuler cette demande ?')">Annuler</button>
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
