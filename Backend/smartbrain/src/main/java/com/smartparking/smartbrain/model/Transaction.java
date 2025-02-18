package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.smartparking.smartbrain.enums.TransactionStatus;
import com.smartparking.smartbrain.enums.Transactions;

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
@Table(name = "transactions")
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Transaction {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String transactionId;
    @NotNull(message = "Amount cannot be null")
    BigDecimal amount;
    String description;
    @Enumerated(EnumType.STRING)
    Transactions type;
    @Enumerated(EnumType.STRING)
    TransactionStatus status;

    // Relationship
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    @NotNull(message = "User cannot be null")
    User user;
    @ManyToOne
    @JoinColumn(name = "wallet_id", nullable = false)
    @NotNull(message = "Wallet cannot be null")
    Wallet wallet;
    @OneToOne(mappedBy="transaction")
    Invoice invoice;
    @Column(nullable = false, updatable = false)
    Timestamp createdDate;
    @PrePersist
    protected void onCreate() {
        this.createdDate = new Timestamp(System.currentTimeMillis());
    }
}
