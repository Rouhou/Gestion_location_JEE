<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Immeubles — GestionLoc Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">🏗️ Gestion des Immeubles</span>
            <a href="${pageContext.request.contextPath}/admin/immeuble/new" class="btn btn-primary btn-sm">+ Ajouter</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>
            <c:if test="${not empty erreur}"><div class="alert alert-danger">⚠️ ${erreur}</div></c:if>

            <%-- Filtres --%>
            <div class="filter-bar">
                <input type="text" id="searchInput" placeholder="🔍 Rechercher..." onkeyup="filterTable()"/>
                <select id="villeFilter" onchange="filterTable()">
                    <option value="">Toutes les villes</option>
                    <c:forEach var="imm" items="${immeubles}">
                        <option value="${imm.ville}">${imm.ville}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="card">
                <div class="card-header">
                    <h2>Liste des immeubles (${immeubles.size()})</h2>
                </div>
                <div class="table-wrap">
                    <table id="immeublesTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nom</th>
                                <th>Adresse</th>
                                <th>Ville</th>
                                <th>Propriétaire</th>
                                <th>Unités</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty immeubles}">
                            <tr><td colspan="7" style="text-align:center;padding:2rem;color:#9e9e9e">Aucun immeuble enregistré.</td></tr>
                        </c:if>
                        <c:forEach var="imm" items="${immeubles}" varStatus="vs">
                            <tr>
                                <td>${vs.count}</td>
                                <td><strong>${imm.nom}</strong></td>
                                <td>${imm.adresse}</td>
                                <td>${imm.ville}</td>
                                <td>
                                    <c:if test="${not empty imm.proprietaire}">
                                        ${imm.proprietaire.prenom} ${imm.proprietaire.nom}
                                    </c:if>
                                </td>
                                <td><span class="badge badge-blue">${imm.nbUnites}</span></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/immeuble/edit/${imm.id}"
                                       class="btn btn-outline btn-sm">✏️ Modifier</a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/immeubles"
                                          style="display:inline">
                                        <input type="hidden" name="action" value="supprimer"/>
                                        <input type="hidden" name="id" value="${imm.id}"/>
                                        <button type="submit" class="btn btn-danger btn-sm"
                                                onclick="return confirm('Supprimer cet immeuble et toutes ses unités ?')">
                                            🗑️ Supprimer
                                        </button>
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
<script>
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    const v = document.getElementById('villeFilter').value.toLowerCase();
    document.querySelectorAll('#immeublesTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!v || t.includes(v))) ? '' : 'none';
    });
}
</script>
</body>
</html>
