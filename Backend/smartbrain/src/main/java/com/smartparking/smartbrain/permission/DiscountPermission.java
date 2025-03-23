package com.smartparking.smartbrain.permission;


import java.util.Objects;

import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Autowired;

import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.Discount;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.repository.DiscountRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class DiscountPermission {

    @Autowired
    DiscountRepository discountRepository;

    @Autowired
    ParkingSlotRepository parkingSlotRepository;

    public boolean canAccessDiscount(String discountCode, String parkingSlotId) {
        // Kiểm tra null
        if (discountCode == null || parkingSlotId == null) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        // Lấy Discount từ DB
        Discount discount = discountRepository.findByDiscountCode(discountCode)
            .orElseThrow(() -> new AppException(ErrorCode.DISCOUNT_NOT_EXISTS));

        // Nếu là Global Discount thì cho phép
        if (Boolean.TRUE.equals(discount.getIsGlobalDiscount())) {
            return true;
        }

        // Lấy ParkingSlot từ DB
        ParkingSlot slot = parkingSlotRepository.findById(parkingSlotId)
            .orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));

        // Kiểm tra Discount có thuộc ParkingLot của ParkingSlot không
        if (discount.getParkingLot() != null && slot.getParkingLot() != null) {
            if (Objects.equals(discount.getParkingLot().getParkingLotID(), slot.getParkingLot().getParkingLotID())) {
                log.info("Discount valid");
                return true;
            }
        }

        throw new AppException(ErrorCode.DISCOUNT_NOT_BELONG_TO_PARKING_SLOT);
    }
}
