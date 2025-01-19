package com.smartparking.smartbrain.reponsitory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.User;

import java.util.Optional;

@Repository
public interface UserReponsitory  extends JpaRepository<User, String> {
    boolean existsByUsername(String username);
    Optional<User> findByUsername(String username);
    
}