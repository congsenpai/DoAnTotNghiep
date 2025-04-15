package com.smartparking.smartbrain.dto.request.User;
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
public class UpdatedUserRequest {
    String firstName;
    String lastName;
    String email;
    String phone;
    String homeAddress;
    String companyAddress;
    String avatar;
    String status;
}
