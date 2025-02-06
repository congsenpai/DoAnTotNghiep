package com.smartparking.smartbrain.model;

import java.util.Map;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class ISO8583Messenage {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String MessID;
    private Map<Integer, String> dataElements;
}
