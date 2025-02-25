package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.ParkingLot.ParkingLotResponse;
import com.smartparking.smartbrain.service.ParkingLotService;

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



@RestController
@RequestMapping("/myparkingapp/parkinglots")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ParkingLotController {
    ParkingLotService parkingLotService;
    
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
    

    @DeleteMapping("/{ParkingLotID}")
    public ApiResponse<Void> deleteParkingLot(@PathVariable String ParkingLotID) {
        parkingLotService.deleteParkingLot(ParkingLotID);
        return ApiResponse.<Void>builder()
        .message(ParkingLotID + " has been deleted")
        .build();
    }
    
    
}
