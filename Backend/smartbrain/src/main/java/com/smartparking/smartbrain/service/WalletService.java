package com.smartparking.smartbrain.service;

import com.smartparking.smartbrain.dto.request.wallet.CreateWalletRequest;
import com.smartparking.smartbrain.dto.request.wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.request.wallet.TopUpRequest;
import com.smartparking.smartbrain.dto.request.wallet.UpdateWalletRequest;
import com.smartparking.smartbrain.dto.response.wallet.TransactionResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.Transaction;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.model.Transaction.TransactionType;
import com.smartparking.smartbrain.model.Wallet;
import com.smartparking.smartbrain.repository.TransactionRepository;
import com.smartparking.smartbrain.repository.UserRepository;
import com.smartparking.smartbrain.repository.WalletRepository;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

@Service
public class WalletService {

    private final WalletRepository walletRepository;
    private final UserRepository userRepository;
    private final TransactionRepository transactionRepository;

    public WalletService(WalletRepository walletRepository, UserRepository userRepository, TransactionRepository transactionRepository) {
        this.walletRepository = walletRepository;
        this.userRepository = userRepository;
        this.transactionRepository = transactionRepository;
    }

    @Transactional
    public TransactionResponse topUp(String walletId, TopUpRequest request) {
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(() -> new AppException(ErrorCode.WALLET_NOT_FOUND));
        BigDecimal previousBalance = wallet.getBalance();
        wallet.setBalance(wallet.getBalance().add(request.getAmount()));
        walletRepository.save(wallet);

        Transaction transaction = new Transaction();
        transaction.setWallet(wallet);
        transaction.setUser(wallet.getUser());
        transaction.setAmount(request.getAmount());
        transaction.setType(Transaction.TransactionType.TOP_UP);
        transaction.setCreatedDate(Timestamp.from(Instant.now()));
        transaction.setDescription(request.getDescription() != null ? request.getDescription() : "Top-up wallet");
        transactionRepository.save(transaction);

        return new TransactionResponse(
                transaction.getTransactionId(),
                walletId,
                previousBalance,
                wallet.getBalance(),
                request.getAmount(),
                transaction.getCreatedDate(),
                transaction.getDescription()
        );
    }

    @Transactional
    public TransactionResponse makePayment(String walletId, PaymentRequest request) {
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(()-> new AppException(ErrorCode.WALLET_NOT_FOUND));

        if (wallet.getBalance().compareTo(request.getAmount()) < 0) {
            throw new IllegalArgumentException("Insufficient balance");
        }

        BigDecimal previousBalance = wallet.getBalance();
        wallet.setBalance(wallet.getBalance().subtract(request.getAmount()));
        walletRepository.save(wallet);

        Transaction transaction = new Transaction();
        transaction.setWallet(wallet);
        transaction.setUser(wallet.getUser());
        transaction.setAmount(request.getAmount().negate());
        transaction.setType(TransactionType.PAYMENT);
        transaction.setCreatedDate(Timestamp.from(Instant.now()));
        transaction.setDescription(request.getDescription());
        transactionRepository.save(transaction);

        return new TransactionResponse(
                transaction.getTransactionId(),
                walletId,
                previousBalance,
                wallet.getBalance(),
                transaction.getAmount(),
                transaction.getCreatedDate(),
                transaction.getDescription()
        );
    }

    @Transactional
    public Wallet createWallet(CreateWalletRequest request) {
        Wallet wallet = new Wallet();
        User user = userRepository.findById(request.getUserId()).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        wallet.setUser(user);
        wallet.setCurrency(request.getCurrency());
        wallet.setBalance(request.getBalance() != null ? request.getBalance() : BigDecimal.ZERO);
        wallet.setName(request.getName());

       return wallet = walletRepository.save(wallet);

    }

    public List<Wallet> getWalletsByUser(String userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        return walletRepository.findByUser(user);
    }
    

    public Wallet getWalletById(String walletId) {
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(() -> new EntityNotFoundException("Wallet not found"));
        return wallet;
    }

    @Transactional
    public Wallet updateWallet(String walletId, UpdateWalletRequest request) {
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(() -> new EntityNotFoundException("Wallet not found"));

        if (request.getName() != null) {
            wallet.setName(request.getName());
        }
        if (request.getCurrency() != null) {
            wallet.setCurrency(request.getCurrency());
        }

        return wallet = walletRepository.save(wallet);
    }

    @Transactional
    public void deleteWallet(String walletId) {
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(() -> new AppException(ErrorCode.WALLET_NOT_FOUND));
        walletRepository.delete(wallet);
    }

}
