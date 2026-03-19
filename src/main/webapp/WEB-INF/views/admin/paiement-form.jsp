<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Enregistrer un paiement — GestionLoc Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.min.css" rel="stylesheet"/>
</head>
<body class="bg-gray-50">
<div class="flex h-screen overflow-hidden">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="flex-1 flex flex-col overflow-auto">

        <div class="flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200 shrink-0">
            <span class="font-semibold text-gray-800 text-lg">Enregistrer un nouveau paiement</span>
            <a href="${pageContext.request.contextPath}/admin/paiements"
               class="inline-flex items-center px-3 py-1.5 text-xs font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                Retour
            </a>
        </div>

        <div class="flex-1 p-6">
            <c:if test="${not empty erreur}">
                <div class="px-4 py-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm mb-5">${erreur}</div>
            </c:if>

            <div class="bg-white rounded-xl border border-gray-200 shadow-sm max-w-2xl mx-auto">
                <div class="px-5 py-4 border-b border-gray-100">
                    <h2 class="font-semibold text-gray-800">Nouveau paiement</h2>
                </div>
                <div class="p-5">
                    <form method="post" action="${pageContext.request.contextPath}/admin/paiements" id="paiementForm">
                        <input type="hidden" name="action" value="enregistrer"/>

                        <div class="grid grid-cols-2 gap-4">
                            <div class="flex flex-col gap-1 col-span-2">
                                <label for="locataireSelect" class="text-sm font-medium text-gray-700">Locataire *</label>
                                <select id="locataireSelect" name="locataireId" required>
                                    <option value="">Rechercher un locataire...</option>
                                    <c:forEach var="l" items="${locataires}">
                                        <option value="${l.id}" data-email="${l.email}" data-tel="${l.telephone}">
                                            ${l.prenom} ${l.nom} — ${l.email}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="flex flex-col gap-1 col-span-2">
                                <label for="contratSelect" class="text-sm font-medium text-gray-700">Contrat *</label>
                                <select id="contratSelect" name="contratId" required disabled
                                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent disabled:bg-gray-100 disabled:text-gray-400">
                                    <option value="">— Selectionner d'abord un locataire —</option>
                                </select>
                                <div id="contratInfo" class="hidden mt-2 bg-indigo-50 border border-indigo-200 rounded-lg p-3">
                                    <div class="flex gap-6 flex-wrap">
                                        <div>
                                            <div class="text-xs text-indigo-400 uppercase font-semibold">Immeuble / Unite</div>
                                            <div class="font-bold text-indigo-800 text-sm" id="ciUnite">—</div>
                                        </div>
                                        <div>
                                            <div class="text-xs text-indigo-400 uppercase font-semibold">Loyer convenu</div>
                                            <div class="font-bold text-indigo-800 text-sm" id="ciLoyer">—</div>
                                        </div>
                                        <div>
                                            <div class="text-xs text-indigo-400 uppercase font-semibold">Debut contrat</div>
                                            <div class="font-bold text-indigo-800 text-sm" id="ciDebut">—</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex flex-col gap-1">
                                <label for="moisConcerne" class="text-sm font-medium text-gray-700">Mois concerne *</label>
                                <input type="month" id="moisConcerne" name="moisConcerne" required
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>

                            <div class="flex flex-col gap-1">
                                <label for="montant" class="text-sm font-medium text-gray-700">Montant (F CFA) *</label>
                                <input type="number" id="montant" name="montant" required min="1" placeholder="350000"
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>

                            <div class="flex flex-col gap-1">
                                <label for="datePaiement" class="text-sm font-medium text-gray-700">Date de paiement *</label>
                                <input type="date" id="datePaiement" name="datePaiement" required
                                       class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent"/>
                            </div>

                            <div class="flex flex-col gap-1">
                                <label for="modePaiement" class="text-sm font-medium text-gray-700">Mode de paiement *</label>
                                <select id="modePaiement" name="modePaiement" required
                                        class="border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent">
                                    <option value="VIREMENT">Virement bancaire</option>
                                    <option value="ESPECES">Especes</option>
                                    <option value="CHEQUE">Cheque</option>
                                    <option value="MOBILE_MONEY">Mobile Money</option>
                                    <option value="ORANGE_MONEY">Orange Money</option>
                                    <option value="WAVE">Wave</option>
                                </select>
                            </div>
                        </div>

                        <div class="flex items-center gap-3 mt-6">
                            <button type="submit"
                                    class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg bg-indigo-700 text-white hover:bg-indigo-800 transition-colors">
                                Enregistrer le paiement
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/paiements"
                               class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                                Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>

<script>
const contratsParLocataire = {
    <c:forEach var="entry" items="${contratsParLocataire}" varStatus="vs">
    "${entry.key}": [
        <c:forEach var="c" items="${entry.value}" varStatus="cs">
        {
            id:      "${c.id}",
            unite:   "${c.unite.immeuble.nom} — Unite ${c.unite.numero}",
            loyer:   "<fmt:formatNumber value='${c.loyerConvenu}' pattern='#,##0'/> F CFA",
            debut:   "${c.dateDebut}",
            loyerVal: ${c.loyerConvenu}
        }${!cs.last ? ',' : ''}
        </c:forEach>
    ]${!vs.last ? ',' : ''}
    </c:forEach>
};
</script>

<script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>
<script>
const tsLocataire = new TomSelect('#locataireSelect', {
    placeholder:     'Taper un nom, email...',
    searchField:     ['text'],
    maxOptions:      null,
    render: {
        option: function(data) {
            const parts = data.text.split(' — ');
            const nom   = parts[0] || data.text;
            const email = parts[1] || '';
            return `<div class="py-1">${nom}<span class="text-xs text-gray-400 block">${email}</span></div>`;
        }
    },
    onChange: function(locataireId) {
        chargerContrats(locataireId);
    }
});

function chargerContrats(locataireId) {
    const select      = document.getElementById('contratSelect');
    const contratInfo = document.getElementById('contratInfo');
    select.innerHTML  = '<option value="">— Selectionner un contrat —</option>';
    select.disabled   = true;
    contratInfo.classList.add('hidden');
    if (!locataireId || !contratsParLocataire[locataireId]) return;
    const contrats = contratsParLocataire[locataireId];
    if (contrats.length === 0) {
        select.innerHTML = '<option value="">Aucun contrat actif pour ce locataire</option>';
        return;
    }
    contrats.forEach(c => {
        const opt   = document.createElement('option');
        opt.value   = c.id;
        opt.text    = c.unite + ' — Loyer : ' + c.loyer;
        opt.dataset.unite    = c.unite;
        opt.dataset.loyer    = c.loyer;
        opt.dataset.debut    = c.debut;
        opt.dataset.loyerVal = c.loyerVal;
        select.appendChild(opt);
    });
    select.disabled = false;
    if (contrats.length === 1) {
        select.value = contrats[0].id;
        afficherInfoContrat(contrats[0]);
        document.getElementById('montant').value = contrats[0].loyerVal;
    }
}

document.getElementById('contratSelect').addEventListener('change', function() {
    const opt = this.selectedOptions[0];
    if (!opt || !opt.dataset.unite) {
        document.getElementById('contratInfo').classList.add('hidden');
        return;
    }
    afficherInfoContrat({
        unite:    opt.dataset.unite,
        loyer:    opt.dataset.loyer,
        debut:    opt.dataset.debut,
        loyerVal: opt.dataset.loyerVal
    });
    document.getElementById('montant').value = opt.dataset.loyerVal;
});

function afficherInfoContrat(c) {
    document.getElementById('ciUnite').textContent = c.unite;
    document.getElementById('ciLoyer').textContent = c.loyer;
    document.getElementById('ciDebut').textContent = c.debut;
    document.getElementById('contratInfo').classList.remove('hidden');
}

document.getElementById('datePaiement').value = new Date().toISOString().split('T')[0];
const now = new Date();
document.getElementById('moisConcerne').value =
    now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0');
</script>
</body>
</html>
