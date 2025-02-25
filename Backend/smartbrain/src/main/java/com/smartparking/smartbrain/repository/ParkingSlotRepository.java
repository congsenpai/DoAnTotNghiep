package com.smartparking.smartbrain.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.ParkingLot;
import com.smartparking.smartbrain.model.ParkingSlot;

@Repository
public interface ParkingSlotRepository extends JpaRepository<ParkingSlot, String> {

    List<ParkingSlot> findByParkingLot(ParkingLot parkingLot);

}
