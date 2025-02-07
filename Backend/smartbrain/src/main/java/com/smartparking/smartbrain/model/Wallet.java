package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Currency;
import java.util.List;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@Table(name = "wallets")
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class Wallet {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String walletId;

    @Column(nullable = false)
    @NotNull(message = "Balance cannot be null")
    private BigDecimal balance = BigDecimal.ZERO;

    @Column(nullable = false)
    @NotNull(message = "Currency cannot be null")
    private Currency currency;

    // Relationship
    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    @NotNull(message = "User cannot be null")
    private User user;
    @OneToMany(mappedBy = "wallet", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Transaction> transactions = new ArrayList<>();
    @NotNull(message = "Name of wallet cannot be null")
    private String name;
}
