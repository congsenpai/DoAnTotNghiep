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

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class ParkingSlot {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String SlotID;
    private String slotName;
    private String location;
    private int isState;
    private boolean status;
    private boolean typeVehicle;
    private Timestamp createdDate;
    private Timestamp updatedDate;


    @ManyToOne
    @JoinColumn(name = "parkingSpotID",nullable = false)
    private ParkingSpot parkingSpot;
}
