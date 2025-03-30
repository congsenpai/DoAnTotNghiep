package com.smartparking.smartbrain.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.encoder.AESEncryption;
import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.Invoice;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EntryService {

    @Value("${jwt.signerKey}")
    protected String SECRET_KEY;
    final ParkingSlotService parkingSlotService;

    // viết một hàm tạo chuỗi String sử dụng mã hóa từ hóa đơn Response
    // với hóa đơn theo ngày thì khi người dùng đặt cọc sẽ dùng hóa đơn đặt cọc để vào và hóa đơn thanh toán để ra
    public void enterParkingLot(String objectEncrypt){
        try {
            Invoice invoiceDecrypt =AESEncryption.decryptObject(objectEncrypt, SECRET_KEY, Invoice.class);
            InvoiceStatus status=invoiceDecrypt.getStatus();
            if (status.equals(InvoiceStatus.DEPOSIT)||status.equals(InvoiceStatus.PAID)) {
                parkingSlotService.updateParkingSlotStatus(invoiceDecrypt.getParkingSlot().getSlotID(), SlotStatus.OCCUPIED);
            }
        } catch (Exception e) {
            throw new AppException(ErrorCode.ERROR_NOT_FOUND,"Has error occur when decrypt QR CODE");
        }
    }
    public void outParkingLot(String objectEncrypt){
        try {
            Invoice invoiceDecrypt =AESEncryption.decryptObject(objectEncrypt, SECRET_KEY, Invoice.class);
            InvoiceStatus status=invoiceDecrypt.getStatus();
            if (status.equals(InvoiceStatus.PAID)) {
                if (invoiceDecrypt.getMonthlyTicket()!=null) {
                    parkingSlotService.updateParkingSlotStatus(invoiceDecrypt.getParkingSlot().getSlotID(), SlotStatus.RESERVED);
                }else{
                    parkingSlotService.updateParkingSlotStatus(invoiceDecrypt.getParkingSlot().getSlotID(), SlotStatus.AVAILABLE);
                }
            }
        } catch (Exception e) {
            throw new AppException(ErrorCode.ERROR_NOT_FOUND,"Has error occur when decrypt QR CODE");
        }
    }

}
