package com.smartparking.smartbrain.dto.request.User;

import java.util.Set;

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
public class UserRequest {
    String username;
    @Size(min = 6, message = "Password must be at least 6 characters")
    String password;
    String firstName;
    String lastName;
    String email;
    String phone;
    String homeAddress;
    String companyAddress;
    Set<String> roles;
    boolean status;
    String images;
}
