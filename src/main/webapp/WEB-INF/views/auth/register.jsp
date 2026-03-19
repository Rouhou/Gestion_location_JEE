<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="auth-wrap">
    <div class="auth-box" style="max-width:500px">
        <div class="auth-logo">
            <span class="logo-icon">🏢</span>
            <h1>GestionLoc</h1>
            <p>Créez votre compte locataire</p>
        </div>
        <div class="auth-title">Inscription</div>

        <c:if test="${not empty erreur}">
            <div class="alert alert-danger">⚠️ ${erreur}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="form-grid">
                <div class="form-group">
                    <label>Prénom</label>
                    <input type="text" name="prenom" required placeholder="Fatou" value="${param.prenom}"/>
                </div>
                <div class="form-group">
                    <label>Nom</label>
                    <input type="text" name="nom" required placeholder="Sarr" value="${param.nom}"/>
                </div>
                <div class="form-group full">
                    <label>Email</label>
                    <input type="email" name="email" required placeholder="fsarr@email.sn" value="${param.email}"/>
                </div>
                <div class="form-group full">
                    <label>Téléphone</label>
                    <input type="tel" name="telephone" placeholder="77 000 00 00" value="${param.telephone}"/>
                </div>
                <div class="form-group">
                    <label>Mot de passe</label>
                    <input type="password" name="password" required placeholder="••••••••"/>
                </div>
                <div class="form-group">
                    <label>Confirmer</label>
                    <input type="password" name="passwordConfirm" required placeholder="••••••••"/>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-full" style="margin-top:1rem">Créer mon compte</button>
        </form>
        <p style="text-align:center;margin-top:1rem;font-size:.87rem;color:#757575;">
            Déjà inscrit ? <a href="${pageContext.request.contextPath}/login" style="color:#1a237e;font-weight:600;">Se connecter</a>
        </p>
    </div>
</div>
</body>
</html>
