package com.smartparking.smartbrain.reponsitory;

import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.ParkingSpot;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;


@Repository
public interface ParkingSpotRepository extends JpaRepository<ParkingSpot, String> {
    boolean existsByParkingSpotName( String parkingSpotName);
    boolean existsByParkingSpotID(String parkingSpotID);
    Optional<ParkingSpot> findByParkingSpotName(String parkingSpotName);
}
