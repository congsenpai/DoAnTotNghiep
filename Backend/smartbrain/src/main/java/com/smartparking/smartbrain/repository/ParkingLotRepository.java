package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.ParkingLot;

@Repository
public interface ParkingLotRepository extends JpaRepository<ParkingLot, String> {

    
}