package com.smartparking.smartbrain.service;


import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import com.smartparking.smartbrain.dto.request.Slot.CreatedSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedParkingSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedStateParkingSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedStatusParkingSlotRequest;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.model.ParkingSpot;
import com.smartparking.smartbrain.repository.ParkingSpotRepository;
import com.smartparking.smartbrain.repository.SlotRepository;

@Service
public class SlotService {
    private SlotRepository slotRepository;
    private ParkingSpotRepository parkingSpotRepository;
    public ParkingSlot createParkingSlot(CreatedSlotRequest request){
        ParkingSlot parkingSlot = new ParkingSlot();
        if(slotRepository.existsByslotName(request.getSlotName()) && parkingSpotRepository.existsByParkingSpotID(request.getParkingSpotID())){
            throw new AppException(ErrorCode.SLOT_ALREADY_EXISTS);
        }

    
        parkingSlot.setSlotName(request.getSlotName());
        parkingSlot.setLocation(request.getLocation());
        parkingSlot.setIsState(request.getIsState());
        parkingSlot.setStatus(request.isStatus());
        parkingSlot.setTypeVehicle(request.isTypeVehicle());
        parkingSlot.setCreatedDate(Timestamp.from(Instant.now()));
        parkingSlot.setUpdatedDate(Timestamp.from(Instant.now()));

        Optional<ParkingSpot> parkingSpot = parkingSpotRepository.findById(request.getParkingSpotID());
        if(parkingSpot.isEmpty()){
            throw new AppException(ErrorCode.PARKINGSPOT_NOT_FOUND);
        }
        parkingSlot.setParkingSpot(parkingSpot.get());

        return slotRepository.save(parkingSlot);
    }
    public List<ParkingSlot> getParkingSlot(){
        return slotRepository.findAll();
    }

    public ParkingSlot getParkingSlotByID(String id){
        return slotRepository.findById(id).orElseThrow(
            () -> new RuntimeException("ErrorCode.SLOT_NOT_EXISTS")
        );
    }
    public ParkingSlot getParkingSlotByName(String name){
        return slotRepository.findBySlotName(name).orElseThrow(
            () -> new RuntimeException("ErrorCode.SLOT_NOT_EXISTS")
        );
    }

    public void deleteParkingSlot(String id){
        if(!slotRepository.existsById(id)){
            throw new RuntimeException("ErrorCode.SLOT_NOT_EXISTS");
        }
        slotRepository.deleteById(id);
    }

    public ParkingSlot updatedStatusParkingSlot(String id, UpdatedStatusParkingSlotRequest request){
        ParkingSlot parkingSlot = slotRepository.findById(id).get();
        parkingSlot.setStatus(request.isStatus());
        return slotRepository.save(parkingSlot);
        };
    public ParkingSlot updatedStateParkingSlot(String id, UpdatedStateParkingSlotRequest request){
        ParkingSlot parkingSlot = slotRepository.findById(id).get();
        parkingSlot.setIsState(request.getState());
        return slotRepository.save(parkingSlot);
        };
    
    public ParkingSlot updateParkingSlot(String id, UpdatedParkingSlotRequest request){
        ParkingSlot parkingSlot = slotRepository.findById(id).get();
        if(slotRepository.existsByslotName(request.getSlotName()) && parkingSpotRepository.existsByParkingSpotID(request.getParkingSpotID())){
            throw new AppException(ErrorCode.SLOT_ALREADY_EXISTS);
        }
        parkingSlot.setSlotName(request.getSlotName());
        parkingSlot.setLocation(request.getLocation());
        parkingSlot.setIsState(request.getIsState());
        parkingSlot.setStatus(request.isStatus());
        parkingSlot.setTypeVehicle(request.isTypeVehicle());
        parkingSlot.setCreatedDate(Timestamp.from(Instant.now()));
        parkingSlot.setUpdatedDate(Timestamp.from(Instant.now()));
        
        return slotRepository.save(parkingSlot);
    }
    
    

}
