package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

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
@Table(name = "transactions")
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class Transaction {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String transactionId;
    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    @NotNull(message = "User cannot be null")
    private User user;
    @ManyToOne
    @JoinColumn(name = "walletId", nullable = false)
    @NotNull(message = "Wallet cannot be null")
    private Wallet wallet;
    @NotNull(message = "Amount cannot be null")
    private BigDecimal amount;
    private String description;
    public enum TransactionType {
        TOP_UP,
        PAYMENT
    }
    @Enumerated(EnumType.STRING)
    private TransactionType type;
    
    @Column(nullable = false, updatable = false)
    private Timestamp createdDate;

    @PrePersist
    protected void onCreate() {
        this.createdDate = new Timestamp(System.currentTimeMillis());
    }
}
