package com.smartparking.smartbrain.service;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedDailyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedMonthlyRequest;
import com.smartparking.smartbrain.dto.request.MonthlyTicket.CreatedMonthlyTicketRequest;
import com.smartparking.smartbrain.dto.request.Wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.response.Invoice.InvoiceResponse;
import com.smartparking.smartbrain.enums.DiscountType;
import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.InvoiceMapper;
import com.smartparking.smartbrain.model.Discount;
import com.smartparking.smartbrain.model.Invoice;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.repository.*;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class InvoiceService {

    TransactionRepository transactionRepository;
    InvoiceRepository invoiceRepository;
    InvoiceMapper invoiceMapper;
    VehicleRepository vehicleRepository;
    UserRepository userRepository;
    ParkingSlotRepository parkingSlotRepository;
    DiscountRepository discountRepository;
    MonthlyTicketService monthlyTicketService;
    WalletService walletService;
    DateTimeConverter dateTimeConverter;


    public InvoiceResponse createDailyInvoice(InvoiceCreatedDailyRequest request){
        Invoice invoice=invoiceMapper.toDailyInvoice(request);

        var vehicle=vehicleRepository.findById(request.getVehicleID())
        .orElseThrow(()-> new AppException(ErrorCode.VEHICLE_NOT_EXISTS));
        invoice.setVehicle(vehicle);

        var user=userRepository.findById(request.getUserID())
        .orElseThrow(()-> new AppException(ErrorCode.USER_NOT_EXISTS));
        invoice.setUser(user);

        var parkingSlot=parkingSlotRepository.findById(request.getParkingSlotID())
        .orElseThrow(()-> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));
        invoice.setParkingSlot(parkingSlot);

        var discount=discountRepository.findByDiscountCode(request.getDiscountCode())
        .orElseThrow(()-> new AppException(ErrorCode.DISCOUNT_NOT_EXISTS));
        invoice.setDiscount(discount);

        invoiceRepository.save(invoice);
        return invoiceMapper.toInvoiceResponse(invoice);
    }

    @PreAuthorize("@discountPermission.canAccessDiscount(#request.discountCode, #request.parkingSlotID)")
    public InvoiceResponse createMonthlyInvoice(InvoiceCreatedMonthlyRequest request) {
        Instant expiredAt=dateTimeConverter.fromStringToInstant(request.getExpiredAt());
        Invoice invoice = invoiceMapper.toMonthlyInvoice(request);
        // Make transaction
        //caculator total amount
        BigDecimal totalAmount = Optional.ofNullable(caculatorTotalAmountForMonth(invoice.getParkingSlot(), invoice.getDiscount(), expiredAt))
        .orElse(BigDecimal.ZERO);

        PaymentRequest paymentRequest= PaymentRequest.builder()
            .walletID(request.getWalletID())
            .amount(totalAmount)
            .description("Thanh toán hóa đơn tháng")
            .currency("USD")
            .build();
        
        try {
            var transactionID=walletService.makePayment(paymentRequest).getTransactionId();
            invoice.setTransaction(transactionRepository.findById(transactionID)
            .orElseThrow(()-> new AppException(ErrorCode.TRANSACTION_NOT_EXISTS)));
            invoice.setTotal_amount(totalAmount);
            invoice.setStatus(InvoiceStatus.PAID);
            // Lưu hóa đơn vào cơ sở dữ liệu
            invoice = invoiceRepository.save(invoice);
        } catch (AppException e) {
            throw new AppException(ErrorCode.WALLET_NOT_ENOUGH_MONEY);
        }
        
        // Tạo MonthlyTicket
        CreatedMonthlyTicketRequest request2 = CreatedMonthlyTicketRequest.builder()
            .parkingSlotID(invoice.getParkingSlot().getSlotID())
            .userID(invoice.getUser().getUserID())
            .invoiceID(invoice.getInvoiceID()) // Lúc này invoiceID đã có
            .expiredAt(request.getExpiredAt())
            .build();
        monthlyTicketService.createdMonthlyTicket(request2);
        invoiceRepository.save(invoice);
        return invoiceMapper.toInvoiceResponse(invoice);
    }


    public InvoiceResponse getInvoiceByID(String invoiceID){
        var invoice =invoiceRepository.findById(invoiceID)
        .orElseThrow(()-> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
        return invoiceMapper.toInvoiceResponse(invoice);
    }


    public List<InvoiceResponse> getInvoiceByUserID(String userID){
        if (!userRepository.existsById(userID)) {
            throw new AppException(ErrorCode.USER_NOT_EXISTS);
        }
        var invoices =invoiceRepository.findByUser_UserID(userID);
        return invoices.stream().map(invoiceMapper::toInvoiceResponse).toList();
    }


    public List<InvoiceResponse> getAllInvoice(){
        var invoices =invoiceRepository.findAll();
        return invoices.stream().map(invoiceMapper::toInvoiceResponse).toList();
    }



    public BigDecimal caculatorTotalAmountForMonth(ParkingSlot parkingSlot, Discount discount, Instant expiredAt) {
        if (parkingSlot == null || expiredAt == null) {
            throw new IllegalArgumentException("ParkingSlot và MonthlyTicket không được null!");
        }

        // Chuyển expiredAt từ Instant sang LocalDate
        LocalDate expiredDate = expiredAt.atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate today = LocalDate.now();
        
        // Tính số tháng từ thời điểm hiện tại đến ngày hết hạn
        long numberOfMonths = expiredDate.getMonthValue()- today.getMonthValue();
        BigDecimal totalAmount = parkingSlot.getPricePerMonth().multiply(BigDecimal.valueOf(numberOfMonths));
        if (discount != null) {
            BigDecimal maxDiscountValue = discount.getMaxValue();
            BigDecimal discountValue = BigDecimal.valueOf(discount.getDiscountValue());
            if (maxDiscountValue == null) {
                maxDiscountValue = discountValue; // Nếu không có giá trị tối đa, sử dụng giá trị giảm giá
            }

            if (discount.getDiscountType() == DiscountType.PERCENTAGE) {
                BigDecimal calculatedDiscount = totalAmount.multiply(discountValue).divide(BigDecimal.valueOf(100)); // Tính % giảm giá
                
                if (calculatedDiscount.compareTo(maxDiscountValue) > 0) {
                    totalAmount = totalAmount.subtract(maxDiscountValue);
                } else {
                    totalAmount = totalAmount.subtract(calculatedDiscount);
                }
            } else if (discount.getDiscountType() == DiscountType.FIXED) {
                totalAmount = totalAmount.subtract(discountValue);
            }
        }

        return totalAmount.max(BigDecimal.ZERO); // Đảm bảo giá trị không âm
    }


}
