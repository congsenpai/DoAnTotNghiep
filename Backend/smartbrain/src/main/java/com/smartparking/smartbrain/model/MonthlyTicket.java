package com.smartparking.smartbrain.model;

import java.sql.Timestamp;


import jakarta.persistence.Entity;
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
@Table(name = "monthly_tickets")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class MonthlyTicket {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String monthlyTicketId;

    // Relationship
    @OneToOne
    @JoinColumn(name = "parking_slot_id", nullable = false)
    ParkingSlot parkingSlot;
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;
    @OneToOne
    @JoinColumn(name = "invoice_id", nullable = false)
    Invoice invoice;
    // Timestamp
    Timestamp createAt;
    Timestamp expireAt;
    
        @PrePersist
    protected void onCreate() {
        this.createAt = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        this.expireAt = new Timestamp(System.currentTimeMillis());
    }
}
