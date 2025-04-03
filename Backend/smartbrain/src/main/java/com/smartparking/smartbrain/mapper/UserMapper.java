package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Named;

import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.dto.response.User.UserResponseUser_Slot;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.model.User;

@Mapper(componentModel = "spring")
public interface UserMapper {

    @Mapping(target="roles",ignore = true)// need custom
    @Mapping(target = "password", ignore = true)// need custom
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "invoices", ignore = true)
    @Mapping(target = "monthlyTickets", ignore = true)
    @Mapping(target = "parkingLots", ignore = true)
    @Mapping(target = "transactions", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "userID", ignore = true)
    @Mapping(target = "vehicles", ignore = true)
    @Mapping(target = "wallets", ignore = true)
    @Mapping(target = "ratings", ignore = true)
    @Mapping(target="status",ignore = true)// need custom
    @Mapping(target = "image", ignore = true)
    User fromCreateToUser(UserRequest userRequest);

    @Mapping(source = "image", target = "image", qualifiedByName = "imageToString")
    UserResponse toUserResponse(User user);

    @Mapping(target = "roles",ignore = true)// need custom
    UserResponseUser_Slot toResponseUser_Slot(User user);
    
    @Mapping(target = "roles", ignore = true)// need custom
    @Mapping(target = "password", ignore = true)// need custom
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "invoices", ignore = true)
    @Mapping(target = "monthlyTickets", ignore = true)
    @Mapping(target = "parkingLots", ignore = true)
    @Mapping(target = "transactions", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "userID", ignore = true)
    @Mapping(target = "username", ignore = true)
    @Mapping(target = "vehicles", ignore = true)
    @Mapping(target = "wallets", ignore = true)
    @Mapping(target = "ratings", ignore = true)
    @Mapping(target = "image", ignore = true)// need custom
    void updateUserFromRequest(UpdatedUserRequest request, @MappingTarget User user);



    
    @Named("imageToString")
    default String imageToString(Image image) {
        return image.getUrl();
    }
}
