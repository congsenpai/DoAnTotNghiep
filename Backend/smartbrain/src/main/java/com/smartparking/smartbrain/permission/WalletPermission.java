package com.smartparking.smartbrain.permission;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.Wallet;
import com.smartparking.smartbrain.repository.WalletRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class WalletPermission {
    @Autowired
    WalletRepository walletRepository;
    public boolean canAccessWallet(String walletId, String userId) {
        System.out.println("Checking wallet access for user: " + userId + " and wallet: " + walletId);
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(() -> new AppException(ErrorCode.WALLET_NOT_FOUND));

        if (Objects.equals(wallet.getUser().getUserID(), userId)) {
            log.info("wallet valid");
            return true;
        }
        
        throw new AppException(ErrorCode.WALLET_NOT_BELONG_TO_USER);
    }

}
