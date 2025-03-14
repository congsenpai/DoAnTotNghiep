package com.smartparking.smartbrain.service;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.request.ParkingLot.LocationConfig;
import com.smartparking.smartbrain.dto.request.ParkingLot.VehicleSlotConfig;
import com.smartparking.smartbrain.dto.response.ParkingLot.ParkingLotResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.ParkingLotMapper;
import com.smartparking.smartbrain.mapper.ParkingSlotMapper;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.ImagesRepository;
import com.smartparking.smartbrain.repository.ParkingLotRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ParkingLotService {
    ParkingLotRepository parkingLotRepository;
    ParkingLotMapper parkingLotMapper;
    UserRepository userRepository;
    ImagesRepository imagesRepository;
    ParkingSlotRepository parkingSlotRepository;
    ParkingSlotMapper parkingSlotMapper;

    public ParkingLotResponse createParkingLot(@Valid CreatedParkingLotRequest createdParkingLotRequest) {
        // check user exist
        User user= userRepository.findById(createdParkingLotRequest.getUserID())
        .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        var parkingLot = parkingLotMapper.toParkingLot(createdParkingLotRequest);
        parkingLot.setUser(user);
        parkingLotRepository.save(parkingLot);

        // create list of image and save to database
        Set<Image> images = createdParkingLotRequest.getImages().stream().map(image -> {
            Image img = new Image();
            img.setUrl(image.toString());
            img.setParkingLot(parkingLot);
            return img;
        }).collect(Collectors.toSet());
        imagesRepository.saveAll(images); // Lưu danh sách ảnh 1 lần
        parkingLot.setImages(images);

        // create list of slot and save to database
        
        for (LocationConfig location : createdParkingLotRequest.getLocationConfigs()) {
            AtomicInteger slotCounter = new AtomicInteger(0); // Reset số đếm theo từng Location
            for (VehicleSlotConfig vehicleSlotConfig : location.getVehicleSlotConfigs()) {
                int numSlots = vehicleSlotConfig.getNumberOfSlot(); // Số lượng slot cho loại xe này
                for (int i = 0; i < numSlots; i++) {
                // Định dạng số slot theo A00, A01, ..., A99 rồi tiếp tục A100 nếu cần
                    String slotName = String.format("%s%02d", location.getLocation(), slotCounter.getAndIncrement());
                    ParkingSlot parkingSlot = ParkingSlot.builder()
                        .slotName(slotName)
                        .parkingLot(parkingLot)
                        .pricePerHour(vehicleSlotConfig.getPricePerHour())
                        .pricePerMonth(vehicleSlotConfig.getPricePerMonth())
                        .vehicleType(vehicleSlotConfig.getVehicleType())
                        .build();
                    parkingSlotRepository.save(parkingSlot);
                }
            }
        }
        // create reponse
        ParkingLotResponse response= parkingLotMapper.toParkingLotResponse(parkingLot);
        response.setUserID(parkingLot.getUser().getUserID());
        response.setImages(createdParkingLotRequest.getImages());
        var slots = parkingSlotRepository.findByParkingLot(parkingLot);
        response.setParkingSlots(slots.stream().map(parkingSlotMapper::toParkingSlotResponse).collect(Collectors.toSet()));
        return response;
    }
    public ParkingLotResponse getParkingLotByID(String parkingLotID) {
        var parkingLot = parkingLotRepository.findById(parkingLotID)
        .orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_FOUND));
        ParkingLotResponse response= parkingLotMapper.toParkingLotResponse(parkingLot);
        response.setUserID(parkingLot.getUser().getUserID());
        response.setImages(parkingLot.getImages().stream().map(Image::getUrl).collect(Collectors.toSet()));
        return response;
    }
    public List<ParkingLotResponse> getAllParkingLot() {

        return parkingLotRepository.findAll().stream().map(parkingLot -> {
            ParkingLotResponse response= parkingLotMapper.toParkingLotResponse(parkingLot);
            response.setUserID(parkingLot.getUser().getUserID());
            response.setImages(parkingLot.getImages().stream().map(Image::getUrl).collect(Collectors.toSet()));
            return response;
        }).collect(Collectors.toList());
    }

    public void deleteParkingLot(String parkingLotID) {
        parkingLotRepository.deleteById(parkingLotID);
    }
}
