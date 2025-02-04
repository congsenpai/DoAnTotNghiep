package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.Collections;
import java.util.Set;

import com.smartparking.smartbrain.dto.request.User.CreatedUserRequest;
import com.smartparking.smartbrain.enums.Roles;
import com.smartparking.smartbrain.model.User;


@Mapper(componentModel = "spring")
public interface UserMapper {
    
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    @Mapping(target = "status", constant = "true")
    @Mapping(target = "createdDate", expression = "java(getCurrentTimestamp())")
    @Mapping(target = "updatedDate", expression = "java(getCurrentTimestamp())")
    @Mapping(target = "role", expression = "java(getDefaultRole())")

    
    User toUser(CreatedUserRequest request);

    default Timestamp getCurrentTimestamp() {
        return Timestamp.from(Instant.now());
    }

    default Set<String> getDefaultRole() {
        return Collections.singleton(Roles.CUSTOMER.name());
    }
}