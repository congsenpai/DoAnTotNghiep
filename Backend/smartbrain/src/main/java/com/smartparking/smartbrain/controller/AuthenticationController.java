package com.smartparking.smartbrain.controller;
import java.text.ParseException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.nimbusds.jose.JOSEException;
import com.smartparking.smartbrain.dto.request.Authentication.AuthenticationRequest;
import com.smartparking.smartbrain.dto.request.Authentication.ForgotPassRequest;
import com.smartparking.smartbrain.dto.request.Authentication.IntrospectRequest;
import com.smartparking.smartbrain.dto.request.Authentication.LogoutRequest;
import com.smartparking.smartbrain.dto.request.Authentication.RefreshRequest;
import com.smartparking.smartbrain.dto.request.Authentication.ResetPassRequest;
import com.smartparking.smartbrain.dto.request.User.UserRegisterRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.AuthenticationResponse;
import com.smartparking.smartbrain.dto.response.ChangePasswordResponse;
import com.smartparking.smartbrain.dto.response.IntrospectResponse;
import com.smartparking.smartbrain.service.AuthenticationSevice;
import com.smartparking.smartbrain.service.UserService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
@RestController
@RequestMapping("myparkingapp/auth")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationController {
    AuthenticationSevice authenticationService;
    UserService userService;

    @PostMapping("/login")
    ApiResponse<AuthenticationResponse> login(@RequestBody @Valid AuthenticationRequest request) {
        var result = authenticationService.authenticate(request);
        return ApiResponse.<AuthenticationResponse>builder()
        .code(200)
        .message("Login successfully")
        .result(result)
        .build();
    }
    @PostMapping("/register")
    public ApiResponse<Void> createRequestUser(@RequestBody @Valid UserRegisterRequest request){
        userService.registerUser(request);
        return ApiResponse.<Void>builder()
        .code(200)
        .message("User register successfully")
        .build();
        
    }

    @PostMapping("/introspect")
    ApiResponse<IntrospectResponse> introspect(@RequestBody @Valid IntrospectRequest request)
    throws JOSEException, ParseException {
        var result = authenticationService.introspect(request);
        return ApiResponse.<IntrospectResponse>builder()
        .code(200)
        .message("Introspect successfully")
        .result(result)
        .build();
    }
    @PostMapping("/logout")
    ApiResponse<Void> logout(@RequestBody LogoutRequest request) throws JOSEException, ParseException {
        authenticationService.logout(request);
        return ApiResponse.<Void>builder()
        .code(200)
        .message("Logout successfully")
        .build();
    }
    @PostMapping("/refresh")
    ApiResponse<AuthenticationResponse> refresh(@RequestBody @Valid RefreshRequest request) throws ParseException, JOSEException {
        var result = authenticationService.refreshToken(request);
        return ApiResponse.<AuthenticationResponse>builder()
        .code(200)
        .result(result)
        .message("Refresh token successfully")
        .build();
    }
    @GetMapping("/principal")
    public Object getPrincipal(@AuthenticationPrincipal Object principal) {
        System.out.println("🔹 Principal Class: " + (principal != null ? principal.getClass().getName() : "null"));
        return principal;
    }
    @PostMapping("/forgot-password")
    public ApiResponse<ChangePasswordResponse> forgotPassword(@RequestBody @Valid ForgotPassRequest request) {
        var result=authenticationService.forgotPassword(request.getEmail());
        return ApiResponse.<ChangePasswordResponse>builder()
        .code(200)
        .result(result)
        .message("Change password successfully")
        .build();
    }
    @PutMapping("/reset-password")
    public ApiResponse<Void> resetPassword(@RequestBody @Valid ResetPassRequest request) {
        authenticationService.resetPassword(request);
        return ApiResponse.<Void>builder()
        .code(200)
        .message("Change password successfully")
        .build();
    }
    @GetMapping("/error")
    public ApiResponse<Void> error() {
        return ApiResponse.<Void>builder()
        .code(200)
        .message("Has error occur")
        .build();
    }
}
