package com.smartparking.smartbrain.config;


import java.util.Date;
import java.util.StringJoiner;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSObject;
import com.nimbusds.jose.Payload;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWTClaimsSet;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
public class JwtTokenProvider {
    @Value("${jwt.signerKey}")
    protected String SECRET_KEY;
    
    public String generateToken(User user){
        JWSHeader JWSHead =  new JWSHeader(JWSAlgorithm.HS256);
        JWTClaimsSet JWTClaimsSet = new JWTClaimsSet.Builder()
            .subject(user.getUsername())
            .issuer("smartparkingapp")
            .issueTime(new Date())
            .expirationTime(new Date(System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000))
            .claim("scope", buildString(user))
            .claim("userId", user.getUserId())
            .build();
        Payload payload = new Payload(JWTClaimsSet.toJSONObject());
        JWSObject JWSObject = new JWSObject(JWSHead, payload);
        try {
            JWSObject.sign(new MACSigner(SECRET_KEY));
            return JWSObject.serialize();
        } catch (Exception e) {
            System.err.println(e);
            e.printStackTrace();
            throw new AppException(ErrorCode.INTERNAL_SERVER_ERROR); // Trả lỗi chung nếu tạo token thất bại
        }
    }

    private String buildString(User user){
        StringJoiner stringJoiner = new StringJoiner(" ");
        if (!CollectionUtils.isEmpty(user.getRoles())) {
            user.getRoles().forEach(role -> {
                stringJoiner.add(role.getRoleName());
                if(!CollectionUtils.isEmpty(role.getPermissions())){
                    role.getPermissions().forEach(permission -> {
                        stringJoiner.add(permission.getPermissionName());
                    });
                }
            });
        }
        return stringJoiner.toString();
    }
}
