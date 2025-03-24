package com.smartparking.smartbrain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.ParkingSlot;

@Repository
public interface ParkingSlotRepository extends JpaRepository<ParkingSlot, String> {

    List<ParkingSlot> findByParkingLot_ParkingLotID(String parkingLotID);
    @EntityGraph(attributePaths = {}) // Không fetch quan hệ nào
    @Query("SELECT p FROM ParkingSlot p WHERE p.slotID = :slotID")
    Optional<ParkingSlot> findParkingSlotWithoutRelations(@Param("slotID") String slotID);

}
