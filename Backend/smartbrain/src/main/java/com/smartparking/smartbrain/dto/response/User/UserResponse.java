package com.smartparking.smartbrain.dto.response.User;

import java.util.Set;

import com.smartparking.smartbrain.dto.response.Role.RoleResponse;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserResponse {
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String homeAddress;
    private String companyAddress;
    private Set<RoleResponse> roles;
    private boolean status;
    private String avatar;
}
