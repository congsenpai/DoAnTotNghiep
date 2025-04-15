package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.smartparking.smartbrain.model.Vehicle;
import java.util.List;


@Repository
public interface VehicleRepository extends JpaRepository<Vehicle, String> {
    
    List<Vehicle> findByUser_userIDAndIsDeletedFalse(String userID);

}
