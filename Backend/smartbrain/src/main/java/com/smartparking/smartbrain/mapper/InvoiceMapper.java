package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.converter.EntityConverter;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedDailyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedMonthlyRequest;
import com.smartparking.smartbrain.dto.response.Invoice.InvoiceResponse;
import com.smartparking.smartbrain.model.Invoice;

@Mapper(componentModel = "spring", uses = {DateTimeConverter.class,EntityConverter.class})
public interface InvoiceMapper {

    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "invoiceID", ignore = true)
    @Mapping(target = "monthlyTicket", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "totalAmount", ignore = true)
    @Mapping(target = "transactions", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(source = "vehicleID", target = "vehicle", qualifiedByName = "mapVehicle")
    @Mapping(source = "userID", target = "user", qualifiedByName = "mapUser")
    @Mapping(source = "parkingSlotID", target = "parkingSlot", qualifiedByName = "mapParkingSlot")
    @Mapping(source = "discountCode", target = "discount", qualifiedByName = "mapDiscount")
    Invoice toDailyInvoice(InvoiceCreatedDailyRequest request);

    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "invoiceID", ignore = true)
    @Mapping(target = "monthlyTicket", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "totalAmount", ignore = true)
    @Mapping(target = "transactions", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(source = "vehicleID", target = "vehicle", qualifiedByName = "mapVehicle")
    @Mapping(source = "userID", target = "user", qualifiedByName = "mapUser")
    @Mapping(source = "parkingSlotID", target = "parkingSlot", qualifiedByName = "mapParkingSlot")
    @Mapping(source = "discountCode", target = "discount", qualifiedByName = "mapDiscount")
    Invoice toMonthlyInvoice(InvoiceCreatedMonthlyRequest request);
    
    @Mapping(source = "discount", target = "discount")
    @Mapping(source = "parkingSlot.slotName", target = "parkingSlotName")
    @Mapping(source = "user.userID", target = "userID")
    @Mapping(source = "vehicle", target = "vehicle")
    @Mapping(ignore = true, target = "isMonthlyTicket")
    @Mapping(source = "parkingSlot.parkingLot.parkingLotName", target = "parkingLotName")
    InvoiceResponse toInvoiceResponse(Invoice invoice);
    
}
