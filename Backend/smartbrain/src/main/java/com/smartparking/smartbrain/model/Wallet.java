package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Currency;
import java.util.Set;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@Table(name = "wallets")
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Wallet {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String walletId;

    @Column(nullable = false)
    @NotNull(message = "Balance cannot be null")
    BigDecimal balance = BigDecimal.ZERO;

    @Column(nullable = false)
    @NotNull(message = "Currency cannot be null")
    Currency currency;

    @NotNull(message = "Name of wallet cannot be null")
    String name;

    // Relationship
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    @NotNull(message = "User cannot be null")
    User user;

    @OneToMany(mappedBy = "wallet", cascade = CascadeType.ALL, orphanRemoval = true)
    Set<Transaction> transactions;
    // Timestamp
    Timestamp createdAt;
    Timestamp updatedAt;
    public void onUpdated() {
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }

    public void onCreated() {
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

}
