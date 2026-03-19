<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Contrats — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <!-- <div class="topbar">
            <span class="topbar-title">📄 Contrats de location</span>
            <a href="${pageContext.request.contextPath}/proprietaire/contrat/new" class="btn btn-primary btn-sm">+ Nouveau contrat</a>
        </div> -->
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>

            <div class="card">
                <div class="card-header">
                    <h2>Liste des contrats</h2>
                    <div class="filter-bar" style="margin-bottom:0">
                        <select id="statutFilter" onchange="filterContrats()">
                            <option value="">Tous les statuts</option>
                            <option value="actif">Actif</option>
                            <option value="termine">Terminé</option>
                            <option value="resilie">Résilié</option>
                        </select>
                    </div>
                </div>
                <div class="table-wrap">
                    <table id="contratsTable">
                        <thead>
                            <tr><th>Locataire</th><th>Unité</th><th>Date début</th><th>Loyer convenu</th><th>Statut</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty contrats}">
                            <tr><td colspan="6" style="text-align:center;padding:2rem;color:#9e9e9e">Aucun contrat trouvé.</td></tr>
                        </c:if>
                        <c:forEach var="c" items="${contrats}">
                            <tr>
                                <td>
                                    <strong>${c.locataire.prenom} ${c.locataire.nom}</strong><br>
                                    <small style="color:#9e9e9e">${c.locataire.email}</small>
                                </td>
                                <td>${c.unite.numero} — ${c.unite.immeuble.nom}</td>
                                <td>${c.dateDebutFormattee}</td>
                                <td><strong><fmt:formatNumber value="${c.loyerConvenu}" pattern="#,##0"/> F</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.statut eq 'ACTIF'}"><span class="badge badge-green">Actif</span></c:when>
                                        <c:when test="${c.statut eq 'TERMINE'}"><span class="badge badge-gray">Terminé</span></c:when>
                                        <c:otherwise><span class="badge badge-red">Résilié</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/proprietaire/contrat/${c.id}" class="btn btn-outline btn-sm">👁️</a>
                                    <c:if test="${c.statut eq 'ACTIF'}">
                                        <form method="post" action="${pageContext.request.contextPath}/proprietaire/contrats" style="display:inline">
                                            <input type="hidden" name="action" value="resilier"/>
                                            <input type="hidden" name="id" value="${c.id}"/>
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Résilier ce contrat ?')">🚫 Résilier</button>
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
function filterContrats() {
    const f = document.getElementById('statutFilter').value.toLowerCase();
    document.querySelectorAll('#contratsTable tbody tr').forEach(row => {
        row.style.display = (!f || row.textContent.toLowerCase().includes(f)) ? '' : 'none';
    });
}
</script>
</body>
</html>
