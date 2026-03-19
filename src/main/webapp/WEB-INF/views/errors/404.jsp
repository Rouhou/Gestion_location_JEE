<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Page introuvable — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gray-50 flex items-center justify-center p-4">
<div class="text-center bg-white rounded-2xl shadow-lg p-10 max-w-md w-full">
    <div class="text-8xl font-extrabold text-indigo-700 mb-2">404</div>
    <h1 class="text-2xl font-bold text-gray-800 mb-2">Page introuvable</h1>
    <p class="text-gray-500 mb-6">La page que vous cherchez n'existe pas ou a ete deplacee.</p>
    <a href="${pageContext.request.contextPath}/"
       class="inline-flex items-center justify-center px-5 py-2.5 text-sm font-semibold rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
        Retour a l'accueil
    </a>
</div>
</body>
</html>
