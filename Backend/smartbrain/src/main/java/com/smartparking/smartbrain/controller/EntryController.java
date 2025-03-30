package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.service.EntryService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/myparkingapp/entry")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EntryController {
    EntryService entryService;
    @GetMapping("enter")
    public ApiResponse<Void> enterParkingLot(@RequestParam String objectEncrypt) {
        entryService.enterParkingLot(objectEncrypt);
        return ApiResponse.<Void>builder()
        .message("QR valid, open the barier. Welcome")
        .build();
    }
    @GetMapping("out")
    public ApiResponse<Void> leaveParkingLot(@RequestParam String objectEncrypt) {
        return ApiResponse.<Void>builder()
        .message("QR valid, open the barier. See you again")
        .build();
    }
    
    
}
