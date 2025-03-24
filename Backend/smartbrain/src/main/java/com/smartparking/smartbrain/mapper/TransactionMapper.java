package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import com.smartparking.smartbrain.dto.response.Wallet.TransactionResponse;
import com.smartparking.smartbrain.enums.TransactionType;
import com.smartparking.smartbrain.model.Transaction;

@Mapper(componentModel = "spring")
public interface TransactionMapper {
    @Mapping(target = "currentBalance", source = "wallet.balance")
    @Mapping(target = "timestamp", source = "createdAt")
    @Mapping(target = "walletID", source = "wallet.walletID")
    @Mapping(target = "isTopUpTransaction",source = "transaction",qualifiedByName = "isTopUpTransaction")
    TransactionResponse toTransactionResponse(Transaction transaction);

    @Named("isTopUpTransaction")
    default Boolean isTopUpTransaction(Transaction transaction) {
        if (transaction.getType().equals(TransactionType.TOP_UP)) {
            return true;
        }else{
            return false;
        }
    }
}
