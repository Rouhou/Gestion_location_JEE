<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Erreur serveur — GestionLoc</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body style="min-height:100vh;display:flex;align-items:center;justify-content:center;background:#f0f2f8">
<div style="text-align:center;background:#fff;padding:3rem;border-radius:16px;box-shadow:0 4px 20px rgba(0,0,0,.1);max-width:450px">
    <p style="font-size:5rem;margin-bottom:.5rem">⚙️</p>
    <h1 style="font-size:4rem;color:#e65100;font-weight:800">500</h1>
    <h2 style="color:#424242;margin-bottom:.8rem">Erreur interne</h2>
    <p style="color:#757575;margin-bottom:1.5rem">Une erreur inattendue s'est produite. Veuillez réessayer.</p>
    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">🏠 Retour à l'accueil</a>
</div>
</body>
</html>
