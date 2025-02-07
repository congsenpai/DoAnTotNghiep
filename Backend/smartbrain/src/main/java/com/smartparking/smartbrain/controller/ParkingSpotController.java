package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.smartparking.smartbrain.dto.request.ParkingSpot.CreatedParkingSpotRequest;
import com.smartparking.smartbrain.dto.request.ParkingSpot.UpdatedParkingSpotRequest;
import com.smartparking.smartbrain.dto.request.ParkingSpot.UpdatedStatusParkingSpotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.model.ParkingSpot;
import com.smartparking.smartbrain.service.ParkingSpotSevice;
import jakarta.validation.Valid;


@RestController
@RequestMapping("/myparkingapp/parkingspots")
public class ParkingSpotController {
    @Autowired
    private ParkingSpotSevice parkingSpotSevice;

    @PostMapping
    ApiResponse<ParkingSpot> createRequestParkingSpot(@RequestBody @Valid CreatedParkingSpotRequest request){
        ApiResponse<ParkingSpot> ApiResponse = new ApiResponse<ParkingSpot>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("parking spot created sucessfully");
        ApiResponse.setResult(parkingSpotSevice.createParkingSpot(request));
        return ApiResponse;
    }

    @GetMapping
    ApiResponse<List<ParkingSpot>> getParkingSpot(){
        ApiResponse<List<ParkingSpot>> ApiResponse = new ApiResponse<List<ParkingSpot>>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("ParkingSpot fetched successfully");
        ApiResponse.setResult(parkingSpotSevice.getParkingSpot());
        return ApiResponse;
    }

    @GetMapping("/{id}")
    ApiResponse<ParkingSpot> getParkingSpotByID(@PathVariable String id){
        ApiResponse<ParkingSpot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Parking spot fetched successfully");
        ApiResponse.setResult(parkingSpotSevice.getParkingSpotByID(id));
        return ApiResponse;
    }

    @DeleteMapping("/{id}")
    ApiResponse<String> deleteParkingSpot(@PathVariable String id){
        ApiResponse<String> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        parkingSpotSevice.deleteParkingSpot(id);;
        ApiResponse.setMessage("Parking spot deleted successfully");
        return ApiResponse;
    }
    @PatchMapping("/{id}/status")
    ApiResponse<ParkingSpot> updateStateParkingSpot(@PathVariable String id, @RequestBody UpdatedStatusParkingSpotRequest request){
        ApiResponse<ParkingSpot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("ParkingSpot Status update successfully");
        ApiResponse.setResult(parkingSpotSevice.updatedStatusParkingSpot(id, request));
        return ApiResponse;
    }
    @PutMapping("/{id}")
    ApiResponse<ParkingSpot> updateParkingSpot(@PathVariable String id, @RequestBody UpdatedParkingSpotRequest request){
        ApiResponse<ParkingSpot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Parking spot update successfully");
        ApiResponse.setResult(parkingSpotSevice.updateParkingSpot(id, request));
        return ApiResponse;
    }
}
