package com.smartparking.smartbrain.model;
import java.sql.Timestamp;
import java.util.Set;

import com.smartparking.smartbrain.enums.LotStatus;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;


@Entity
@Getter
@Table(name = "parkingLots")
@Setter
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ParkingLot {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String parkingLotID;

    String parkingLotName;
    String address;
    double latitude;   // Kinh độ
    double longitude;  // Vĩ độ

    int totalSlot;
    
    @Enumerated(EnumType.STRING)
    LotStatus status;

    Double rate;
    String description;

    // Định nghĩa quan hệ ManyToOne
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false) // Tên cột trong cơ sở dữ liệu
    User user;
    @OneToMany(mappedBy = "parkingLot")
    Set<ParkingSlot> parkingSlots;
    @OneToMany(mappedBy = "parkingLot")
    Set<Image> images;

    // Timestamp
    Timestamp createAt;
    Timestamp updateAt;
        @PrePersist
    protected void onCreate() {
        this.createAt = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        this.updateAt = new Timestamp(System.currentTimeMillis());
    }
}
