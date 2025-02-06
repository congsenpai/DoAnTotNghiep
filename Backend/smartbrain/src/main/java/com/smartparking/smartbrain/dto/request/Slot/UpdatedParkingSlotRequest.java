package com.smartparking.smartbrain.dto.request.Slot;

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
public class UpdatedParkingSlotRequest {
    private String slotName;
    private String location;
    private int isState;
    private boolean status;
    private boolean typeVehicle;
    private String ParkingSpotID;
}
