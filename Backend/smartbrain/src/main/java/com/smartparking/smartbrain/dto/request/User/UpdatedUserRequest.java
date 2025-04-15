package com.smartparking.smartbrain.dto.request.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.Set;

import lombok.AccessLevel;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UpdatedUserRequest {
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String homeAddress;
    private String companyAddress;
    private String avatar;
    private String status;
    private Set<String>roles;
}
