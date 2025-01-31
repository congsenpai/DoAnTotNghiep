package com.smartparking.smartbrain.exception;


import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.smartparking.smartbrain.dto.response.*;;


@ControllerAdvice
public class GlobalHandlerException {


    @SuppressWarnings("rawtypes")
    @ExceptionHandler(RuntimeException.class)
        ResponseEntity<ApiResponse> handleRuntimeException(RuntimeException e) {
            if (e instanceof AppException) {
                return handleAppException((AppException) e); // Delegate
            }
            ApiResponse ApiResponse = new ApiResponse();
            ApiResponse.setCode(ErrorCode.ERROR_NOT_FOUND.getCode());
            ApiResponse.setMessage(ErrorCode.ERROR_NOT_FOUND.getMessage());
            return ResponseEntity.badRequest().body(ApiResponse);
        }


    @SuppressWarnings("rawtypes")
    @ExceptionHandler(AppException.class)
    ResponseEntity<ApiResponse> handleAppException(AppException e) {
        System.err.println(e.getErrorCode().getCode());
        ApiResponse ApiResponse = new ApiResponse();
        ApiResponse.setCode(e.getErrorCode().getCode());
        ApiResponse.setMessage(e.getMessage());
        return ResponseEntity.badRequest().body(ApiResponse);
    }


    @SuppressWarnings("rawtypes")
    @ExceptionHandler(IllegalArgumentException.class)
    ResponseEntity<ApiResponse> handleIllegalArgumentException(IllegalArgumentException e) {
        ApiResponse ApiResponse = new ApiResponse();
        ApiResponse.setCode(ErrorCode.PASSWORD_NOT_VALID.getCode());
        ApiResponse.setMessage(ErrorCode.PASSWORD_NOT_VALID.getMessage());
        return ResponseEntity.badRequest().body(ApiResponse);
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
