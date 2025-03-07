package com.smartparking.smartbrain.dto.response;

import com.smartparking.smartbrain.exception.ErrorCode;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class IntrospectResponse {
    boolean valid;
    String message;
}

