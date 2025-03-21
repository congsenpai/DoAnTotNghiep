package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.time.Instant;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.smartparking.smartbrain.enums.InvoiceStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "invoices")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Invoice {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "invoice_id", nullable = false, updatable = false)
    String invoiceID;
    
    BigDecimal total_amount;
    @Enumerated(EnumType.STRING)
    @Builder.Default
    InvoiceStatus status=InvoiceStatus.PENDING;
    String description;

    // Relationship
    @OneToOne
    @JoinColumn(name = "transaction_id", nullable = false)
    Transaction transaction;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;

    @ManyToOne
    @JoinColumn(name = "discount_id", nullable = true)
    Discount discount;

    @ManyToOne
    @JoinColumn(name = "parking_slot_id", nullable = false)
    ParkingSlot parkingSlot;

    @ManyToOne
    @JoinColumn(name="vehicle_id", nullable = false)
    Vehicle vehicle;

    @OneToOne(mappedBy = "invoice")
    MonthlyTicket monthlyTicket;

    // Timestamp
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    Instant createdAt;
    @UpdateTimestamp
    @Column(name = "updated_at")
    Instant updatedAt;

}
