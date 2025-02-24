package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.dto.response.User.UserResponseUser_Slot;
import com.smartparking.smartbrain.model.User;

@Mapper(componentModel = "spring")
public interface UserMapper {

    @Mapping(target="roles",ignore = true)// need custom
    @Mapping(target = "password", ignore = true)// need custom
    @Mapping(target = "createdDate", ignore = true)
    @Mapping(target = "invoices", ignore = true)
    @Mapping(target = "monthlyTickets", ignore = true)
    @Mapping(target = "parkingLots", ignore = true)
    @Mapping(target = "transactions", ignore = true)
    @Mapping(target = "updatedDate", ignore = true)
    @Mapping(target = "userId", ignore = true)
    @Mapping(target = "vehicles", ignore = true)
    @Mapping(target = "wallets", ignore = true)
    User fromCreateToUser(UserRequest userRequest);


    @Mapping(target = "roles",ignore = true)// need custom
    UserResponse toUserResponse(User user);

    @Mapping(target = "roles",ignore = true)// need custom
    UserResponseUser_Slot toResponseUser_Slot(User user);
    
    @Mapping(target = "roles", ignore = true)// need custom
    @Mapping(target = "password", ignore = true)// need custom
    @Mapping(target = "createdDate", ignore = true)
    @Mapping(target = "invoices", ignore = true)
    @Mapping(target = "monthlyTickets", ignore = true)
    @Mapping(target = "parkingLots", ignore = true)
    @Mapping(target = "transactions", ignore = true)
    @Mapping(target = "updatedDate", ignore = true)
    @Mapping(target = "userId", ignore = true)
    @Mapping(target = "username", ignore = true)
    @Mapping(target = "vehicles", ignore = true)
    @Mapping(target = "wallets", ignore = true)
    void updateUserFromRequest(UpdatedUserRequest request, @MappingTarget User user);



    
}
