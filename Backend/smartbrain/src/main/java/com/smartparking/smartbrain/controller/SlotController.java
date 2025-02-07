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

import com.smartparking.smartbrain.dto.request.Slot.CreatedSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedParkingSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedStateParkingSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedStatusParkingSlotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.service.SlotService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/myparkingapp/parkingslot")
public class SlotController {
    @Autowired
    private SlotService slotService;

     @PostMapping
    ApiResponse<ParkingSlot> createRequestParkingSlot(@RequestBody @Valid CreatedSlotRequest request){
        ApiResponse<ParkingSlot> ApiResponse = new ApiResponse<ParkingSlot>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("parking spot created sucessfully");
        ApiResponse.setResult(slotService.createParkingSlot(request));
        return ApiResponse;
    }

    @GetMapping
    ApiResponse<List<ParkingSlot>> getParkingSlot(){
        ApiResponse<List<ParkingSlot>> ApiResponse = new ApiResponse<List<ParkingSlot>>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("ParkingSlot fetched successfully");
        ApiResponse.setResult(slotService.getParkingSlot());
        return ApiResponse;
    }

    @GetMapping("/{id}")
    ApiResponse<ParkingSlot> getParkingSlotByID(@PathVariable String id){
        System.err.println("error"+id);
        ApiResponse<ParkingSlot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Parking spot fetched successfully");
        ApiResponse.setResult(slotService.getParkingSlotByID(id));
        return ApiResponse;
    }

    @GetMapping("/{slotName}/slotName")
    ApiResponse<ParkingSlot> getParkingSlotByName(@PathVariable String slotName){
        ApiResponse<ParkingSlot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Parking spot fetched successfully");
        ApiResponse.setResult(slotService.getParkingSlotByName(slotName));
        return ApiResponse;
    }

    @DeleteMapping("{id}")
    ApiResponse<String> deleteParkingSlot(@PathVariable String id){
        ApiResponse<String> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        slotService.deleteParkingSlot(id);
        ApiResponse.setMessage("Parking spot deleted successfully");
        return ApiResponse;
    }
    @PatchMapping("/{id}/status")
    ApiResponse<ParkingSlot> updateStatusParkingSlot(@PathVariable String id, @RequestBody UpdatedStatusParkingSlotRequest request){
        ApiResponse<ParkingSlot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("ParkingSlot Status update successfully");
        ApiResponse.setResult(slotService.updatedStatusParkingSlot(id, request));
        return ApiResponse;
    }
    @PatchMapping("/{id}/state")
    ApiResponse<ParkingSlot> updateStateParkingSlot(@PathVariable String id, @RequestBody UpdatedStateParkingSlotRequest request){
        ApiResponse<ParkingSlot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("ParkingSlot Status update successfully");
        ApiResponse.setResult(slotService.updatedStateParkingSlot(id, request));
        return ApiResponse;
    }
    @PutMapping("/{id}")
    ApiResponse<ParkingSlot> updateParkingSlot(@PathVariable String id, @RequestBody UpdatedParkingSlotRequest request){
        ApiResponse<ParkingSlot> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Parking spot update successfully");
        ApiResponse.setResult(slotService.updateParkingSlot(id, request));
        return ApiResponse;
    }
}
