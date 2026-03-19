<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Unités de location — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">🚪 Unités — ${immeuble.nom}</span>
            <div style="display:flex;gap:.6rem">
                <a href="${pageContext.request.contextPath}/proprietaire/immeubles" class="btn btn-outline btn-sm">← Immeubles</a>
                <a href="${pageContext.request.contextPath}/proprietaire/unite/new?immeubleId=${immeuble.id}" class="btn btn-primary btn-sm">+ Ajouter une unité</a>
            </div>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>

            <div class="card">
                <div class="card-header"><h2>Liste des unités (${unites.size()})</h2></div>
                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr><th>Numéro</th><th>Pièces</th><th>Superficie</th><th>Loyer mensuel</th><th>Disponibilité</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty unites}">
                            <tr><td colspan="6" style="text-align:center;padding:2rem;color:#9e9e9e">Aucune unité dans cet immeuble.</td></tr>
                        </c:if>
                        <c:forEach var="u" items="${unites}">
                            <tr>
                                <td><strong>${u.numero}</strong></td>
                                <td>${u.nbPieces} pièce(s)</td>
                                <td><fmt:formatNumber value="${u.superficie}" pattern="#,##0.##"/> m²</td>
                                <td><strong><fmt:formatNumber value="${u.loyerMensuel}" pattern="#,##0"/> F CFA</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.disponible}"><span class="badge badge-green">🟢 Disponible</span></c:when>
                                        <c:otherwise><span class="badge badge-red">🔴 Occupée</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/proprietaire/unite/edit/${u.id}" class="btn btn-outline btn-sm">✏️ Modifier</a>
                                    <form method="post" action="${pageContext.request.contextPath}/proprietaire/unites" style="display:inline">
                                        <input type="hidden" name="action" value="supprimer"/>
                                        <input type="hidden" name="id" value="${u.id}"/>
                                        <input type="hidden" name="immeubleId" value="${immeuble.id}"/>
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Supprimer cette unité ?')">🗑️</button>
                                    </form>
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
