package com.smartparking.smartbrain.model;

import java.time.Instant;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
@Table(name = "monthly_tickets")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class MonthlyTicket {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "monthly_ticket_id", nullable = false, updatable = false)
    String monthlyTicketID;

    // Relationship
    @ManyToOne
    @JoinColumn(name = "parking_slot_id", nullable = false)
    ParkingSlot parkingSlot;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;
    @OneToOne(fetch = FetchType.LAZY)
    @JsonIgnore
    @JoinColumn(name = "invoice_id", nullable = false)
    Invoice invoice;

    // Timestamp
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    Instant createdAt;
    @UpdateTimestamp
    @Column(name = "updated_at")
    Instant updatedAt;
    @Column(name="expired_at",nullable = false)
    Instant expiredAt;
    @Column(name="started_at",nullable = false)
    Instant startedAt;
}
