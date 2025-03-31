package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.time.Instant;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.smartparking.smartbrain.enums.TransactionStatus;
import com.smartparking.smartbrain.enums.TransactionType;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
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
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "transaction_id", nullable = false, updatable = false)
    String transactionID;
    @NotNull(message = "Amount cannot be null")
    BigDecimal amount;
    String description;
    @Enumerated(EnumType.STRING)
    TransactionType type;
    @Enumerated(EnumType.STRING)
    @Builder.Default
    TransactionStatus status= TransactionStatus.PENDING;

    // Relationship
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    @NotNull(message = "User cannot be null")
    User user;
    @ManyToOne
    @JoinColumn(name = "wallet_id", nullable = false)
    @NotNull(message = "Wallet cannot be null")
    Wallet wallet;
    @ManyToOne
    @JoinColumn(name = "invoice_id", nullable = true)
    Invoice invoice;
    // Timestamp
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    Instant createdAt;
    @UpdateTimestamp
    @Column(name = "updated_at")
    Instant updatedAt;
}
