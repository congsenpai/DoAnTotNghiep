package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Set;

import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.enums.VehicleType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "parking_slots")
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class ParkingSlot {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "parking_slot_id", nullable = false, updatable = false)
    String slotId;
    String slotName;

    @Enumerated(EnumType.STRING)
    VehicleType vehicleType;

    @Enumerated(EnumType.STRING)
    @Builder.Default
    @Column(nullable = false, columnDefinition = "varchar(255) default 'AVAILABLE'")
    SlotStatus slotStatus= SlotStatus.AVAILABLE;
    @Column(nullable = false)
    BigDecimal pricePerHour;
    @Column(nullable = false)
    BigDecimal pricePerMonth;
    
    // Relationship
    @ManyToOne
    @JoinColumn(name = "parking_lot_id",nullable = false)
    ParkingLot parkingLot;
    @OneToMany(mappedBy = "parkingSlot")
    Set<Invoice> invoice;
    @OneToOne(mappedBy = "parkingSlot")
    MonthlyTicket monthlyTicket;

    // Timestamp
    Timestamp createdAt;
    Timestamp updatedAt;
        @PrePersist
    protected void onCreate() {
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = new Timestamp(System.currentTimeMillis());
    }
}
