package com.smartparking.smartbrain.service;

import java.text.ParseException;
import java.util.Date;
import java.util.StringJoiner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSObject;
import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.Payload;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.smartparking.smartbrain.dto.request.Login.AuthenticationRequest;
import com.smartparking.smartbrain.dto.request.Login.IntrospectRequest;
import com.smartparking.smartbrain.dto.response.AuthenticationResponse;
import com.smartparking.smartbrain.dto.response.IntrospectResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.reponsitory.UserReponsitory;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationSevice {
    @Autowired
    UserReponsitory userReponsitory;
    PasswordEncoder passwordEncoder;

    protected static final String SECRET_KEY = "1g588fp61K3ru1mWsoT900vsoqykoJs63qAzM2917QKkIAf1ff0WwGHvNu3+vmJ7";

    public IntrospectResponse introspectResponse(IntrospectRequest request)
    throws JOSEException, ParseException{
        var token = request.getToken();
        JWSVerifier verifier = new MACVerifier(SECRET_KEY.getBytes());
        SignedJWT signedJWT = SignedJWT.parse(token);
        Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
        boolean isVerified = signedJWT.verify(verifier);
        return IntrospectResponse.builder()
            .valid(isVerified && expirationTime.after(new Date()))
            .build();
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        System.err.println(request.getUsername());
        User user = userReponsitory.findByUsername(request.getUsername()).orElseThrow(
            () -> new AppException(ErrorCode.USER_NOT_FOUND)
        );
        System.err.println(request.getPassword());
    
        boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPassword());
        if(!authenticated)
            throw new AppException(ErrorCode.UNAUTHORIZED);
        String token = generalToken(user);
        return AuthenticationResponse.builder()
            .token(token)
            .authenticated(true)
            .build();
    }

    private String generalToken(User user){
        JWSHeader JWSHead =  new JWSHeader(JWSAlgorithm.HS256);
        JWTClaimsSet JWTClaimsSet = new JWTClaimsSet.Builder()
            .subject(user.getUsername())
            .issuer("smartparkingapp")
            .issueTime(new Date())
            .expirationTime(new Date(System.currentTimeMillis() + 60 * 100000)).
            claim("scope", buildString(user)).
            build();
        Payload payload = new Payload(JWTClaimsSet.toJSONObject());
        JWSObject JWSObject = new JWSObject(JWSHead, payload);
        try {
            JWSObject.sign(new MACSigner(SECRET_KEY));
            return JWSObject.serialize();
        } catch (Exception e) {
        
            e.printStackTrace();
            throw new AppException(ErrorCode.INTERNAL_SERVER_ERROR); // Trả lỗi chung nếu tạo token thất bại
        }
    }

    private String buildString(User user){
        StringJoiner stringJoiner = new StringJoiner(" ");
        if (!CollectionUtils.isEmpty(user.getRole())) {
            user.getRole().forEach(stringJoiner::add);
        }
        return stringJoiner.toString();
    } 
}
