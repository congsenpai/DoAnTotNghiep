package com.smartparking.smartbrain.service;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.smartparking.smartbrain.dto.request.ParkingSpotRequest;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.ParkingSpot;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.reponsitory.ParkingSpotRepository;
import com.smartparking.smartbrain.reponsitory.UserReponsitory;

@Service
public class ParkingSpotSevice {
    @Autowired
    private ParkingSpotRepository parkingSpotRepository;
    @Autowired
    private UserReponsitory userRepository;
    public ParkingSpot createParkingSpot(ParkingSpotRequest request) {
        ParkingSpot parkingSpot = new ParkingSpot();
    
        // Kiểm tra nếu tên bãi đỗ đã tồn tại
        if (parkingSpotRepository.existsByParkingSpotName(request.getParkingSpotName())) {
            throw new AppException(ErrorCode.PARKINGSPOT_ALREADY_EXISTS);    
        }
        // Ánh xạ dữ liệu từ request sang entity
        parkingSpot.setParkingSpotName(request.getParkingSpotName());
        parkingSpot.setPhone(request.getPhone());
        parkingSpot.setAddress(request.getAddress());
        parkingSpot.setLatitude(request.getLatitude()); // Lấy từ request
        parkingSpot.setLongitude(request.getLongitude()); // Lấy từ request
        parkingSpot.setCreatedDate(Timestamp.from(Instant.now())); // Thời gian tạo
        parkingSpot.setUpdatedDate(Timestamp.from(Instant.now())); // Thời gian cập nhật
        parkingSpot.setStatus(request.isStatus());
        parkingSpot.setStarNumber(request.getStarNumber());
        parkingSpot.setPriceEachHourOfCar(request.getPriceEachHourOfCar());
        parkingSpot.setPriceEachHourOfMotor(request.getPriceEachHourOfMotor());
        parkingSpot.setNote(request.getNote());
        // Xử lý userId
        System.err.println(request.getUserID());
        Optional<User> user = userRepository.findById(request.getUserID());
        if (user.isEmpty()) {
            System.err.println("a");
            throw new AppException(ErrorCode.USER_NOT_FOUND);
        }
        parkingSpot.setUser(user.get());
        // Lưu entity vào database
        return parkingSpotRepository.save(parkingSpot);
    }
    public List<ParkingSpot> getParkingSpot(){
        return parkingSpotRepository.findAll();
    }

    public ParkingSpot getParkingSpotByID(String id){
        return parkingSpotRepository.findById(id).orElseThrow(
            () -> new RuntimeException("ErrorCode.PARKINGSPOT_NOT_EXISTS")
        );
    }

    public void deleteParkingSpot(String id){
        if(!parkingSpotRepository.existsById(id)){
            throw new RuntimeException("Parking spot not found");
        }
        parkingSpotRepository.deleteById(id);   
    }

    public ParkingSpot updatedStatusParkingSpot(String id, ParkingSpotRequest request){
        ParkingSpot parkingSpot = parkingSpotRepository.findById(id).get();
        parkingSpot.setStatus(request.isStatus());
        return parkingSpotRepository.save(parkingSpot);
        };
    
    public ParkingSpot updateParkingSpot(String id, ParkingSpotRequest request){
        ParkingSpot parkingSpot = parkingSpotRepository.findById(id).get();
        parkingSpot.setParkingSpotName(request.getParkingSpotName());
        parkingSpot.setPhone(request.getPhone());
        parkingSpot.setAddress(request.getAddress());
        parkingSpot.setLatitude(request.getLatitude());
        parkingSpot.setLongitude(request.getLongitude());
        parkingSpot.setUpdatedDate(Timestamp.from(Instant.now()));
        parkingSpot.setPriceEachHourOfCar(request.getPriceEachHourOfCar());
        parkingSpot.setPriceEachHourOfMotor(request.getPriceEachHourOfMotor());
        
        return parkingSpotRepository.save(parkingSpot);
    }



    
}


