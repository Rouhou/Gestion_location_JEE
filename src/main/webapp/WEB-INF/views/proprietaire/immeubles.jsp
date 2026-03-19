<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Mes Immeubles — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">Mes Immeubles</span>
            <a href="${pageContext.request.contextPath}/proprietaire/immeuble/new" class="btn btn-primary btn-sm">+ Ajouter un immeuble</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
            <c:if test="${not empty erreur}"><div class="alert alert-danger">${erreur}</div></c:if>

            <c:if test="${empty immeubles}">
                <div class="card" style="text-align:center;padding:3rem">
                    <p style="color:#757575;margin:.5rem 0">Aucun immeuble enregistré pour le moment.</p>
                    <a href="${pageContext.request.contextPath}/proprietaire/immeuble/new" class="btn btn-primary" style="margin-top:1rem">Ajouter mon premier immeuble</a>
                </div>
            </c:if>

            <div class="card-grid">
            <c:forEach var="imm" items="${immeubles}">
                <div class="imm-card">
                    <div class="imm-card-header">
                        <h3>${imm.nom}</h3>
                        <span>${imm.nbUnites} unité(s)</span>
                    </div>
                    <div class="imm-card-body">
                        <p><strong>${imm.adresse}</strong></p>
                        <p>${imm.ville} <c:if test="${not empty imm.codePostal}">(${imm.codePostal})</c:if></p>
                        <c:if test="${not empty imm.description}">
                            <p style="margin-top:.5rem;font-style:italic;font-size:.82rem">${imm.description}</p>
                        </c:if>
                    </div>
                    <div class="imm-card-actions">
                        <a href="${pageContext.request.contextPath}/proprietaire/unites?immeubleId=${imm.id}" class="btn btn-accent btn-sm"></a>Unités</a>
                        <a href="${pageContext.request.contextPath}/proprietaire/immeuble/edit/${imm.id}" class="btn btn-outline btn-sm">Modifier</a>
                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/immeubles" style="margin-left:auto">
                            <input type="hidden" name="action" value="supprimer"/>
                            <input type="hidden" name="id" value="${imm.id}"/>
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Supprimer cet immeuble et toutes ses unités ?')">Supprimer</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
