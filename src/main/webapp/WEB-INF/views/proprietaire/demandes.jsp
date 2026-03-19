<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Demandes de location — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">📬 Demandes de Location</span>
        </div>
        <div class="page-body">
            <c:if test="${not empty message}"><div class="alert alert-success">✅ ${message}</div></c:if>
            <c:if test="${not empty erreur}"><div class="alert alert-danger">⚠️ ${erreur}</div></c:if>

            <%-- Compteurs --%>
            <div class="stats-grid" style="margin-bottom:1.5rem">
                <div class="stat-card orange">
                    <span class="stat-icon">⏳</span>
                    <c:set var="nbAttente" value="0"/>
                    <c:forEach var="d" items="${demandes}">
                        <c:if test="${d.statut eq 'EN_ATTENTE'}"><c:set var="nbAttente" value="${nbAttente + 1}"/></c:if>
                    </c:forEach>
                    <span class="stat-value">${nbAttente}</span>
                    <span class="stat-label">En attente</span>
                </div>
                <div class="stat-card green">
                    <span class="stat-icon">✅</span>
                    <c:set var="nbAcceptees" value="0"/>
                    <c:forEach var="d" items="${demandes}">
                        <c:if test="${d.statut eq 'ACCEPTEE'}"><c:set var="nbAcceptees" value="${nbAcceptees + 1}"/></c:if>
                    </c:forEach>
                    <span class="stat-value">${nbAcceptees}</span>
                    <span class="stat-label">Acceptées</span>
                </div>
                <div class="stat-card red">
                    <span class="stat-icon">❌</span>
                    <c:set var="nbRefusees" value="0"/>
                    <c:forEach var="d" items="${demandes}">
                        <c:if test="${d.statut eq 'REFUSEE'}"><c:set var="nbRefusees" value="${nbRefusees + 1}"/></c:if>
                    </c:forEach>
                    <span class="stat-value">${nbRefusees}</span>
                    <span class="stat-label">Refusées</span>
                </div>
            </div>

            <%-- Filtre --%>
            <div class="filter-bar">
                <select id="statutFilter" onchange="filterTable()">
                    <option value="">Tous les statuts</option>
                    <option value="en_attente">En attente</option>
                    <option value="acceptee">Acceptée</option>
                    <option value="refusee">Refusée</option>
                </select>
                <input type="text" id="searchInput" placeholder="🔍 Locataire, unité..." onkeyup="filterTable()"/>
            </div>

            <div class="card">
                <div class="card-header"><h2>Liste des demandes (${demandes.size()})</h2></div>

                <c:if test="${empty demandes}">
                    <div style="text-align:center;padding:3rem;color:#9e9e9e">
                        <p style="font-size:3rem">📭</p>
                        <p>Aucune demande reçue pour le moment.</p>
                    </div>
                </c:if>

                <div class="table-wrap">
                    <table id="demandesTable">
                        <thead>
                            <tr>
                                <th>Locataire</th>
                                <th>Immeuble / Unité</th>
                                <th>Loyer</th>
                                <th>Message</th>
                                <th>Date demande</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="d" items="${demandes}">
                            <tr>
                                <td>
                                    <strong>${d.locataire.prenom} ${d.locataire.nom}</strong><br>
                                    <small style="color:#9e9e9e">${d.locataire.email}</small><br>
                                    <small style="color:#9e9e9e">${d.locataire.telephone}</small>
                                </td>
                                <td>
                                    <strong>${d.unite.immeuble.nom}</strong><br>
                                    <small style="color:#9e9e9e">
                                        Unité ${d.unite.numero} —
                                        ${d.unite.nbPieces} pièces
                                    </small>
                                </td>
                                <td>
                                    <strong style="color:#1a237e">
                                        <fmt:formatNumber value="${d.unite.loyerMensuel}" pattern="#,##0"/> F
                                    </strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty d.message}">
                                            <span title="${d.message}" style="cursor:help">
                                                ${d.message.length() > 40 ? d.message.substring(0,40).concat('...') : d.message}
                                            </span>
                                        </c:when>
                                        <c:otherwise><span style="color:#bdbdbd">—</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    ${d.dateDemandeFormattee}<br>
                                    <small style="color:#9e9e9e">
                                        ${d.heureDemandeFormattee}
                                    </small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.statut eq 'EN_ATTENTE'}">
                                            <span class="badge badge-orange">⏳ En attente</span>
                                        </c:when>
                                        <c:when test="${d.statut eq 'ACCEPTEE'}">
                                            <span class="badge badge-green">✅ Acceptée</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-red">❌ Refusée</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${d.statut eq 'EN_ATTENTE'}">
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/proprietaire/demandes"
                                              style="display:inline">
                                            <input type="hidden" name="id" value="${d.id}"/>
                                            <input type="hidden" name="action" value="accepter"/>
                                            <button type="submit" class="btn btn-success btn-sm"
                                                    onclick="return confirm('Accepter la demande de ${d.locataire.prenom} ${d.locataire.nom} ?')">
                                                ✅ Accepter
                                            </button>
                                        </form>
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/proprietaire/demandes"
                                              style="display:inline;margin-top:.3rem">
                                            <input type="hidden" name="id" value="${d.id}"/>
                                            <input type="hidden" name="action" value="refuser"/>
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                    onclick="return confirm('Refuser cette demande ?')">
                                                ❌ Refuser
                                            </button>
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
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    const s = document.getElementById('statutFilter').value.toLowerCase();
    document.querySelectorAll('#demandesTable tbody tr').forEach(row => {
        const t = row.textContent.toLowerCase();
        row.style.display = (t.includes(q) && (!s || t.includes(s))) ? '' : 'none';
    });
}
</script>
</body>
</html>
