<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Enregistrer un paiement — GestionLoc Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        /* ── Searchable select (Tom Select) ── */
        .ts-wrapper.single .ts-control {
            padding: .6rem .9rem;
            border: 1.5px solid var(--border, #e0e0e0);
            border-radius: 7px;
            font-size: .9rem;
            background: #fafafa;
            cursor: pointer;
        }
        .ts-wrapper.single.focus .ts-control {
            border-color: #3949ab;
            box-shadow: 0 0 0 3px rgba(57,73,171,.1);
            background: #fff;
        }
        .ts-dropdown { border-radius: 7px; border: 1.5px solid #e0e0e0; box-shadow: 0 4px 16px rgba(0,0,0,.1); }
        .ts-dropdown .option { padding: .55rem 1rem; font-size: .88rem; }
        .ts-dropdown .option:hover, .ts-dropdown .option.active { background: #e8eaf6; color: #1a237e; }
        .ts-dropdown .option .sub { font-size: .78rem; color: #9e9e9e; display: block; }

        /* ── Contrat info panel ── */
        #contratInfo {
            background: #e8eaf6;
            border: 1.5px solid #c5cae9;
            border-radius: 8px;
            padding: 1rem 1.2rem;
            font-size: .88rem;
            display: none;
            margin-top: .5rem;
        }
        #contratInfo .ci-row { display: flex; gap: 2rem; flex-wrap: wrap; }
        #contratInfo .ci-item { display: flex; flex-direction: column; }
        #contratInfo .ci-label { font-size: .72rem; color: #5c6bc0; text-transform: uppercase; }
        #contratInfo .ci-value { font-weight: 700; color: #1a237e; }
    </style>
</head>
<body>
<div class="layout">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <div class="main-content">
        <div class="topbar">
            <span class="topbar-title">💸 Enregistrer un nouveau paiement</span>
            <a href="${pageContext.request.contextPath}/admin/paiements"
               class="btn btn-outline btn-sm">← Retour</a>
        </div>
        <div class="page-body">
            <c:if test="${not empty erreur}">
                <div class="alert alert-danger">⚠️ ${erreur}</div>
            </c:if>

            <div class="card" style="max-width:680px;margin:0 auto">
                <div class="card-header"><h2>Nouveau paiement</h2></div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/paiements"
                          id="paiementForm">
                        <input type="hidden" name="action" value="enregistrer"/>

                        <div class="form-grid">

                            <%-- ── 1. Locataire avec recherche ── --%>
                            <div class="form-group full">
                                <label for="locataireSelect">Locataire *</label>
                                <select id="locataireSelect" name="locataireId" required>
                                    <option value="">Rechercher un locataire...</option>
                                    <c:forEach var="l" items="${locataires}">
                                        <option value="${l.id}"
                                                data-email="${l.email}"
                                                data-tel="${l.telephone}">
                                            ${l.prenom} ${l.nom} — ${l.email}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <%-- ── 2. Contrat actif du locataire ── --%>
                            <div class="form-group full">
                                <label for="contratSelect">Contrat *</label>
                                <select id="contratSelect" name="contratId" required disabled>
                                    <option value="">— Sélectionner d'abord un locataire —</option>
                                </select>
                                <%-- Panel info contrat --%>
                                <div id="contratInfo">
                                    <div class="ci-row">
                                        <div class="ci-item">
                                            <span class="ci-label">Immeuble / Unité</span>
                                            <span class="ci-value" id="ciUnite">—</span>
                                        </div>
                                        <div class="ci-item">
                                            <span class="ci-label">Loyer convenu</span>
                                            <span class="ci-value" id="ciLoyer">—</span>
                                        </div>
                                        <div class="ci-item">
                                            <span class="ci-label">Début contrat</span>
                                            <span class="ci-value" id="ciDebut">—</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- ── 3. Mois concerné ── --%>
                            <div class="form-group">
                                <label for="moisConcerne">Mois concerné *</label>
                                <input type="month" id="moisConcerne" name="moisConcerne" required/>
                            </div>

                            <%-- ── 4. Montant ── --%>
                            <div class="form-group">
                                <label for="montant">Montant (F CFA) *</label>
                                <input type="number" id="montant" name="montant" required
                                       min="1" placeholder="350000"/>
                            </div>

                            <%-- ── 5. Date de paiement ── --%>
                            <div class="form-group">
                                <label for="datePaiement">Date de paiement *</label>
                                <input type="date" id="datePaiement" name="datePaiement" required/>
                            </div>

                            <%-- ── 6. Mode de paiement ── --%>
                            <div class="form-group">
                                <label for="modePaiement">Mode de paiement *</label>
                                <select id="modePaiement" name="modePaiement" required>
                                    <option value="VIREMENT">Virement bancaire</option>
                                    <option value="ESPECES">Espèces</option>
                                    <option value="CHEQUE">Chèque</option>
                                    <option value="MOBILE_MONEY">Mobile Money</option>
                                    <option value="ORANGE_MONEY">Orange Money</option>
                                    <option value="WAVE">Wave</option>
                                </select>
                            </div>

                        </div>

                        <div style="display:flex;gap:.8rem;margin-top:1.5rem">
                            <button type="submit" class="btn btn-primary">💾 Enregistrer le paiement</button>
                            <a href="${pageContext.request.contextPath}/admin/paiements"
                               class="btn btn-outline">Annuler</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>

<%-- Données contrats en JSON pour le JS --%>
<script>
const contratsParLocataire = {
    <c:forEach var="entry" items="${contratsParLocataire}" varStatus="vs">
    "${entry.key}": [
        <c:forEach var="c" items="${entry.value}" varStatus="cs">
        {
            id:      "${c.id}",
            unite:   "${c.unite.immeuble.nom} — Unité ${c.unite.numero}",
            loyer:   "<fmt:formatNumber value='${c.loyerConvenu}' pattern='#,##0'/> F CFA",
            debut:   "${c.dateDebut}",
            loyerVal: ${c.loyerConvenu}
        }${!cs.last ? ',' : ''}
        </c:forEach>
    ]${!vs.last ? ',' : ''}
    </c:forEach>
};
</script>

<%-- Tom Select (recherche dans la liste déroulante) --%>
<link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>

<script>
// ── Initialisation Tom Select sur le champ locataire ──
const tsLocataire = new TomSelect('#locataireSelect', {
    placeholder:     'Taper un nom, email...',
    searchField:     ['text'],
    maxOptions:      null,
    render: {
        option: function(data) {
            const parts = data.text.split(' — ');
            const nom   = parts[0] || data.text;
            const email = parts[1] || '';
            return `<div>${nom}<span class="sub">${email}</span></div>`;
        }
    },
    onChange: function(locataireId) {
        chargerContrats(locataireId);
    }
});

// ── Chargement des contrats selon le locataire choisi ──
function chargerContrats(locataireId) {
    const select      = document.getElementById('contratSelect');
    const contratInfo = document.getElementById('contratInfo');

    select.innerHTML  = '<option value="">— Sélectionner un contrat —</option>';
    select.disabled   = true;
    contratInfo.style.display = 'none';

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
        opt.dataset.unite  = c.unite;
        opt.dataset.loyer  = c.loyer;
        opt.dataset.debut  = c.debut;
        opt.dataset.loyerVal = c.loyerVal;
        select.appendChild(opt);
    });

    select.disabled = false;

    // Si un seul contrat → sélection auto
    if (contrats.length === 1) {
        select.value = contrats[0].id;
        afficherInfoContrat(contrats[0]);
        // Pré-remplir le montant avec le loyer convenu
        document.getElementById('montant').value = contrats[0].loyerVal;
    }
}

// ── Affichage du panel info contrat ──
document.getElementById('contratSelect').addEventListener('change', function() {
    const opt = this.selectedOptions[0];
    if (!opt || !opt.dataset.unite) {
        document.getElementById('contratInfo').style.display = 'none';
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
    document.getElementById('contratInfo').style.display = 'block';
}

// ── Date du jour par défaut ──
document.getElementById('datePaiement').value = new Date().toISOString().split('T')[0];

// ── Mois courant par défaut ──
const now = new Date();
document.getElementById('moisConcerne').value =
    now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0');
</script>
</body>
</html>
