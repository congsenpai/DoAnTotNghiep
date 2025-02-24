package com.smartparking.smartbrain.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Transaction;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, String> {
    @SuppressWarnings("null")
    Page<Transaction> findAll(Pageable pageable);
}
