package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.dto.request.ParkingSlot.CreatedParkingSlotRequest;
import com.smartparking.smartbrain.dto.response.ParkingSlot.ParkingSlotResponse;
import com.smartparking.smartbrain.model.ParkingSlot;

@Mapper(componentModel = "spring")
public interface ParkingSlotMapper {
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "invoice", ignore = true)
    @Mapping(target = "monthlyTicket", ignore = true)
    @Mapping(target = "parkingLot", ignore = true)
    @Mapping(target = "slotId", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    ParkingSlot toParkingSlot(CreatedParkingSlotRequest request);

    ParkingSlotResponse toParkingSlotResponse(ParkingSlot parkingSlot);
}
