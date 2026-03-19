package com.location.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "paiement")
public class Paiement {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal montant;

    @Column(name = "date_paiement", nullable = false)
    private LocalDate datePaiement;

    @Column(name = "mode_paiement", length = 30)
    private String modePaiement = "VIREMENT";

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private StatutPaiement statut = StatutPaiement.EN_ATTENTE;

    @Column(name = "mois_concerne", nullable = false, length = 7)
    private String moisConcerne; // YYYY-MM

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contrat_id", nullable = false)
    private ContratLocation contrat;

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    public enum StatutPaiement { EN_ATTENTE, VALIDE, REJETE }

    public Paiement() {}

    // Getters / Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public BigDecimal getMontant() { return montant; }
    public void setMontant(BigDecimal montant) { this.montant = montant; }
    public LocalDate getDatePaiement() { return datePaiement; }
    public void setDatePaiement(LocalDate datePaiement) { this.datePaiement = datePaiement; }
    public String getModePaiement() { return modePaiement; }
    public void setModePaiement(String modePaiement) { this.modePaiement = modePaiement; }
    public StatutPaiement getStatut() { return statut; }
    public void setStatut(StatutPaiement statut) { this.statut = statut; }
    public String getMoisConcerne() { return moisConcerne; }
    public void setMoisConcerne(String moisConcerne) { this.moisConcerne = moisConcerne; }
    public ContratLocation getContrat() { return contrat; }
    public void setContrat(ContratLocation contrat) { this.contrat = contrat; }
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public String getDatePaiementFormattee() {
        if (datePaiement == null) return "";
        return datePaiement.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    public String getDateCreationFormattee() {
        if (datePaiement == null) return "";
        return datePaiement.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
}
