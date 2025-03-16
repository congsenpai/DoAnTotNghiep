package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Discount;
import java.util.List;


@Repository
public interface DiscountRepository extends JpaRepository<Discount, String> {
    List<Discount> findAllByParkingLot_ParkingLotID(String parkingLotID);
    List<Discount> findByParkingLotIsNull();

}
