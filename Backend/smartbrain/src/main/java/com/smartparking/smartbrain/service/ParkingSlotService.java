package com.smartparking.smartbrain.service;

import java.util.List;

import org.springframework.stereotype.Service;


import com.smartparking.smartbrain.dto.request.ParkingSlot.CreatedParkingSlotRequest;
import com.smartparking.smartbrain.dto.response.ParkingSlot.ParkingSlotResponse;
import com.smartparking.smartbrain.enums.VehicleType;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.ParkingSlotMapper;
import com.smartparking.smartbrain.model.ParkingLot;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.repository.ParkingLotRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ParkingSlotService {
    ParkingSlotRepository parkingSlotRepository;
    ParkingSlotMapper parkingSlotMapper;
    ParkingLotRepository parkingLotRepository;

    public ParkingSlotResponse createParkingSlot(CreatedParkingSlotRequest request){
        ParkingLot parkingLot = parkingLotRepository.findById(request.getParkingLotID())
        .orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_FOUND));

        ParkingSlot parkingSlot = parkingSlotMapper.toParkingSlot(request);
        parkingSlot.setParkingLot(parkingLot);
        parkingSlot = parkingSlotRepository.save(parkingSlot);
        return parkingSlotMapper.toParkingSlotResponse(parkingSlot);
    }

    public ParkingSlotResponse getParkingSlot(String parkingSlotID){
        ParkingSlot parkingSlot = parkingSlotRepository.findById(parkingSlotID)
        .orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_FOUND));
        return parkingSlotMapper.toParkingSlotResponse(parkingSlot);
    }

    public List<ParkingSlotResponse> getAllParkingSlot(String parkingLotID){
        ParkingLot parkingLot= parkingLotRepository.findById(parkingLotID)
        .orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_FOUND));
        List<ParkingSlot> parkingSlots = parkingSlotRepository.findByParkingLot(parkingLot);
        return parkingSlots.stream().map(parkingSlotMapper::toParkingSlotResponse).toList();
    }
    
    public List<ParkingSlotResponse> autoCreateParkingSlot(CreatedParkingSlotRequest request){
        ParkingLot parkingLot = parkingLotRepository.findById(request.getParkingLotID())
        .orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_FOUND));

        int totalSlot = parkingLot.getTotalSlot();
        if(totalSlot>2500){
            throw new AppException(ErrorCode.TOTAL_SLOT_EXCEED);
        }
        char section = 'A';
        int startNumber = 0;
        int endNumber=0;
        int numberOfSlot=0;
    
        if (request.getVehicleType()==VehicleType.MOTORCYCLE.toString()) {
            startNumber=20;
            endNumber=89;
            numberOfSlot=parkingLot.getTotalSlot()*70/100;
        } else if (request.getVehicleType()==VehicleType.CAR.toString()) {
            startNumber=0;
            endNumber=19;
            numberOfSlot=parkingLot.getTotalSlot()*20/100;
        } else if (request.getVehicleType()==VehicleType.BICYCLE.toString()) {
            startNumber=90;
            endNumber=99;
            numberOfSlot=parkingLot.getTotalSlot()*10/100;
        }
        int curr=startNumber;
        for (int i = 0; i < numberOfSlot; i++) {
            
            ParkingSlot parkingSlot = parkingSlotMapper.toParkingSlot(request);
            parkingSlot.setParkingLot(parkingLot);
            
            // Định dạng tên slot theo dạng A00, A01, ..., A99, B00,...
            String slotName = String.format("%c%02d", section, curr);
            parkingSlot.setSlotName(slotName);
            parkingSlotRepository.save(parkingSlot);
            
            curr++;
            if (curr > endNumber) {
                curr=startNumber;
                section++;
            }
        }
        return getAllParkingSlot(request.getParkingLotID());
    }

}
