package com.smartparking.smartbrain.dto.request;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import lombok.experimental.FieldDefaults;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ParkingSpotRequest {
    private String parkingSpotID;          // ID của Parking Spot (nếu cần cho cập nhật)
    private String parkingSpotName;        // Tên của Parking Spot
    private String phone;                  // Số điện thoại liên hệ
    private String address;                // Địa chỉ
    private double latitude;   // Kinh độ
    private double longitude;              // Thông tin tọa độ (latitude, longitude)
    private boolean status;               // Trạng thái (còn hoạt động hay không)
    private int starNumber;                // Số sao đánh giá
    private double priceEachHourOfMotor;   // Giá mỗi giờ cho xe máy
    private double priceEachHourOfCar;     // Giá mỗi giờ cho ô tô
    private String note;                   // Ghi chú
    private String userID;                 // ID của User liên kết
}
