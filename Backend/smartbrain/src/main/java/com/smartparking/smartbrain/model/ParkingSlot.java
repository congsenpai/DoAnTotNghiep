package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

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
    String slotID;
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
    @OneToMany(mappedBy = "parkingSlot")
    Set<MonthlyTicket> monthlyTickets;

    // Timestamp
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    Instant createdAt;
    @UpdateTimestamp
    @Column(name = "updated_at")
    Instant updatedAt;


}
