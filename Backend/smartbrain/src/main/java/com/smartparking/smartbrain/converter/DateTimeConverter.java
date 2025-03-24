package com.smartparking.smartbrain.converter;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import org.mapstruct.Named;
import org.springframework.stereotype.Component;
@Component
public class DateTimeConverter {
    @Named("fromStringToInstant")
    public Instant fromStringToInstant(String dateStr) {
        try {
            LocalDate localDate = LocalDate.parse(dateStr, DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            return localDate.atStartOfDay(ZoneId.of("UTC")).toInstant();
        } catch (DateTimeParseException e) {
            throw new RuntimeException("Invalid date format: " + dateStr);
        }
    }

    @Named("fromInstantToString")
    public String fromInstantToString(Instant instant) {
        return instant == null ? null : DateTimeFormatter.ofPattern("dd/MM/yyyy").format(instant.atZone(ZoneId.of("UTC")).toLocalDate());
    }
}

