package com.smartparking.smartbrain.service;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedDailyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedMonthlyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.PaymentDailyRequest;
import com.smartparking.smartbrain.dto.request.MonthlyTicket.CreatedMonthlyTicketRequest;
import com.smartparking.smartbrain.dto.request.Wallet.DepositRequest;
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

    InvoiceRepository invoiceRepository;
    InvoiceMapper invoiceMapper;
    UserRepository userRepository;
    MonthlyTicketService monthlyTicketService;
    WalletService walletService;
    DateTimeConverter dateTimeConverter;
    WalletRepository walletRepository;
    MonthlyTicketRepository monthlyTicketRepository;


    // Daily invoice deposit
    @PreAuthorize("@slotPermission.canAccessSlot(#request.parkingSlotID)&&@discountPermission.canAccessDiscount(#request.discountCode, #request.parkingSlotID)")
    public InvoiceResponse depositDailyInvoice(InvoiceCreatedDailyRequest request){
        Invoice invoice = invoiceMapper.toDailyInvoice(request);
        var depositValue= invoice.getParkingSlot().getPricePerHour()
            .multiply(BigDecimal.valueOf(3));
        DepositRequest depositRequest= DepositRequest.builder()
            .walletID(request.getWalletID())
            .amount(depositValue)
            .description("Thanh toán tiền cọc")
            .currency("USD")
            .build();
        try {
            walletService.deposit(depositRequest);
            invoice.setStatus(InvoiceStatus.DEPOSIT);
            // Lưu hóa đơn vào cơ sở dữ liệu
            invoice = invoiceRepository.save(invoice);
            return invoiceMapper.toInvoiceResponse(invoice);
        } catch (AppException e) {
            throw new AppException(ErrorCode.WALLET_NOT_ENOUGH_MONEY);
        }
    }
    // Daily invoice payment
    public InvoiceResponse paymentDailyInvoice(PaymentDailyRequest request) {
        var invoice = invoiceRepository.findById(request.getOrderID())
            .orElseThrow(()-> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
        var wallet=walletRepository.findById(request.getWalletID())
            .orElseThrow(()-> new AppException(ErrorCode.WALLET_NOT_FOUND));
        if (invoice.getStatus() != InvoiceStatus.DEPOSIT) {
            throw new AppException(ErrorCode.INVOICE_NOT_DEPOSIT, invoice.getStatus().toString());
        }
        var parkingSlot= invoice.getParkingSlot();
        var discount= invoice.getDiscount();
        var createdAt= invoice.getCreatedAt();
        BigDecimal totalAmount = Optional.ofNullable(caculatorTotalAmount(parkingSlot, discount, createdAt,false))
            .orElse(BigDecimal.ZERO);
        PaymentRequest paymentRequest= PaymentRequest.builder()
            .walletID(wallet.getWalletID())
            .amount(totalAmount)
            .description("Thanh toán hóa đơn ngày")
            .currency("USD")
            .build();
        
        try {
            walletService.makePayment(paymentRequest);
            invoice.setTotalAmount(totalAmount);
            invoice.setStatus(InvoiceStatus.PAID);
            // Lưu hóa đơn vào cơ sở dữ liệu
            invoice = invoiceRepository.save(invoice);
        } catch (AppException e) {
            throw new AppException(ErrorCode.WALLET_NOT_ENOUGH_MONEY);
        }
        
        return invoiceMapper.toInvoiceResponse(invoice);
    }

    // Monthly invoice
    @PreAuthorize("@discountPermission.canAccessDiscount(#request.discountCode, #request.parkingSlotID)")
    public InvoiceResponse createMonthlyInvoice(InvoiceCreatedMonthlyRequest request) {
        Instant expiredAt=dateTimeConverter.fromStringToInstant(request.getExpiredAt());
        Invoice invoice = invoiceMapper.toMonthlyInvoice(request);
        // Make transaction
        //caculator total amount
        BigDecimal totalAmount = Optional.ofNullable(caculatorTotalAmount(invoice.getParkingSlot(), invoice.getDiscount(), expiredAt,true))
        .orElse(BigDecimal.ZERO);

        PaymentRequest paymentRequest= PaymentRequest.builder()
            .walletID(request.getWalletID())
            .amount(totalAmount)
            .description("Thanh toán hóa đơn tháng")
            .currency("USD")
            .build();
        log.info("Total amount: {}", totalAmount);
        log.info("Payment request: {}", paymentRequest);
        var transaction=walletService.makePayment(paymentRequest);
        if (transaction != null) {
            // Lưu hóa đơn vào cơ sở dữ liệu
            invoice.setTotalAmount(totalAmount);
            invoice.setStatus(InvoiceStatus.PAID);
            invoice = invoiceRepository.save(invoice);
        }

        // Tạo MonthlyTicket
        CreatedMonthlyTicketRequest request2 = CreatedMonthlyTicketRequest.builder()
            .parkingSlotID(invoice.getParkingSlot().getSlotID())
            .userID(invoice.getUser().getUserID())
            .invoiceID(invoice.getInvoiceID()) // Lúc này invoiceID đã có
            .expiredAt(request.getExpiredAt())
            .build();
        var response= monthlyTicketService.createdMonthlyTicket(request2);
        invoiceRepository.save(invoice);
        invoice.setMonthlyTicket(monthlyTicketRepository.findById(response.getMonthlyTicketID())
            .orElseThrow(()-> new AppException(ErrorCode.MONTHLY_TICKET_NOT_EXISTS)));
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
    public List<InvoiceResponse> getInvoiceByUserIDNotPayment(String userID){
        if (!userRepository.existsById(userID)) {
            throw new AppException(ErrorCode.USER_NOT_EXISTS);
        }
        var invoices =invoiceRepository.findUnpaidInvoicesByUser(userID);
        return invoices.stream().map(invoiceMapper::toInvoiceResponse).toList();
    }


    public List<InvoiceResponse> getAllInvoice(){
        var invoices =invoiceRepository.findAll();
        return invoices.stream().map(invoiceMapper::toInvoiceResponse).toList();
    }



    public BigDecimal caculatorTotalAmount(ParkingSlot parkingSlot, Discount discount, Instant timeInstant, Boolean isMonthly) {
        if (parkingSlot == null || timeInstant == null) {
            throw new IllegalArgumentException("ParkingSlot và thời gian không được null!");
        }
        BigDecimal totalAmount = BigDecimal.ZERO;
        
        
        if (isMonthly == true) {
             // Chuyển expiredAt từ Instant sang LocalDate
            LocalDate expiredDate = timeInstant.atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate today = LocalDate.now();
            // Tính số tháng từ thời điểm hiện tại đến ngày hết hạn

            long numberOfMonths = ChronoUnit.MONTHS.between(today, expiredDate);
            long extraDays = ChronoUnit.DAYS.between(today.plusMonths(numberOfMonths), expiredDate);
            
            if (extraDays > 0) {
                numberOfMonths++; // Nếu có ngày lẻ, làm tròn lên
            }
            
            totalAmount = parkingSlot.getPricePerMonth().multiply(BigDecimal.valueOf(numberOfMonths));
            log.info("Number of months: {}", numberOfMonths);
            log.info("Total amount for monthly: {}", totalAmount);

        }
        else {
            // Tính số giờ từ thời điểm hiện tại đến ngày hết hạn
            long numberOfHours = Duration.between(Instant.now(),timeInstant).toHours();
            totalAmount = parkingSlot.getPricePerHour().multiply(BigDecimal.valueOf(numberOfHours));
        }
        
        

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
