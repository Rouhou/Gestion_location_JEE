<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="auth-wrap">
    <div class="auth-box">
        <div class="auth-logo">
            <span class="logo-icon">🏢</span>
            <h1>GestionLoc</h1>
            <p>Gestion des locations d'immeubles</p>
        </div>
        <div class="auth-title">Connexion à votre espace</div>

        <c:if test="${not empty erreur}">
            <div class="alert alert-danger">⚠️ ${erreur}</div>
        </c:if>
        <c:if test="${param.success eq '1'}">
            <div class="alert alert-success">✅ Inscription réussie ! Vous pouvez vous connecter.</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="form-group" style="margin-bottom:.9rem">
                <label for="email">Adresse email</label>
                <input type="email" id="email" name="email" required
                       placeholder="exemple@email.sn" value="${param.email}"/>
            </div>
            <div class="form-group" style="margin-bottom:1.3rem">
                <label for="password">Mot de passe</label>
                <input type="password" id="password" name="password" required
                       placeholder="••••••••"/>
            </div>
            <button type="submit" class="btn btn-primary btn-full">Se connecter</button>
        </form>
        <p style="text-align:center;margin-top:1.2rem;font-size:.87rem;color:#757575;">
            Pas encore de compte ?
            <a href="${pageContext.request.contextPath}/register" style="color:#1a237e;font-weight:600;">S'inscrire</a>
        </p>
    </div>
</div>
</body>
</html>
