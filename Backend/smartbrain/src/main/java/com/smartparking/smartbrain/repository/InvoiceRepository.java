package com.smartparking.smartbrain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Invoice;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoice,String> {

    Page<Invoice> findByUser_UserID(String userID, Pageable pageable);
    @Query(value = "SELECT * FROM invoices WHERE user_id = :userId AND status = 'DEPOSIT'", nativeQuery = true)
    Page<Invoice> findUnpaidInvoicesByUser(@Param("userId") String userId, Pageable pageable);
    @EntityGraph(attributePaths = {}) // Không fetch quan hệ nào
    @Query("SELECT i FROM Invoice i WHERE i.invoiceID = :invoiceID")
    Optional<Invoice> findByIdWithoutRelations(@Param("invoiceID") String invoiceID);
}
