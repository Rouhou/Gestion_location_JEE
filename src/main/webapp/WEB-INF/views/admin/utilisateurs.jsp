<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Utilisateurs — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">👥 Gestion des Utilisateurs</span>
            <a href="${pageContext.request.contextPath}/admin/utilisateur/new" class="btn btn-primary btn-sm">+ Ajouter</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}">
                <div class="alert alert-success">✅ ${message}</div>
            </c:if>

            <div class="card">
                <div class="card-header">
                    <h2>Liste des utilisateurs</h2>
                    <div class="filter-bar" style="margin-bottom:0">
                        <input type="text" id="searchInput" placeholder="🔍 Rechercher..." onkeyup="filterTable()"/>
                        <select id="roleFilter" onchange="filterTable()">
                            <option value="">Tous les rôles</option>
                            <option value="ADMIN">Admin</option>
                            <option value="PROPRIETAIRE">Propriétaire</option>
                            <option value="LOCATAIRE">Locataire</option>
                        </select>
                    </div>
                </div>
                <div class="table-wrap">
                    <table id="usersTable">
                        <thead>
                            <tr>
                                <th>#</th><th>Nom complet</th><th>Email</th>
                                <th>Téléphone</th><th>Rôle</th><th>Statut</th><th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="u" items="${utilisateurs}" varStatus="vs">
                            <tr>
                                <td>${vs.count}</td>
                                <td><strong>${u.prenom} ${u.nom}</strong></td>
                                <td>${u.email}</td>
                                <td>${u.telephone}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.role eq 'ADMIN'}"><span class="badge badge-red">ADMIN</span></c:when>
                                        <c:when test="${u.role eq 'PROPRIETAIRE'}"><span class="badge badge-blue">PROPRIÉTAIRE</span></c:when>
                                        <c:otherwise><span class="badge badge-teal">LOCATAIRE</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.actif}"><span class="badge badge-green">Actif</span></c:when>
                                        <c:otherwise><span class="badge badge-gray">Inactif</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/utilisateur/edit/${u.id}" class="btn btn-outline btn-sm">✏️</a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs" style="display:inline">
                                        <input type="hidden" name="action" value="toggle"/>
                                        <input type="hidden" name="id" value="${u.id}"/>
                                        <button type="submit" class="btn btn-sm ${u.actif ? 'btn-warn' : 'btn-success'}"
                                                onclick="return confirm('Modifier le statut ?')">
                                            ${u.actif ? '🚫' : '✅'}
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
    const role = document.getElementById('roleFilter').value.toLowerCase();
    document.querySelectorAll('#usersTable tbody tr').forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = (text.includes(q) && (role === '' || text.includes(role))) ? '' : 'none';
    });
}
</script>
</body>
</html>
