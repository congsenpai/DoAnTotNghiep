package com.smartparking.smartbrain.controller;

import com.smartparking.smartbrain.dto.request.wallet.CreateWalletRequest;
import com.smartparking.smartbrain.dto.request.wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.request.wallet.TopUpRequest;
import com.smartparking.smartbrain.dto.response.wallet.TransactionResponse;
import com.smartparking.smartbrain.dto.response.wallet.WalletResponse;
import com.smartparking.smartbrain.service.WalletService;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/myparkingapp/wallets")
public class WalletController {

    private final WalletService walletService;

    public WalletController(WalletService walletService) {
        this.walletService = walletService;
    }
    // create wallet
    @PostMapping
    public ResponseEntity<WalletResponse> createWallet(@RequestBody CreateWalletRequest request) {
        return ResponseEntity.ok(walletService.createWallet(request));
    }
    // get wallet by id
    @GetMapping("/{walletId}")
    public ResponseEntity<WalletResponse> getWalletById(@PathVariable String walletId) {
        return ResponseEntity.ok(walletService.getWalletById(walletId));
    }
    // get wallets by user id
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<WalletResponse>> getWalletsByUserId(@PathVariable String userId) {
        return ResponseEntity.ok(walletService.getWalletsByUser(userId));
    }
    


    // update wallet



    // delete wallet
    @DeleteMapping("/{walletId}")
    public ResponseEntity<Void> deleteWallet(@PathVariable String walletId) {
            walletService.deleteWallet(walletId);
            return ResponseEntity.noContent().build();
    }
    // recharge wallet - top up
    @PostMapping("/{walletId}/top-up")
    public ResponseEntity<TransactionResponse> topUp(
            @PathVariable String walletId,
            @RequestBody TopUpRequest request
    ) {
        TransactionResponse response = walletService.topUp(walletId, request);
        return ResponseEntity.ok(response);
    }
    // make payment
    @PostMapping("/{walletId}/payment")
    public ResponseEntity<TransactionResponse> makePayment(
            @PathVariable String walletId,
            @RequestBody PaymentRequest request
    ) {
        TransactionResponse response = walletService.makePayment(walletId, request);
        return ResponseEntity.ok(response);
    }
}
