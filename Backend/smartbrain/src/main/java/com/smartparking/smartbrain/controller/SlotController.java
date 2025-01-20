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
import com.smartparking.smartbrain.dto.request.Slot.CreatedSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedParkingSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedStateParkingSlotRequest;
import com.smartparking.smartbrain.dto.request.Slot.UpdatedStatusParkingSlotRequest;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.service.SlotService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/myparkingapp/parkingslot")
public class SlotController {
    @Autowired
    private SlotService slotService;

     @PostMapping
    ApiRequest<ParkingSlot> createRequestParkingSlot(@RequestBody @Valid CreatedSlotRequest request){
        ApiRequest<ParkingSlot> apiRequest = new ApiRequest<ParkingSlot>();
        apiRequest.setCode(200);
        apiRequest.setMessage("parking spot created sucessfully");
        apiRequest.setResult(slotService.createParkingSlot(request));
        return apiRequest;
    }

    @GetMapping
    ApiRequest<List<ParkingSlot>> getParkingSlot(){
        ApiRequest<List<ParkingSlot>> apiRequest = new ApiRequest<List<ParkingSlot>>();
        apiRequest.setCode(200);
        apiRequest.setMessage("ParkingSlot fetched successfully");
        apiRequest.setResult(slotService.getParkingSlot());
        return apiRequest;
    }

    @GetMapping("/{id}")
    ApiRequest<ParkingSlot> getParkingSlotByID(@PathVariable String id){
        System.err.println("error"+id);
        ApiRequest<ParkingSlot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Parking spot fetched successfully");
        apiRequest.setResult(slotService.getParkingSlotByID(id));
        return apiRequest;
    }

    @GetMapping("/{slotName}/slotName")
    ApiRequest<ParkingSlot> getParkingSlotByName(@PathVariable String slotName){
        ApiRequest<ParkingSlot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Parking spot fetched successfully");
        apiRequest.setResult(slotService.getParkingSlotByName(slotName));
        return apiRequest;
    }

    @DeleteMapping("{id}")
    ApiRequest<String> deleteParkingSlot(@PathVariable String id){
        ApiRequest<String> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        slotService.deleteParkingSlot(id);
        apiRequest.setMessage("Parking spot deleted successfully");
        return apiRequest;
    }
    @PatchMapping("/{id}/status")
    ApiRequest<ParkingSlot> updateStatusParkingSlot(@PathVariable String id, @RequestBody UpdatedStatusParkingSlotRequest request){
        ApiRequest<ParkingSlot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("ParkingSlot Status update successfully");
        apiRequest.setResult(slotService.updatedStatusParkingSlot(id, request));
        return apiRequest;
    }
    @PatchMapping("/{id}/state")
    ApiRequest<ParkingSlot> updateStateParkingSlot(@PathVariable String id, @RequestBody UpdatedStateParkingSlotRequest request){
        ApiRequest<ParkingSlot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("ParkingSlot Status update successfully");
        apiRequest.setResult(slotService.updatedStateParkingSlot(id, request));
        return apiRequest;
    }
    @PutMapping("/{id}")
    ApiRequest<ParkingSlot> updateParkingSlot(@PathVariable String id, @RequestBody UpdatedParkingSlotRequest request){
        ApiRequest<ParkingSlot> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Parking spot update successfully");
        apiRequest.setResult(slotService.updateParkingSlot(id, request));
        return apiRequest;
    }
}
