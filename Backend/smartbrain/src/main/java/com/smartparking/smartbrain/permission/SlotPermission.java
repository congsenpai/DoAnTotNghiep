package com.smartparking.smartbrain.permission;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Component
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SlotPermission {
    @Autowired
    ParkingSlotRepository parkingSlotRepository;
    public boolean canOrderSlot(String parkingSlotId) {
        if (parkingSlotId == null) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }else {
            // Lấy ParkingSlot từ DB
            ParkingSlot slot = parkingSlotRepository.findById(parkingSlotId)
            .orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));
            // Kiểm tra slot có đang được sử dụng không
            if (slot.getSlotStatus().equals(SlotStatus.AVAILABLE)) {
                return true;
            }else{
                return false;
            }
        }
    }
}
