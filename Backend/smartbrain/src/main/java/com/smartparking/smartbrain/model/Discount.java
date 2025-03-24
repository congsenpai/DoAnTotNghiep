package com.smartparking.smartbrain.model;
import java.time.Instant;
import java.util.Set;
import org.hibernate.annotations.CreationTimestamp;
import com.smartparking.smartbrain.enums.DiscountType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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
    String discountID;
    String discountCode;
    @Enumerated(EnumType.STRING)
    DiscountType discountType;
    double discountValue;
    String description;
    @Builder.Default
    Boolean isGlobalDiscount =true;

    // Relationship
    @OneToMany(mappedBy="discount")
    Set<Invoice> invoices;
    
    @ManyToOne
    @JoinColumn(name = "parking_lot_id", nullable = true)
    ParkingLot parkingLot;
    
    // Timestamp
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    Instant createdAt;

    @Column(name = "expired_at")
    Instant expiredAt;

}
