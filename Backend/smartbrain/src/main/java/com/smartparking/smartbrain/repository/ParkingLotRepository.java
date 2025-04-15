package com.smartparking.smartbrain.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.ParkingLot;

@Repository
public interface ParkingLotRepository extends JpaRepository<ParkingLot, String> {
    @Query(value = """
        SELECT p.*, ST_DistanceSphere(
            point(:lon, :lat), point(p.longitude, p.latitude)
        ) AS distance
        FROM parking_lot p
        ORDER BY distance
        LIMIT 5
    """, nativeQuery = true)
    List<ParkingLot> findNearestParkingLots(@Param("lat") double latitude, @Param("lon") double longitude);

    List<ParkingLot> findByParkingLotName(String parkingLotName);
}