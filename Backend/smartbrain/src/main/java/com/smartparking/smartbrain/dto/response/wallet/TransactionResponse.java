package com.smartparking.smartbrain.dto.response.wallet;

import java.math.BigDecimal;
import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.AccessLevel;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TransactionResponse {
    private String transactionId;    // Mã giao dịch
    private String walletId;         // ID ví liên quan
    private BigDecimal previousBalance; // Số dư trước giao dịch
    private BigDecimal currentBalance;  // Số dư sau giao dịch
    private BigDecimal amount;          // Số tiền giao dịch
    private Timestamp timestamp;        // Thời gian giao dịch
    private String description;         // Mô tả giao dịch
}
