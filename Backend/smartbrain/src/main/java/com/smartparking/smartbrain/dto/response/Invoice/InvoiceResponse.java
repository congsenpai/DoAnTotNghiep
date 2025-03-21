package com.smartparking.smartbrain.dto.response.Invoice;

import java.math.BigDecimal;

import com.smartparking.smartbrain.enums.InvoiceStatus;

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
    BigDecimal total_amount;
    InvoiceStatus status;
    String description;
    String transactionID;
    String userID;
    String discountID;
    String parkingSlotID;
    String vehicleID;
    Boolean isMonthlyTicket;
    String createdAt;
}
