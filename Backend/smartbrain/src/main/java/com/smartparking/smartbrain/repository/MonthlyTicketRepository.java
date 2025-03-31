package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.MonthlyTicket;

@Repository
public interface MonthlyTicketRepository extends JpaRepository <MonthlyTicket,String>{

    
}
