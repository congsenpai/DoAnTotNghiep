package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Discount;

@Repository
public interface DiscountRepository extends JpaRepository<Discount, String> {

}
