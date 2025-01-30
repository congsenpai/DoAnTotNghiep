package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.smartparking.smartbrain.model.Transaction;

public interface TransactionRepository extends JpaRepository<Transaction, String> {
}
