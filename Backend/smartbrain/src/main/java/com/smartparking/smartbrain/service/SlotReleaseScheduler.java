package com.smartparking.smartbrain.service;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.model.Invoice;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.repository.InvoiceRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SlotReleaseScheduler {

    private final ParkingSlotRepository slotRepository;
    private final InvoiceRepository invoiceRepository;

    // Chạy mỗi 5 phút
    @Transactional
    @Scheduled(fixedRate = 5 * 60 * 1000)
    public void releaseExpiredReservations() {
        Instant threshold = Instant.now().minus(3, ChronoUnit.HOURS);

        // Lấy các slot đang ở trạng thái RESERVED mà createdAt quá 3 hours
        List<ParkingSlot> expiredSlots = slotRepository.findExpiredReservedSlots(threshold);
        log.info("Found {} active slots", expiredSlots.size());
        for (ParkingSlot slot : expiredSlots) {
            try {
                Set<Invoice> invoiceSet = Optional.ofNullable(slot.getInvoices()).orElse(Set.of());
                List<Invoice> invoices = new ArrayList<>(invoiceSet);

                Invoice latestDepositInvoice = invoices.stream()
                        .filter(invoice -> invoice.getStatus() == InvoiceStatus.DEPOSIT)
                        .max(Comparator.comparing(Invoice::getCreatedAt))
                        .orElse(null);
                if (latestDepositInvoice == null || latestDepositInvoice.getCreatedAt().isBefore(threshold)) {
                    log.info("Releasing slot {} due to expired or missing deposit", slot.getSlotName());
                    slotRepository.updateSlotStatus(slot.getSlotID(), SlotStatus.AVAILABLE);
                    if (latestDepositInvoice != null) {
                        invoiceRepository.updateInvoiceStatus(latestDepositInvoice.getInvoiceID(),
                                InvoiceStatus.CANCELLED);
                        log.info("Cancelled invoice {} for slot {}", latestDepositInvoice.getInvoiceID(),
                                slot.getSlotName());

                    }
                }
            } catch (Exception e) {
                log.error("Error processing slot {}: {}", slot.getSlotName(), e.getMessage(), e);
            }
        }
        log.info("Finished checking expired slots");

    }

}
