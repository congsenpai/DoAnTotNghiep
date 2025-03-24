package com.smartparking.smartbrain.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Entity
@Getter
@Table(name = "ratings")
@Setter
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Rating {
    @Id
    @Column(name = "rating_id", nullable = false, updatable = false)
    @GeneratedValue(strategy = GenerationType.UUID)
    String ratingID;
    int ratingValue;
    String comment;

    // relationship
    @ManyToOne
    @JoinColumn(name = "parking_lot_id",nullable = false)
    ParkingLot parkingLot;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;


}
