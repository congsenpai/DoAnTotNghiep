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
import com.smartparking.smartbrain.dto.request.ApiRequest;
import com.smartparking.smartbrain.dto.request.ParkingSpotRequest;
import com.smartparking.smartbrain.model.ParkingSpot;
import com.smartparking.smartbrain.service.ParkingSpotSevice;
import jakarta.validation.Valid;


@RestController
@RequestMapping("/myparkingapp/parkingspot")
public class ParkingSpotController {
    @Autowired
    private ParkingSpotSevice parkingSpotSevice;

    @PostMapping
    ApiRequest<ParkingSpot> createRequestParkingSpot(@RequestBody @Valid ParkingSpotRequest request){
        ApiRequest<ParkingSpot> apiRequest = new ApiRequest<ParkingSpot>();
        apiRequest.setCode(200);
        apiRequest.setMessage("parking spot created sucessfully");
        apiRequest.setResult(parkingSpotSevice.createParkingSpot(request));
        return apiRequest;
    }

    @GetMapping
    ApiRequest<List<ParkingSpot>> getParkingSpot(){
        ApiRequest<List<ParkingSpot>> apiRequest = new ApiRequest<List<ParkingSpot>>();
        apiRequest.setCode(200);
        apiRequest.setMessage("ParkingSpot fetched successfully");
        apiRequest.setResult(parkingSpotSevice.getParkingSpot());
        return apiRequest;
    }

    @GetMapping("/{id}")
    ApiRequest<ParkingSpot> getParkingSpotByID(@PathVariable String id){
        ApiRequest<ParkingSpot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Parking spot fetched successfully");
        apiRequest.setResult(parkingSpotSevice.getParkingSpotByID(id));
        return apiRequest;
    }

    @DeleteMapping
    ApiRequest<String> deleteParkingSpot(@PathVariable String id){
        ApiRequest<String> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        parkingSpotSevice.deleteParkingSpot(id);;
        apiRequest.setMessage("Parking spot deleted successfully");
        return apiRequest;
    }
    @PatchMapping("/{id}/status")
    ApiRequest<ParkingSpot> updateStateParkingSpot(@PathVariable String id, @RequestBody ParkingSpotRequest request){
        ApiRequest<ParkingSpot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("ParkingSpot Status update successfully");
        apiRequest.setResult(parkingSpotSevice.updatedStatusParkingSpot(id, request));
        return apiRequest;
    }
    @PutMapping("/{id}")
    ApiRequest<ParkingSpot> updateParkingSpot(@PathVariable String id, @RequestBody ParkingSpotRequest request){
        ApiRequest<ParkingSpot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Parking spot update successfully");
        apiRequest.setResult(parkingSpotSevice.updateParkingSpot(id, request));
        return apiRequest;
    }
}
