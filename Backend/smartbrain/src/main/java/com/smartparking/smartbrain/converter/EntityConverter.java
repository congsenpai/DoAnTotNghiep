package com.smartparking.smartbrain.converter;
import org.mapstruct.Named;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.Name;
import org.springframework.stereotype.Component;

import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.Discount;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.model.ParkingLot;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.model.Vehicle;
import com.smartparking.smartbrain.repository.DiscountRepository;
import com.smartparking.smartbrain.repository.ImagesRepository;
import com.smartparking.smartbrain.repository.ParkingLotRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;
import com.smartparking.smartbrain.repository.UserRepository;
import com.smartparking.smartbrain.repository.VehicleRepository;

@Component
public class EntityConverter {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private VehicleRepository vehicleRepository;

    @Autowired
    private ParkingSlotRepository parkingSlotRepository;

    @Autowired
    private DiscountRepository discountRepository;
    @Autowired
    private ParkingLotRepository parkingLotRepository;

    @Autowired
    private ImagesRepository imagesRepository;

    @Named("mapUser")
    public User mapUser(String userId) {
        return userId != null ? userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTS)) : null;
    }

    @Named("mapVehicle")
    public Vehicle mapVehicle(String vehicleId) {
        if (vehicleId == null) return null;
    
        Vehicle vehicle = vehicleRepository.findById(vehicleId)
            .orElseThrow(() -> new AppException(ErrorCode.VEHICLE_NOT_EXISTS));
    
        if (vehicle.isDeleted()) {
            throw new AppException(ErrorCode.VEHICLE_NOT_FOUND);
        }
    
        return vehicle;
    }
    

    @Named("mapParkingSlot")
    public ParkingSlot mapParkingSlot(String slotId) {
        return slotId != null ? parkingSlotRepository.findById(slotId)
                .orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS)) : null;
    }

    @Named("mapDiscount")
    public Discount mapDiscount(String discountCode) {
        return discountCode != null ? discountRepository.findByDiscountCode(discountCode)
                .orElseThrow(() -> new AppException(ErrorCode.DISCOUNT_NOT_EXISTS)) : null;
    }
    @Named("mapParkingLot")
    public ParkingLot mapParkingLot(String parkingLotId) {
        return parkingLotId != null ? parkingLotRepository.findById(parkingLotId)
                .orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_EXISTS)) : null;
    }
    @Named("mapImage")
    public Image mapImage(String imageId) {
        return imageId!=null? imagesRepository.findById(imageId)
                .orElseThrow(() -> new AppException(ErrorCode.IMAGE_NOT_EXISTS)) : null;
    }
    
}
