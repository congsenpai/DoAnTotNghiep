package com.smartparking.smartbrain.service;

import java.time.Instant;
import java.util.Currency;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.smartparking.smartbrain.dto.request.Wallet.CreateWalletRequest;
import com.smartparking.smartbrain.dto.request.Wallet.DepositRequest;
import com.smartparking.smartbrain.dto.request.Wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.request.Wallet.TopUpRequest;
import com.smartparking.smartbrain.dto.request.Wallet.UpdateWalletRequest;
import com.smartparking.smartbrain.dto.response.Wallet.TransactionResponse;
import com.smartparking.smartbrain.dto.response.Wallet.WalletResponse;
import com.smartparking.smartbrain.enums.TransactionStatus;
import com.smartparking.smartbrain.enums.TransactionType;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.TransactionMapper;
import com.smartparking.smartbrain.mapper.WalletMapper;
import com.smartparking.smartbrain.model.Invoice;
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
    TransactionMapper transactionMapper;

    @Transactional(rollbackFor = AppException.class)
    public TransactionResponse topUp(TopUpRequest request) {
        log.info("Top up wallet with request: {}", request);
        Wallet wallet = walletRepository.findById(request.getWalletID())
                .orElseThrow(() -> new AppException(ErrorCode.WALLET_NOT_FOUND));
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

        Transaction transaction = Transaction.builder()
                .wallet(wallet)
                .user(wallet.getUser())
                .amount(request.getAmount())
                .type(TransactionType.TOP_UP)
                .status(TransactionStatus.COMPLETED)
                .createdAt(Instant.now())
                .description(request.getDescription() != null ? request.getDescription() : "Top-up wallet")
                .build();
        transactionRepository.save(transaction);

        return transactionMapper.toTransactionResponse(transaction);
    }

    @Transactional(rollbackFor = AppException.class)
    public TransactionResponse makePayment(PaymentRequest request, Invoice invoice) {
        Wallet wallet = walletRepository.findByIdWithUser(request.getWalletID())
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

        wallet.setBalance(wallet.getBalance().subtract(request.getAmount()));
        walletRepository.save(wallet);

        Transaction transaction = Transaction.builder()
                .wallet(wallet)
                .user(wallet.getUser())
                .invoice(invoice)
                .amount(request.getAmount().negate())
                .type(TransactionType.PAYMENT)
                .status(TransactionStatus.COMPLETED)
                .createdAt(Instant.now())
                .description(request.getDescription())
                .build();
        transactionRepository.save(transaction);

        return transactionMapper.toTransactionResponse(transaction);
    }

    @Transactional(rollbackFor = AppException.class)
    public TransactionResponse deposit(DepositRequest request, Invoice invoice) {
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

        wallet.setBalance(wallet.getBalance().subtract(request.getAmount()));
        walletRepository.save(wallet);

        Transaction transaction = Transaction.builder()
                .wallet(wallet)
                .user(wallet.getUser())
                .invoice(invoice)
                .amount(request.getAmount().negate())
                .type(TransactionType.DEPOSIT)
                .status(TransactionStatus.COMPLETED)
                .createdAt(Instant.now())
                .description(request.getDescription())
                .build();
        transactionRepository.save(transaction);
        return transactionMapper.toTransactionResponse(transaction);
    }

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
