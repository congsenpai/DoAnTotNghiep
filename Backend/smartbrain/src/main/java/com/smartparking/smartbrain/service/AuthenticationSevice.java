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
import com.smartparking.smartbrain.dto.request.Authentication.AuthenticationRequest;
import com.smartparking.smartbrain.dto.request.Authentication.IntrospectRequest;
import com.smartparking.smartbrain.dto.request.Authentication.LogoutRequest;
import com.smartparking.smartbrain.dto.request.Authentication.RefreshRequest;
import com.smartparking.smartbrain.dto.response.AuthenticationResponse;
import com.smartparking.smartbrain.dto.response.IntrospectResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.InvalidToken;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.InvalidatedRepository;
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
    final InvalidatedRepository invalidatedRepository;

    @Value("${jwt.signerKey}")
    protected String SECRET_KEY;


    public IntrospectResponse introspect(IntrospectRequest request)
    throws JOSEException, ParseException{
        verifyToken(request.getToken());
        boolean isValid = true;
        try {
            verifyToken(request.getToken());
        } catch (AppException e) {
            isValid = false;
        }
        return IntrospectResponse.builder()
            .valid(isValid)
            .build();
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
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
    private SignedJWT verifyToken(String token) throws ParseException, JOSEException {
        JWSVerifier verifier = new MACVerifier(SECRET_KEY.getBytes());
        SignedJWT signedJWT = SignedJWT.parse(token);
        Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
        boolean isVerified = signedJWT.verify(verifier);
        if(!isVerified || !expirationTime.after(new Date()))
            throw new AppException(ErrorCode.UNAUTHORIZED);
        if (invalidatedRepository.existsById(signedJWT.getJWTClaimsSet().getJWTID())) {
            throw new AppException(ErrorCode.TOKEN_EXPIRED);
        }
        return signedJWT;
    }
    public void logout(LogoutRequest request) throws JOSEException, ParseException {
        var signedJWT=verifyToken(request.getToken());
        String id=signedJWT.getJWTClaimsSet().getJWTID();
        Date expiryTime=signedJWT.getJWTClaimsSet().getExpirationTime();
        InvalidToken invalidToken = InvalidToken.builder()
            .id(id)
            .expiryTime(expiryTime)
            .build();
        invalidatedRepository.save(invalidToken);
    }
    public void refreshToken(RefreshRequest request){
        
    }

}
