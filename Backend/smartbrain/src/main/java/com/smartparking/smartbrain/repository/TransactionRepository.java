package com.smartparking.smartbrain.repository;

import java.time.Instant;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Transaction;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, String> {
    Page<Transaction> findAllByUser_UserID(String userID, Pageable pageable); // Lấy tất cả giao dịch của người dùng theo ID người dùng và phân trang
    @Query("SELECT t FROM Transaction t WHERE t.createdAt BETWEEN :from AND :to")
    Page<Transaction> findTransactionByTime(Instant from, Instant to, Pageable pageable);
    Page<Transaction> findAllByWallet_WalletID(String walletID, Pageable pageable);
}
