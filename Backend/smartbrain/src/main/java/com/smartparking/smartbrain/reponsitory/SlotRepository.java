package com.smartparking.smartbrain.reponsitory;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.ParkingSlot;

@Repository
public interface SlotRepository extends JpaRepository<ParkingSlot,String>{
    boolean existsByslotName(String slotName);
    Optional<ParkingSlot> findBySlotName(String SlotName);
}
