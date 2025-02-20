package com.smartparking.smartbrain.service;

import java.text.ParseException;
import java.util.Date;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.SignedJWT;
import com.smartparking.smartbrain.config.JwtTokenProvider;
import com.smartparking.smartbrain.dto.request.Login.AuthenticationRequest;
import com.smartparking.smartbrain.dto.request.Login.IntrospectRequest;
import com.smartparking.smartbrain.dto.response.AuthenticationResponse;
import com.smartparking.smartbrain.dto.response.IntrospectResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthenticationSevice {
    final UserRepository userReponsitory;
    final PasswordEncoder passwordEncoder;
    final JwtTokenProvider jwtTokenProvider;

    @Value("${jwt.signerKey}")
    protected String SECRET_KEY;


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
    
        boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPassword());
        if(!authenticated)
            throw new AppException(ErrorCode.UNAUTHORIZED);
        String token = jwtTokenProvider.generateToken(user);
        return AuthenticationResponse.builder()
            .token(token)
            .authenticated(true)
            .build();
    }

}
