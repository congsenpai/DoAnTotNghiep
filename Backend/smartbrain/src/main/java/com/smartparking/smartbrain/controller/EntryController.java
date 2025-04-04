package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.Entry.EntryRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.service.EntryService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/myparkingapp/entry")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EntryController {
    EntryService entryService;
    @GetMapping("enter")
    public ApiResponse<Void> enterParkingLot(@RequestBody @Valid EntryRequest request) {
        entryService.enterParkingLot(request);
        return ApiResponse.<Void>builder()
        .message("QR valid, open the barier. Welcome")
        .build();
    }
    @GetMapping("leave")
    public ApiResponse<Void> leaveParkingLot(@RequestBody @Valid EntryRequest request) {
        entryService.leaveParkingLot(request);
        return ApiResponse.<Void>builder()
        .message("QR valid, open the barier. See you again")
        .build();
    }
    
    
}
