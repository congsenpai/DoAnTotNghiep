package com.smartparking.smartbrain.controller;
import com.smartparking.smartbrain.dto.request.Wallet.CreateWalletRequest;
import com.smartparking.smartbrain.dto.request.Wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.request.Wallet.TopUpRequest;
import com.smartparking.smartbrain.dto.request.Wallet.UpdateWalletRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Wallet.TransactionResponse;
import com.smartparking.smartbrain.dto.response.Wallet.WalletResponse;
import com.smartparking.smartbrain.service.WalletService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import java.util.List;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/myparkingapp/wallets")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WalletController {

    final WalletService walletService;

    // create wallet
    @PostMapping
    public ApiResponse<WalletResponse> createWallet(@RequestBody @Valid CreateWalletRequest request) {
    return ApiResponse.<WalletResponse>builder()
    .code(200)
    .message("create wallet successfully")
    .result(walletService.createWallet(request))
    .build();
    }
    // get wallet by id
    @GetMapping("/{walletId}")
    public ApiResponse<WalletResponse> getWalletById(@PathVariable String walletId) {
        return ApiResponse.<WalletResponse>builder()
        .code(200)
        .message("wallet data fetched successfully")
        .result(walletService.getWalletById(walletId))
        .build();
    }
    // get wallets by user id
    @GetMapping("/user/{userId}")
    public ApiResponse<List<WalletResponse>> getWalletsByUserId(@PathVariable String userId) {
        return ApiResponse.<List<WalletResponse>>builder()
        .code(200)
        .message("wallet data fetched successfully")
        .result(walletService.getWalletsByUser(userId))
        .build();
    }

    // update wallet
    @PutMapping("/{walletId}")
    public ApiResponse<WalletResponse> updateWallet(
            @PathVariable String walletId,
            @RequestBody @Valid UpdateWalletRequest request
    ) {
        return ApiResponse.<WalletResponse>builder()
        .code(200)
        .message("updated wallet successfully")
        .result(walletService.updateWallet(walletId, request))
        .build();
    }


    // delete wallet
    @DeleteMapping("/{walletId}")
    public ApiResponse<Void> deleteWallet(@PathVariable String walletId) {
        walletService.deleteWallet(walletId);
        return ApiResponse.<Void>builder()
        .code(200)
        .message("deleted wallet successfully")
        .build();
    }
    // recharge wallet - top up
    @PostMapping("/{walletId}/top-up")
    public ApiResponse<TransactionResponse> topUp(
            @PathVariable String walletId,
            @RequestBody @Valid TopUpRequest request
    ) {
        return ApiResponse.<TransactionResponse>builder()
        .code(200)
        .message("Wallet recharged successfully")
        .result(walletService.topUp(walletId, request))
        .build();
    }
    // make payment
    @PostMapping("/{walletId}/payment")
    public ApiResponse<TransactionResponse> makePayment(
            @PathVariable String walletId,
            @RequestBody @Valid PaymentRequest request
    ) {
        return ApiResponse.<TransactionResponse>builder()
        .code(200)
        .message("Wallet recharged successfully")
        .result(walletService.makePayment(walletId, request))
        .build();
    }
}
