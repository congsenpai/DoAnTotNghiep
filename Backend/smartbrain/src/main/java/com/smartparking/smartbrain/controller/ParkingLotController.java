package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.PagedResponse;
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

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
        .code(200)
        .message("Parking lot created successfully")
        .result(parkingLotService.createParkingLot(request))
        .build();
    }

    @GetMapping
    public ApiResponse<List<ParkingLotResponse>> getAllParkingLot() {
        return ApiResponse.<List<ParkingLotResponse>>builder()
        .code(200)
        .result(parkingLotService.getAllParkingLot())
        .message("Parking lots retrieved successfully")
        .build();
    }

    @GetMapping("/{ParkingLotID}")
    public ApiResponse<ParkingLotResponse> getParkingLotByID(@PathVariable String ParkingLotID) {
        return ApiResponse.<ParkingLotResponse>builder()
        .code(200)
        .result(parkingLotService.getParkingLotByID(ParkingLotID))
        .message("Parking lot retrieved successfully")
        .build();
    }

    @GetMapping("/{ParkingLotID}/parkingslots")
    public ApiResponse<List<ParkingSlotResponse>> getAllParkingSlotByParkingLot(@PathVariable String ParkingLotID) {
        return ApiResponse.<List<ParkingSlotResponse>>builder()
        .code(200)
        .result(parkingSlotService.getAllParkingSlotByParkingLotID(ParkingLotID))
        .message("Parking slots retrieved successfully")
        .build();
    }
    @GetMapping("/{ParkingLotID}/discounts")
    public ApiResponse<List<DiscountResponse>> getAllDiscountByParkingLot(@PathVariable String ParkingLotID) {
        return ApiResponse.<List<DiscountResponse>>builder()
        .code(200)
        .result(discountService.getAllDiscountByParkingLotID(ParkingLotID))
        .message("Discounts retrieved successfully")
        .build();
    }
    

    @DeleteMapping("/{ParkingLotID}")
    public ApiResponse<Void> deleteParkingLot(@PathVariable String ParkingLotID) {
        parkingLotService.deleteParkingLot(ParkingLotID);
        return ApiResponse.<Void>builder()
        .code(200)
        .message(ParkingLotID + " has been deleted")
        .build();
    }
    @GetMapping("/search")
    public ApiResponse<List<ParkingLotResponse>> findParkingLotByName(@RequestParam String name) {
        return ApiResponse.<List<ParkingLotResponse>>builder()
        .code(200)
        .result(parkingLotService.findByParkingLotName(name))
        .message("Parking lots retrieved successfully")
        .build();
    }
    @GetMapping("/nearby")
    public ApiResponse<List<ParkingLotResponse>> findNearestParkingLot(@RequestParam double lat, @RequestParam double lon) {
        return ApiResponse.<List<ParkingLotResponse>>builder()
        .code(200)
        .result(parkingLotService.findNearestParkingLot(lat, lon))
        .message("Parking lots retrieved successfully")
        .build();
    }
    @GetMapping("/parking-lots")
    public ApiResponse<PagedResponse<ParkingLotResponse>> getParkingLots(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        PagedResponse<ParkingLotResponse> response = parkingLotService.getAllParkingLot(PageRequest.of(page, size));
        return ApiResponse.<PagedResponse<ParkingLotResponse>>builder()
        .code(200)
        .result(response)
        .message("Parking lots retrieved successfully")
        .build();
    }


    
    
    
    
}
