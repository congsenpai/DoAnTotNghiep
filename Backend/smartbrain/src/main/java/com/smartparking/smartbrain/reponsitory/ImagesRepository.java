package com.smartparking.smartbrain.reponsitory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Images;

@Repository
public interface ImagesRepository extends JpaRepository<Images,String> {
} 