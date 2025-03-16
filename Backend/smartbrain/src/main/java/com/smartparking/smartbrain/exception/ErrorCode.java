package com.smartparking.smartbrain.exception;

public enum ErrorCode {

    // System errors
    ERROR_NOT_FOUND(0001,"Error special"),
    NOT_REFRESH_TOKEN(0002,"Not refresh token"),
    NOT_ACCESS_TOKEN(0003,"Not access token"),
    INVALID_TOKEN(0004,"Invalid token"),


    // User errors
    USER_NOT_FOUND(1001, "User not found"),
    USER_ALREADY_EXISTS(1002, "User already exists"),
    PASSWORD_NOT_MATCH(1003, "Password not match"),
    PASSWORD_NOT_VALID(1004, "Password not valid"),
    INVALID_CREDENTIALS(1005, "Invalid credentials"),
    UNAUTHORIZED(1006, "Unauthorized"),
    INVALID_REQUEST(1007, "Invalid request"),
    INTERNAL_SERVER_ERROR(1008, "Internal server error"),
    USER_NOT_EXISTS(1009, "User not exists"),
    TOKEN_EXPIRED(1010, "Token expired"),


     // ParkingSpot errors
    PARKING_LOT_NOT_FOUND(2001, "parking spot not found"),
    PARKING_LOT_ALREADY_EXISTS(2002,"parking spot alrealy exitst"),
    PARKING_LOT_NOT_EXISTS(2003,"parking spot not exists"),
    FALSE_UPDATE_STATUS_LOT(2004,"updating spot status false"),

     // Image errors
    IMAGE_NOT_FOUND(3001, "image not found"),
    IMAGE_ALREADY_EXISTS(3002,"image alrealy exitst"),
    IMAGE_NOT_EXISTS(3003,"image not exists"),
    IMAGE_UPDATE_STATUS_SLOT(3004,"updating image status false"),

     // ParkingSlot errors
    PARKING_SLOT_NOT_FOUND(4001, "slot not found"),
    PARKING_SLOT_ALREADY_EXISTS(4002,"slot alrealy exitst"),
    PARKING_SLOT_NOT_EXISTS(4003,"slot not exists"),
    FALSE_UPDATE_STATUS_SLOT(4004,"updating slot status false"),
    TOTAL_SLOT_EXCEED(4005,"total slot exceed, can't use auto create slot, please create slot manually"),

    // Wallet errors
    WALLET_NOT_FOUND(5001, "Wallet not found"),
    INVALID_CURRENCY(5002, "Invalid currency"),
    CURRENCY_MISMATCH(5003, "Currency mismatch"),
    
    // Permission errors
    PERMISSION_NOT_FOUND(6001,"Permission not found"),
    PERMISSION_ALREADY_EXISTS(6002,"Permission already exists"),
    PERMISSION_NOT_EXISTS(6003,"Permission not exists"),

    // Promotion errors
    DISCOUNT_NOT_FOUND(7001,"Discount not found"),
    DISCOUNT_NOT_EXISTS(7002,"Discount not exists"),
    // Vehicle
    VEHICLE_NOT_FOUND(8001,"Permission not found"),
    VEHICLE_ALREADY_EXISTS(8002,"Permission already exists"),
    VEHICLE_NOT_EXISTS(8003,"Permission not exists"),
    // Role errors
    ROLE_NOT_FOUND(9001,"Permission not found"),
    ROLE_ALREADY_EXISTS(9002,"Permission already exists"),
    ROLE_NOT_EXISTS(9003,"Permission not exists"),





    ;


    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
    private final int code;
    private final String message;

    public int getCode() {
        return code;
    }
    public String getMessage() {
        return message;
    }
}
