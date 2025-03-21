package com.smartparking.smartbrain.service;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.MonthlyTicket.CreatedMonthlyTicketRequest;
import com.smartparking.smartbrain.dto.response.MonthlyTicket.MonthlyTicketResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.MonthlyTicketMapper;
import com.smartparking.smartbrain.model.MonthlyTicket;
import com.smartparking.smartbrain.repository.InvoiceRepository;
import com.smartparking.smartbrain.repository.MonthlyTicketRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class MonthlyTicketService {
    MonthlyTicketRepository monthlyTicketRepository;
    MonthlyTicketMapper monthlyTicketMapper;
    UserRepository userRepository;
    ParkingSlotRepository parkingSlotRepository;
    InvoiceRepository invoiceRepository;
    public MonthlyTicketResponse createdMonthlyTicket(CreatedMonthlyTicketRequest request){
        MonthlyTicket monthlyTicket=monthlyTicketMapper.toMonthlyTicket(request);
        
        var user=userRepository.findById(request.getUserID())
        .orElseThrow(()-> new AppException(ErrorCode.USER_NOT_EXISTS));
        monthlyTicket.setUser(user);

        var parkingSlot=parkingSlotRepository.findById(request.getParkingSlotID())
        .orElseThrow(()-> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));
        monthlyTicket.setParkingSlot(parkingSlot);

        var invoice=invoiceRepository.findById(request.getInvoiceID())
        .orElseThrow(()-> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
        monthlyTicket.setInvoice(invoice);

        monthlyTicketRepository.save(monthlyTicket);
        return monthlyTicketMapper.toMonthlyTicketResponse(monthlyTicket);

    }
}
