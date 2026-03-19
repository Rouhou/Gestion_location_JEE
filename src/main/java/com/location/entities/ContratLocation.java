package com.location.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "contrat_location")
public class ContratLocation {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date_debut", nullable = false)
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;

    @Column(name = "loyer_convenu", nullable = false, precision = 10, scale = 2)
    private BigDecimal loyerConvenu;

    @Column(name = "depot_garantie", precision = 10, scale = 2)
    private BigDecimal depotGarantie;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private StatutContrat statut = StatutContrat.ACTIF;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "locataire_id", nullable = false)
    private Utilisateur locataire;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "unite_id", nullable = false)
    private UniteLocation unite;

    @OneToMany(mappedBy = "contrat", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Paiement> paiements = new ArrayList<>();

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    public enum StatutContrat { ACTIF, TERMINE, RESILIE }

    public ContratLocation() {}

    // Getters / Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }
    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }
    public BigDecimal getLoyerConvenu() { return loyerConvenu; }
    public void setLoyerConvenu(BigDecimal loyerConvenu) { this.loyerConvenu = loyerConvenu; }
    public BigDecimal getDepotGarantie() { return depotGarantie; }
    public void setDepotGarantie(BigDecimal depotGarantie) { this.depotGarantie = depotGarantie; }
    public StatutContrat getStatut() { return statut; }
    public void setStatut(StatutContrat statut) { this.statut = statut; }
    public Utilisateur getLocataire() { return locataire; }
    public void setLocataire(Utilisateur locataire) { this.locataire = locataire; }
    public UniteLocation getUnite() { return unite; }
    public void setUnite(UniteLocation unite) { this.unite = unite; }
    public List<Paiement> getPaiements() { return paiements; }
    public void setPaiements(List<Paiement> paiements) { this.paiements = paiements; }
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public String getDateDebutFormattee() {
        if (dateDebut == null) return "";
        return dateDebut.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    public String getDateFinFormattee() {
        if (dateFin == null) return "";
        return dateFin.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
}
