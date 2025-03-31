package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Discount.DiscountResponse;
import com.smartparking.smartbrain.dto.response.ParkingLot.ParkingLotResponse;
import com.smartparking.smartbrain.dto.response.ParkingSlot.ParkingSlotResponse;
import com.smartparking.smartbrain.service.DiscountService;
import com.smartparking.smartbrain.service.ParkingLotService;
import com.smartparking.smartbrain.service.ParkingSlotService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/myparkingapp/parkinglots")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ParkingLotController {

    ParkingLotService parkingLotService;
    ParkingSlotService parkingSlotService;
    DiscountService discountService;

    @PostMapping
    public ApiResponse<ParkingLotResponse> createParkingLot(@Valid @RequestBody CreatedParkingLotRequest request) {
        return ApiResponse.<ParkingLotResponse>builder()
        .result(parkingLotService.createParkingLot(request))
        .build();
    }

    @GetMapping
    public ApiResponse<List<ParkingLotResponse>> getAllParkingLot() {
        return ApiResponse.<List<ParkingLotResponse>>builder()
        .result(parkingLotService.getAllParkingLot())
        .build();
    }

    @GetMapping("/{ParkingLotID}")
    public ApiResponse<ParkingLotResponse> getParkingLotByID(@PathVariable String ParkingLotID) {
        return ApiResponse.<ParkingLotResponse>builder()
        .result(parkingLotService.getParkingLotByID(ParkingLotID))
        .build();
    }

    @GetMapping("/{ParkingLotID}/parkingslots")
    public ApiResponse<List<ParkingSlotResponse>> getAllParkingSlotByParkingLot(@PathVariable String ParkingLotID) {
        return ApiResponse.<List<ParkingSlotResponse>>builder()
        .result(parkingSlotService.getAllParkingSlotByParkingLotID(ParkingLotID))
        .build();
    }
    @GetMapping("/{ParkingLotID}/discounts")
    public ApiResponse<List<DiscountResponse>> getAllDiscountByParkingLot(@PathVariable String ParkingLotID) {
        return ApiResponse.<List<DiscountResponse>>builder()
        .result(discountService.getAllDiscountByParkingLotID(ParkingLotID))
        .build();
    }
    

    @DeleteMapping("/{ParkingLotID}")
    public ApiResponse<Void> deleteParkingLot(@PathVariable String ParkingLotID) {
        parkingLotService.deleteParkingLot(ParkingLotID);
        return ApiResponse.<Void>builder()
        .message(ParkingLotID + " has been deleted")
        .build();
    }
    @GetMapping("/search")
    public ApiResponse<List<ParkingLotResponse>> findParkingLotByName(@RequestParam String name) {
        return ApiResponse.<List<ParkingLotResponse>>builder()
        .result(parkingLotService.findByParkingLotName(name))
        .build();
    }
    @GetMapping("/nearby")
    public ApiResponse<List<ParkingLotResponse>> findNearestParkingLot(@RequestParam double lat, @RequestParam double lon) {
        return ApiResponse.<List<ParkingLotResponse>>builder()
        .result(parkingLotService.findNearestParkingLot(lat, lon))
        .build();
    }
    
    
    
    
}
