package com.smartparking.smartbrain.service;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Currency;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.smartparking.smartbrain.dto.request.Wallet.CreateWalletRequest;
import com.smartparking.smartbrain.dto.request.Wallet.DepositRequest;
import com.smartparking.smartbrain.dto.request.Wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.request.Wallet.TopUpRequest;
import com.smartparking.smartbrain.dto.request.Wallet.UpdateWalletRequest;
import com.smartparking.smartbrain.dto.response.Wallet.TransactionResponse;
import com.smartparking.smartbrain.dto.response.Wallet.WalletResponse;
import com.smartparking.smartbrain.enums.Transactions;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.WalletMapper;
import com.smartparking.smartbrain.model.Transaction;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.model.Wallet;
import com.smartparking.smartbrain.repository.TransactionRepository;
import com.smartparking.smartbrain.repository.UserRepository;
import com.smartparking.smartbrain.repository.WalletRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class WalletService {

    WalletRepository walletRepository;
    UserRepository userRepository;
    TransactionRepository transactionRepository;
    WalletMapper walletMapper;

    @Transactional
    public TransactionResponse topUp(TopUpRequest request) {
        log.info("Top up wallet with request: {}", request);
        Wallet wallet = walletRepository.findById(request.getWalletID())
                .orElseThrow(() -> new AppException(ErrorCode.WALLET_NOT_FOUND));
        BigDecimal previousBalance = wallet.getBalance();
        if (request.getCurrency() != null) {
            try {
                Currency currency = Currency.getInstance(request.getCurrency().toUpperCase());
                if (!currency.equals(wallet.getCurrency())) {
                    throw new AppException(ErrorCode.CURRENCY_MISMATCH);
                }
            } catch (IllegalArgumentException e) {
                throw new AppException(ErrorCode.INVALID_CURRENCY);
            }
            
        }
        // add amount to old balanced
        wallet.setBalance(wallet.getBalance().add(request.getAmount()));
        
        walletRepository.save(wallet);

        Transaction transaction = new Transaction();
        transaction.setWallet(wallet);
        transaction.setUser(wallet.getUser());
        transaction.setAmount(request.getAmount());
        transaction.setType(Transactions.TOP_UP);
        transaction.setCreatedAt(Instant.now());
        transaction.setDescription(request.getDescription() != null ? request.getDescription() : "Top-up wallet");
        transactionRepository.save(transaction);

        return new TransactionResponse(
                transaction.getTransactionID(),
                request.getWalletID(),
                previousBalance,
                wallet.getBalance(),
                request.getAmount(),
                transaction.getCreatedAt(),
                transaction.getDescription()
        );
    }

    @Transactional
    @PreAuthorize("@walletPermission.canAccessWallet(#request.walletID, authentication.token.claims['userId'])")
    public TransactionResponse makePayment(PaymentRequest request) {
        Wallet wallet = walletRepository.findById(request.getWalletID())
                .orElseThrow(()-> new AppException(ErrorCode.WALLET_NOT_FOUND));
        log.info("Make payment with request: {}", request);
        if (wallet.getBalance().compareTo(request.getAmount()) < 0) {
            throw new IllegalArgumentException("Insufficient balance");
        }
        if (request.getCurrency() != null) {
            try {
                Currency currency = Currency.getInstance(request.getCurrency().toUpperCase());
                if (!currency.equals(wallet.getCurrency())) {
                    throw new AppException(ErrorCode.CURRENCY_MISMATCH);
                }
            } catch (IllegalArgumentException e) {
                throw new AppException(ErrorCode.INVALID_CURRENCY);
            }
            
        }

        BigDecimal previousBalance = wallet.getBalance();
        wallet.setBalance(wallet.getBalance().subtract(request.getAmount()));
        walletRepository.save(wallet);

        Transaction transaction = new Transaction();
        transaction.setWallet(wallet);
        transaction.setUser(wallet.getUser());
        transaction.setAmount(request.getAmount().negate());
        transaction.setType(Transactions.PAYMENT);
        transaction.setCreatedAt(Instant.now());
        transaction.setDescription(request.getDescription());
        transactionRepository.save(transaction);

        return new TransactionResponse(
                transaction.getTransactionID(),
                request.getWalletID(),
                previousBalance,
                wallet.getBalance(),
                transaction.getAmount(),
                transaction.getCreatedAt(),
                transaction.getDescription()
        );
    }

    @Transactional
    @PreAuthorize("@walletPermission.canAccessWallet(#request.walletID, authentication.token.claims['userId'])")
    public TransactionResponse deposit(DepositRequest request) {
        Wallet wallet = walletRepository.findById(request.getWalletID())
                .orElseThrow(()-> new AppException(ErrorCode.WALLET_NOT_FOUND));

        if (wallet.getBalance().compareTo(request.getAmount()) < 0) {
            throw new IllegalArgumentException("Insufficient balance");
        }
        if (request.getCurrency() != null) {
            try {
                Currency currency = Currency.getInstance(request.getCurrency().toUpperCase());
                if (!currency.equals(wallet.getCurrency())) {
                    throw new AppException(ErrorCode.CURRENCY_MISMATCH);
                }
            } catch (IllegalArgumentException e) {
                throw new AppException(ErrorCode.INVALID_CURRENCY);
            }
            
        }

        BigDecimal previousBalance = wallet.getBalance();
        wallet.setBalance(wallet.getBalance().subtract(request.getAmount()));
        walletRepository.save(wallet);

        Transaction transaction = new Transaction();
        transaction.setWallet(wallet);
        transaction.setUser(wallet.getUser());
        transaction.setAmount(request.getAmount().negate());
        transaction.setType(Transactions.DEPOSIT);
        transaction.setCreatedAt(Instant.now());
        transaction.setDescription(request.getDescription());
        transactionRepository.save(transaction);

        return new TransactionResponse(
                transaction.getTransactionID(),
                request.getWalletID(),
                previousBalance,
                wallet.getBalance(),
                transaction.getAmount(),
                transaction.getCreatedAt(),
                transaction.getDescription()
        );
    }

    @Transactional
    public WalletResponse createWallet(CreateWalletRequest request) {
        Currency currency;
        try {
            currency = Currency.getInstance(request.getCurrency().toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new AppException(ErrorCode.INVALID_CURRENCY);
        }
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        // Sử dụng mapper để chuyển request thành wallet
        Wallet wallet = walletMapper.toWallet(request);
        // Set lại các giá trị cần thiết
        wallet.setCurrency(currency);
        wallet.setUser(user);
        walletRepository.save(wallet);
        WalletResponse walletResponse = walletMapper.toWalletResponse(wallet);
        walletResponse.setWalletID(wallet.getWalletID());
        walletResponse.setCurrency(wallet.getCurrency().toString());
        return walletResponse;
    }
    

    public List<WalletResponse> getWalletsByUser(String userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        return walletRepository.findByUser(user)
        .stream()
        .map(walletMapper::toWalletResponse)
        .toList();
    }
    

    public WalletResponse getWalletById(String walletId) {
        Wallet wallet = walletRepository.findById(walletId)
                .orElseThrow(() -> new AppException(ErrorCode.WALLET_NOT_FOUND));
        return walletMapper.toWalletResponse(wallet);
    }

    @Transactional
    public WalletResponse updateWallet(UpdateWalletRequest request) {
        Wallet wallet = walletRepository.findById(request.getWalletID())
                .orElseThrow(() -> new AppException(ErrorCode.WALLET_NOT_FOUND));
        walletMapper.updateWalletFromRequest(request, wallet);
        if (request.getCurrency() != null) {
            try {
                Currency currency = Currency.getInstance(request.getCurrency().toUpperCase());
                wallet.setCurrency(currency);
            } catch (IllegalArgumentException e) {
                throw new AppException(ErrorCode.INVALID_CURRENCY);
            }
            
        }
        walletRepository.save(wallet);
        return walletMapper.toWalletResponse(wallet);
    }

    @Transactional
    public void deleteWallet(String walletId) {
        if (!walletRepository.existsById(walletId)) {
            throw new AppException(ErrorCode.WALLET_NOT_FOUND);
        }
        walletRepository.deleteById(walletId);
    }

}
