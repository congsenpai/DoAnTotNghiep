package com.smartparking.smartbrain.exception;


import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.smartparking.smartbrain.dto.request.ApiRequest;

@ControllerAdvice
public class GlobalHandlerException {
    @SuppressWarnings("rawtypes")
    @ExceptionHandler(RuntimeException.class)
    ResponseEntity<ApiRequest> handleRuntimeException(RuntimeException e) {
        if (e instanceof AppException) {
            return handleAppException((AppException) e); // Delegate
        }
        if(e instanceof IllegalArgumentException){
            return handleIllegalArgumentException((IllegalArgumentException) e);
        }
        
        // System.err.println("a");
        // ApiRequest apiRequest = new ApiRequest();
        // apiRequest.setCode(ErrorCode.ERROR_NOT_FOUND.getCode());
        // apiRequest.setMessage(ErrorCode.ERROR_NOT_FOUND.getMessage());
        return handleAppException((AppException) e);
    }


    @SuppressWarnings("rawtypes")
    @ExceptionHandler(AppException.class)
    ResponseEntity<ApiRequest> handleAppException(AppException e) {
        System.err.println(e.getErrorCode().getCode());
        ApiRequest apiRequest = new ApiRequest();
        apiRequest.setCode(e.getErrorCode().getCode());
        apiRequest.setMessage(e.getMessage());
        return ResponseEntity.badRequest().body(apiRequest);
    }


    @SuppressWarnings("rawtypes")
    @ExceptionHandler(IllegalArgumentException.class)
    ResponseEntity<ApiRequest> handleIllegalArgumentException(IllegalArgumentException e) {
        ApiRequest apiRequest = new ApiRequest();
        apiRequest.setCode(ErrorCode.PASSWORD_NOT_VALID.getCode());
        apiRequest.setMessage(ErrorCode.PASSWORD_NOT_VALID.getMessage());
        return ResponseEntity.badRequest().body(apiRequest);
    }

    
   // Cải tiến phương thức này để xử lý chi tiết từng lỗi
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        Map<String, String> errors = new HashMap<>();

        e.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });

        return ResponseEntity.badRequest().body(errors); // Trả về JSON lỗi chi tiết
    }
}
