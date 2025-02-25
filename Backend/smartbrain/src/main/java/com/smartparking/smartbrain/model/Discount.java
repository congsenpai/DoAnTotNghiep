package com.smartparking.smartbrain.model;

import java.sql.Timestamp;

import com.smartparking.smartbrain.enums.DiscountType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "discounts")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Discount {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "discount_id", nullable = false, updatable = false)
    String discountId;
    String discountCode;
    @Enumerated(EnumType.STRING)
    DiscountType discountType;
    double discountValue;
    String description;

    // Relationship
    @OneToOne(mappedBy="discount")
    Invoice invoice;
    
    // Timestamp
    Timestamp createAt;
    Timestamp expireAt;
    @PrePersist
    protected void onCreate() {
        this.createAt = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        this.expireAt = new Timestamp(System.currentTimeMillis());
    }



}
