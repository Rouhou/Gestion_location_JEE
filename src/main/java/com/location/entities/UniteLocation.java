package com.location.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "unite_location")
public class UniteLocation {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 20)
    private String numero;

    @Column(name = "nb_pieces", nullable = false)
    private int nbPieces;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal superficie;

    @Column(name = "loyer_mensuel", nullable = false, precision = 10, scale = 2)
    private BigDecimal loyerMensuel;

    @Column(nullable = false)
    private boolean disponible = true;

    @Column(columnDefinition = "TEXT")
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "immeuble_id", nullable = false)
    private Immeuble immeuble;

    @OneToMany(mappedBy = "unite", cascade = CascadeType.ALL)
    private List<ContratLocation> contrats = new ArrayList<>();

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    public UniteLocation() {}

    // Getters / Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNumero() { return numero; }
    public void setNumero(String numero) { this.numero = numero; }
    public int getNbPieces() { return nbPieces; }
    public void setNbPieces(int nbPieces) { this.nbPieces = nbPieces; }
    public BigDecimal getSuperficie() { return superficie; }
    public void setSuperficie(BigDecimal superficie) { this.superficie = superficie; }
    public BigDecimal getLoyerMensuel() { return loyerMensuel; }
    public void setLoyerMensuel(BigDecimal loyerMensuel) { this.loyerMensuel = loyerMensuel; }
    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Immeuble getImmeuble() { return immeuble; }
    public void setImmeuble(Immeuble immeuble) { this.immeuble = immeuble; }
    public List<ContratLocation> getContrats() { return contrats; }
    public void setContrats(List<ContratLocation> contrats) { this.contrats = contrats; }
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public String getDateCreationFormattee() {
        if (dateCreation == null) return "";
        return dateCreation.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
}
