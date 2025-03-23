package com.smartparking.smartbrain.dto.response.Invoice;

import java.math.BigDecimal;
import java.util.Set;

import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.model.Transaction;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InvoiceResponse {
    BigDecimal totalAmount;
    InvoiceStatus status;
    String description;
    Set<Transaction> transactions;
    String userID;
    String discountID;
    String parkingSlotID;
    String vehicleID;
    Boolean isMonthlyTicket;
    String createdAt;
}
