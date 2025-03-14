package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.Discount.DiscountGlobalRequest;
import com.smartparking.smartbrain.dto.request.Discount.DiscountParkingLotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Discount.DiscountResponse;
import com.smartparking.smartbrain.service.DiscountService;

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
@RequestMapping("/myparkingapp/discounts")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class DiscountController {
    DiscountService discountService;
    @PostMapping("parkinglot")
    public ApiResponse<DiscountResponse> createParkingLotDiscount(@RequestBody @Valid DiscountParkingLotRequest request) {
        return ApiResponse.<DiscountResponse>builder()
        .result(discountService.createParkingLotDiscount(request))
        .build();
    }
    @PostMapping("global")
    public ApiResponse<DiscountResponse> createGlobalDiscount(@RequestBody @Valid DiscountGlobalRequest request) {
        return ApiResponse.<DiscountResponse>builder()
        .result(discountService.createGlobalDiscount(request))
        .build();
    }
    
    @GetMapping("/{parkingLotID}")
    public ApiResponse<List<DiscountResponse>> getAllDiscount(@PathVariable String parkingLotID) {
        return ApiResponse.<List<DiscountResponse>>builder()
        .result(discountService.getAllDiscount(parkingLotID))
        .build();
    }
    @GetMapping("/{discountID}")
    public ApiResponse<DiscountResponse> getDiscountByID(@PathVariable String discountID) {
        return ApiResponse.<DiscountResponse>builder()
        .result(discountService.getDiscount(discountID))
        .build();
    }
    @DeleteMapping("/{discountID}")
    public ApiResponse<Void> deletedDiscountByID(@PathVariable String discountID){
        return ApiResponse.<Void>builder()
        .code(200)
        .message(" Discount has been deleted successfully")
        .build();
    }
    
    
    
}
