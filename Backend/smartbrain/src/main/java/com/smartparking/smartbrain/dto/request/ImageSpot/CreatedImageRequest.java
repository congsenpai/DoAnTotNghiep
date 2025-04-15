package com.smartparking.smartbrain.dto.request.ImageSpot;

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
public class CreatedImageRequest {
    private String urlString;
    private String noteString;
    private boolean status;
    private String parkingSpotID;
}

