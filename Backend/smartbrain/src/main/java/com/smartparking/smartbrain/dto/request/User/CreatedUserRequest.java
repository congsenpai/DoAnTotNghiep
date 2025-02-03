package com.smartparking.smartbrain.dto.request.User;

import jakarta.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.AccessLevel;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreatedUserRequest {
    private String username;
    @Size(min = 6, message = "Password must be at least 6 characters")
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String address;
    // private String role;
    private boolean status;
    private String avatar;
}
