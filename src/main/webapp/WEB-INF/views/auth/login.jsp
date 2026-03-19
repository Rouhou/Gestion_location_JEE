<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion — GestionLoc</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-indigo-50 to-indigo-100 flex items-center justify-center p-4">
<div class="w-full max-w-md">
    <div class="bg-white rounded-2xl shadow-lg p-8">
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-14 h-14 rounded-xl bg-indigo-600 text-white text-2xl font-bold mb-4">G</div>
            <h1 class="text-2xl font-bold text-gray-900">GestionLoc</h1>
            <p class="text-sm text-gray-500 mt-1">Gestion des locations d'immeubles</p>
        </div>

        <h2 class="text-lg font-semibold text-gray-800 mb-5">Connexion a votre espace</h2>

        <c:if test="${not empty erreur}">
            <div class="px-4 py-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm mb-4">${erreur}</div>
        </c:if>
        <c:if test="${param.success eq '1'}">
            <div class="px-4 py-3 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm mb-4">Inscription reussie ! Vous pouvez vous connecter.</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login" class="flex flex-col gap-4">
            <div class="flex flex-col gap-1">
                <label for="email" class="text-sm font-medium text-gray-700">Adresse email</label>
                <input type="email" id="email" name="email" required
                       placeholder="exemple@email.sn" value="${param.email}"
                       class="border border-gray-300 rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
            </div>
            <div class="flex flex-col gap-1">
                <label for="password" class="text-sm font-medium text-gray-700">Mot de passe</label>
                <input type="password" id="password" name="password" required
                       placeholder="••••••••"
                       class="border border-gray-300 rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
            </div>
            <button type="submit"
                    class="w-full flex items-center justify-center px-4 py-2.5 text-sm font-semibold rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors mt-1">
                Se connecter
            </button>
        </form>

        <p class="text-center mt-5 text-sm text-gray-500">
            Pas encore de compte ?
            <a href="${pageContext.request.contextPath}/register" class="text-indigo-700 font-semibold hover:underline">S'inscrire</a>
        </p>
    </div>
</div>
</body>
</html>
