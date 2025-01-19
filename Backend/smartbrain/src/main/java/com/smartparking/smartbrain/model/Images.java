package com.smartparking.smartbrain.model;
import java.sql.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class Images {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String imagesID;
    private String urlString;
    private String noteString;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private boolean status;

    @ManyToOne
    @JoinColumn(name = "parkingSpotID",nullable = false)
    private ParkingSpot parkingSpot;
}
