package com.smartparking.smartbrain.model;
import java.sql.Timestamp;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class ParkingSpot {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String parkingSpotID;
    private String parkingSpotName;
    private String phone;
    private String address;
    private double latitude;   // Kinh độ
    private double longitude; 
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private boolean status;
    private int starNumber;
    private double priceEachHourOfMotor;
    private double priceEachHourOfCar;
    private String note;
    // Định nghĩa quan hệ ManyToOne
    @ManyToOne
    @JoinColumn(name = "userID", nullable = false) // Tên cột trong cơ sở dữ liệu
    private User user;
}
