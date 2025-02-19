package com.smartparking.smartbrain.service;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.UserMapper;
import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.model.Role;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.RoleRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserService {
    final UserRepository userRepository;
    final RoleRepository roleRepository;
    final PasswordEncoder passwordEncoder;
    final UserMapper userMapper;
        
    public UserResponse createReqUser(UserRequest request){
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new AppException(ErrorCode.USER_ALREADY_EXISTS);
        }
        if (request.getPassword() == null || request.getPassword().length() < 6) {
            throw new AppException(ErrorCode.PASSWORD_NOT_VALID);
        }
        User user=userMapper.fromCreateToUser(request);
        // Encoded Password
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        // Set roles for user
        var roles= roleRepository.findAllById(request.getRoles());
        user.setRoles(new HashSet<>(roles));
        userRepository.save(user);
        UserResponse userResponse=userMapper.toUserResponse(user);
        Set<String> roleNames = user.getRoles().stream()
                            .map(Role::getRoleName) // Giả sử thuộc tính tên role là 'roleName'
                            .collect(Collectors.toSet());
        userResponse.setRoles(roleNames);
        return userResponse;
    }

    public List<UserResponse> getAllUser(){
        return userRepository.findAll()
        .stream()
        .map(userMapper::toUserResponse)
        .toList();
    }
    public UserResponse getUserById(String id){
        User user=userRepository.findById(id).orElseThrow(
            () -> new AppException(ErrorCode.USER_NOT_FOUND));
        return userMapper.toUserResponse(user);
    }
    public UserResponse getUserByName(String name){
        User user=userRepository.findByUsername(name).orElseThrow(
            ()-> new AppException(ErrorCode.USER_NOT_FOUND));
        return userMapper.toUserResponse(user);
    }

    public void deleteUser(String id){
        if(!userRepository.existsById(id)){
            throw new AppException(ErrorCode.USER_NOT_FOUND);
        }
        userRepository.deleteById(id);
    }

    public UserResponse updateInfoUser(String id, UpdatedUserRequest request) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        userMapper.updateUserFromRequest(request,user);
        // get roles
        var roles = roleRepository.findAllById(request.getRoles());
        user.setRoles(new HashSet<>(roles));
        userRepository.save(user);
        return userMapper.toUserResponse(user);
    }
    
}
