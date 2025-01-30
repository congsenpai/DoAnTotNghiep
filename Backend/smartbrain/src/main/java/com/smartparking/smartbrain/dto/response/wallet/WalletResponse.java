package com.smartparking.smartbrain.dto.response.wallet;

import java.math.BigDecimal;

import com.smartparking.smartbrain.model.Wallet;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class WalletResponse {

    private String walletId;
    private String userId;
    private String currency;
    private BigDecimal balance;
    private String name;

    public WalletResponse(Wallet wallet) {
        this.walletId = wallet.getWalletId();
        this.userId = wallet.getUser().getUserId();
        this.currency = wallet.getCurrency();
        this.balance = wallet.getBalance();
        this.name = wallet.getName();
    }
}