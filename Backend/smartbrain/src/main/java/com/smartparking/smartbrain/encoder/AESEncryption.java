package com.smartparking.smartbrain.encoder;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class AESEncryption {

    private static final String ALGORITHM = "AES";
    private static final ObjectMapper objectMapper = new ObjectMapper();

    // Tạo SecretKey từ signerKey (Băm SHA-256 để lấy đúng 32 byte)
    private static SecretKeySpec getSecretKey(String signerKey) throws Exception {
        MessageDigest sha = MessageDigest.getInstance("SHA-256");
        byte[] keyBytes = sha.digest(signerKey.getBytes(StandardCharsets.UTF_8));
        return new SecretKeySpec(keyBytes, ALGORITHM);
    }

    // Mã hóa object thành chuỗi
    public static String encryptObject(Object obj, String signerKey) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper().registerModule(new JavaTimeModule()); // Hỗ trợ Java 8 Date/Time
        logObject("This object is", obj);
        String json = objectMapper.writeValueAsString(obj); // Chuyển object thành JSON
        return encrypt(json, signerKey);
    }

    // Giải mã chuỗi thành object
    public static <T> T decryptObject(String encryptedData, String signerKey, Class<T> clazz) throws Exception {
        String decryptedJson = decrypt(encryptedData, signerKey);
        return objectMapper.readValue(decryptedJson, clazz);
    }

    // Hàm mã hóa chuỗi
    public static String encrypt(String data, String signerKey) throws Exception {
        SecretKeySpec secretKey = getSecretKey(signerKey);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedData = cipher.doFinal(data.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encryptedData);
    }

    // Hàm giải mã chuỗi
    public static String decrypt(String encryptedData, String signerKey) throws Exception {
        SecretKeySpec secretKey = getSecretKey(signerKey);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decodedBytes = Base64.getDecoder().decode(encryptedData);
        return new String(cipher.doFinal(decodedBytes), StandardCharsets.UTF_8);
    }
    public static void logObject(String message, Object object) {
        try {
            String json = objectMapper.writeValueAsString(object);
            log.info("{}: {}", message, json);
        } catch (Exception e) {
            log.error("Error serializing object: {}", e.getMessage());
        }
    }
}
