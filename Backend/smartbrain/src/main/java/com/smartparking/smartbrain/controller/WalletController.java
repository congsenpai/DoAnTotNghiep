package com.smartparking.smartbrain.controller;
import com.smartparking.smartbrain.dto.request.Wallet.CreateWalletRequest;
import com.smartparking.smartbrain.dto.request.Wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.request.Wallet.TopUpRequest;
import com.smartparking.smartbrain.dto.request.Wallet.UpdateWalletRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.wallet.TransactionResponse;
import com.smartparking.smartbrain.dto.response.wallet.WalletResponse;
import com.smartparking.smartbrain.service.WalletService;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/myparkingapp/wallets")
public class WalletController {

    private WalletService walletService;

    public WalletController(WalletService walletService) {
        this.walletService = walletService;
    }
    // create wallet
    @PostMapping
    public ApiResponse<WalletResponse> createWallet(@RequestBody CreateWalletRequest request) {
        ApiResponse<WalletResponse> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Wallet created successfully");
        WalletResponse walletResponse = new WalletResponse();
        walletResponse.setWalletId(walletService.createWallet(request).getWalletId());
        walletResponse.setUserId(walletService.createWallet(request).getUser().getUserId());
        walletResponse.setCurrency(walletService.createWallet(request).getCurrency().toString());
        walletResponse.setBalance(walletService.createWallet(request).getBalance());
        walletResponse.setName(walletService.createWallet(request).getName());
        ApiResponse.setResult(walletResponse);
        return ApiResponse;
    }
    // get wallet by id
    @GetMapping("/{walletId}")
    public ApiResponse<WalletResponse> getWalletById(@PathVariable String walletId) {
        ApiResponse<WalletResponse> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Wallet fetched successfully");
        WalletResponse walletResponse = new WalletResponse();
        walletResponse.setWalletId(walletService.getWalletById(walletId).getWalletId());
        walletResponse.setUserId(walletService.getWalletById(walletId).getUser().getUserId());
        walletResponse.setCurrency(walletService.getWalletById(walletId).getCurrency().toString());
        walletResponse.setBalance(walletService.getWalletById(walletId).getBalance());
        walletResponse.setName(walletService.getWalletById(walletId).getName());
        ApiResponse.setResult(walletResponse);
        return ApiResponse;
    }
    // get wallets by user id
   @GetMapping("/user/{userId}")
    public ApiResponse<List<WalletResponse>> getWalletsByUserId(@PathVariable String userId) {
        ApiResponse<List<WalletResponse>> apiResponse = new ApiResponse<>();
        apiResponse.setCode(200);
        apiResponse.setMessage("Wallets fetched successfully");

        // Lấy danh sách Wallets và map sang WalletResponse
        List<WalletResponse> walletResponses = walletService.getWalletsByUser(userId)
        .stream()
        .map(wallet -> {
            WalletResponse walletResponse = new WalletResponse();
            walletResponse.setWalletId(wallet.getWalletId());
            walletResponse.setUserId(wallet.getUser().getUserId());
            walletResponse.setCurrency(wallet.getCurrency().toString());
            walletResponse.setBalance(wallet.getBalance());
            walletResponse.setName(wallet.getName());
            return walletResponse;
        })
        .collect(Collectors.toList());

        apiResponse.setResult(walletResponses);
    return apiResponse;
}

    // update wallet
@PutMapping("/{walletId}")
    public ApiResponse<WalletResponse> updateWallet(
            @PathVariable String walletId,
            @RequestBody UpdateWalletRequest request
    ) {
        ApiResponse<WalletResponse> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Wallet updated successfully");
        WalletResponse walletResponse = new WalletResponse();
        walletResponse.setWalletId(walletService.updateWallet(walletId, request).getWalletId());
        walletResponse.setUserId(walletService.updateWallet(walletId, request).getUser().getUserId());
        walletResponse.setCurrency(walletService.updateWallet(walletId, request).getCurrency().toString());
        walletResponse.setBalance(walletService.updateWallet(walletId, request).getBalance());
        walletResponse.setName(walletService.updateWallet(walletId, request).getName());
        ApiResponse.setResult(walletResponse);
        return ApiResponse;
    }


    // delete wallet
    @DeleteMapping("/{walletId}")
    public ApiResponse<Void> deleteWallet(@PathVariable String walletId) {
            walletService.deleteWallet(walletId);
            ApiResponse<Void> ApiResponse = new ApiResponse<>();
            ApiResponse.setCode(200);
            ApiResponse.setMessage("Wallet deleted successfully");
            return ApiResponse;
    }
    // recharge wallet - top up
    @PostMapping("/{walletId}/top-up")
    public ApiResponse<TransactionResponse> topUp(
            @PathVariable String walletId,
            @RequestBody TopUpRequest request
    ) {
        ApiResponse<TransactionResponse> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Wallet recharged successfully");
        ApiResponse.setResult(walletService.topUp(walletId, request));
        return ApiResponse;
    }
    // make payment
    @PostMapping("/{walletId}/payment")
    public ApiResponse<TransactionResponse> makePayment(
            @PathVariable String walletId,
            @RequestBody PaymentRequest request
    ) {
        ApiResponse<TransactionResponse> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Payment made successfully");
        ApiResponse.setResult(walletService.makePayment(walletId, request));
        return ApiResponse;
    }
}
