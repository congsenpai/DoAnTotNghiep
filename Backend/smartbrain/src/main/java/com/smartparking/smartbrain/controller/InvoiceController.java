package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedDailyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedMonthlyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.PaymentDailyRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Invoice.InvoiceResponse;
import com.smartparking.smartbrain.service.InvoiceService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;



@RestController
@RequestMapping("/myparkingapp/invoices")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class InvoiceController {
    InvoiceService invoiceService;
    @PostMapping("/daily/deposit")
    public ApiResponse<InvoiceResponse> depositDailyInvoice(@Valid @RequestBody InvoiceCreatedDailyRequest request) {
        return ApiResponse.<InvoiceResponse>builder()
        .result(invoiceService.depositDailyInvoice(request))
        .build();
    }
    @PostMapping("/daily/payment")
    public ApiResponse<InvoiceResponse> paymentDailyInvoice(@Valid @RequestBody PaymentDailyRequest request) {
        return ApiResponse.<InvoiceResponse>builder()
        .result(invoiceService.paymentDailyInvoice(request))
        .build();
    }
    @PostMapping("/monthly")
    public ApiResponse<InvoiceResponse> createMonthlyInvoice(@Valid @RequestBody InvoiceCreatedMonthlyRequest request) {
        return ApiResponse.<InvoiceResponse>builder()
        .result(invoiceService.createMonthlyInvoice(request))
        .build();
    }
    @GetMapping("/{InvoiceID}")
    public ApiResponse<InvoiceResponse> getInvoiceByID(@PathVariable String InvoiceID) {
        return ApiResponse.<InvoiceResponse>builder()
        .result(invoiceService.getInvoiceByID(InvoiceID))
        .build();
    }
    @GetMapping("/{UserID}")
    public ApiResponse<List<InvoiceResponse>> getInvoiceByUserID(@PathVariable String UserID) {
        return ApiResponse.<List<InvoiceResponse>>builder()
        .result(invoiceService.getInvoiceByUserID(UserID))
        .build();
    }
    @GetMapping("")
    public ApiResponse<List<InvoiceResponse>> getAll() {
        return ApiResponse.<List<InvoiceResponse>>builder()
        .result(invoiceService.getAllInvoice())
        .build();
    }
    
    
    
    
    
}
