package com.smartparking.smartbrain.controller;
import java.text.ParseException;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.nimbusds.jose.JOSEException;
import com.smartparking.smartbrain.dto.request.Authentication.AuthenticationRequest;
import com.smartparking.smartbrain.dto.request.Authentication.IntrospectRequest;
import com.smartparking.smartbrain.dto.request.Authentication.LogoutRequest;
import com.smartparking.smartbrain.dto.request.Authentication.RefreshRequest;
import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.AuthenticationResponse;
import com.smartparking.smartbrain.dto.response.IntrospectResponse;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.service.AuthenticationSevice;
import com.smartparking.smartbrain.service.UserService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
@RestController
@RequestMapping("/myparkingapp/auth")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationController {
    AuthenticationSevice authenticationSevice;
    UserService userService;

    @PostMapping("/login")
    ApiResponse<AuthenticationResponse> login(@RequestBody AuthenticationRequest request) {
        var result = authenticationSevice.authenticate(request);
        return ApiResponse.<AuthenticationResponse>builder()
        .result(result)
        .build();
    }
    @PostMapping("/register")
    public ApiResponse<UserResponse> createRequestUser(@RequestBody @Valid UserRequest request){
        System.err.println("\n" + request + "\n");
        return ApiResponse.<UserResponse>builder()
        .result(userService.createReqUser(request))
        .code(200)
        .message("create user successfully")
        .build();
        
    }

    @PostMapping("/introspect")
    ApiResponse<IntrospectResponse> introspect(@RequestBody IntrospectRequest request)
    throws JOSEException, ParseException {
        var result = authenticationSevice.introspect(request);
        return ApiResponse.<IntrospectResponse>builder()
        .result(result)
        .build();
    }
    @PostMapping("/logout")
    ApiResponse<Void> logout(@RequestBody LogoutRequest request) throws JOSEException, ParseException {
        authenticationSevice.logout(request);
        return ApiResponse.<Void>builder()
        .message("Logout successfully")
        .build();
    }
    @PostMapping("/refresh")
    ApiResponse<AuthenticationResponse> refresh(@RequestBody RefreshRequest request) throws ParseException, JOSEException {
        var result = authenticationSevice.refreshToken(request);
        return ApiResponse.<AuthenticationResponse>builder()
        .result(result)
        .build();
    }
    @GetMapping("/principal")
    public Object getPrincipal(@AuthenticationPrincipal Object principal) {
        System.out.println("🔹 Principal Class: " + (principal != null ? principal.getClass().getName() : "null"));
        return principal;
    }

}
