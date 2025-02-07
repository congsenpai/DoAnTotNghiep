package com.smartparking.smartbrain.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.model.Wallet;

public interface WalletRepository extends JpaRepository<Wallet, String> {
    List<Wallet> findByUser(User user);
}
