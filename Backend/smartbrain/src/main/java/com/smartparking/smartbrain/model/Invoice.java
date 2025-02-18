package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.smartparking.smartbrain.enums.InvoiceStatus;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
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
    String invoiceId;
    
    BigDecimal total_amount;
    @Enumerated(EnumType.STRING)
    InvoiceStatus status;
    String description;

    // Relationship
    @OneToOne
    @JoinColumn(name = "transaction_id", nullable = false)
    Transaction transaction;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;

    @OneToOne
    @JoinColumn(name = "discount_id", nullable = true)
    Discount discount;

    @ManyToOne
    @JoinColumn(name = "parking_slot_id", nullable = false)
    ParkingSlot parkingSlot;

    @ManyToOne
    @JoinColumn(name="vehicle_id", nullable = false)
    Vehicle vehicle;

    @OneToOne
    @JoinColumn(name = "monthly_ticket_id", nullable = true)
    MonthlyTicket monthlyTicket;

    // Timestamp
    Timestamp createAt;
    Timestamp updateAt;
    @PrePersist
    protected void onCreate() {
        this.createAt = new Timestamp(System.currentTimeMillis());
    }
    @PreUpdate
    protected void onUpdate() {
        this.updateAt = new Timestamp(System.currentTimeMillis());
    }


}
