package com.smartparking.smartbrain.exception;

public enum ErrorCode {
    // System errors
    ERROR_NOT_FOUND(0001,"error special"),

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

    // ParkingSpot errors
    PARKINGSPOT_NOT_FOUND(2001, "parking spot not found"),
    PARKINGSPOT_ALREADY_EXISTS(2002,"parking spot alrealy exitst"),
    PARKINGSPOT_NOT_EXISTS(2003,"parking spot not exists"),
    FALSE_UPDATE_STATUS_SPOT(2004,"updating spot status false"),

    // Image errors
    IMAGE_NOT_FOUND(3001, "image not found"),
    IMAGE_ALREADY_EXISTS(3002,"image alrealy exitst"),
    IMAGE_NOT_EXISTS(3003,"image not exists"),
    IMAGE_UPDATE_STATUS_SLOT(3004,"updating image status false"),

    // ParkingSlot errors
    SLOT_NOT_FOUND(4001, "slot not found"),
    SLOT_ALREADY_EXISTS(4002,"slot alrealy exitst"),
    SLOT_NOT_EXISTS(4003,"slot not exists"),
    FALSE_UPDATE_STATUS_SLOT(4004,"updating slot status false");

    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
    private int code;
    private String message;

    public int getCode() {
        return code;
    }
    public String getMessage() {
        return message;
    }
}
