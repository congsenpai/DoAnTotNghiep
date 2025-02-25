package com.smartparking.smartbrain.service;
import java.util.HashSet;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.UserMapper;
import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;

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
        return userMapper.toUserResponse(user);
    }

    @PreAuthorize("hasRole('ADMIN')")
    public List<UserResponse> getAllUser() {
        return userRepository.findAll().stream()
        .map(userMapper::toUserResponse)
        .toList();
    }

    @PreAuthorize("#id == authentication.token.claims['userId'] or hasRole('ADMIN')")
    public UserResponse getUserById(String id) {
        User user = userRepository.findById(id)
        .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        return userMapper.toUserResponse(user);
    }

    @PreAuthorize("#name == authentication.name or hasRole('ADMIN')")
    public UserResponse getUserByName(String name) {
        User user = userRepository.findByUsername(name)
            .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        return userMapper.toUserResponse(user);
    }

    @PreAuthorize("#id == authentication.token.claims['userId'] or hasRole('ADMIN')")
    public void deleteUser(String id) {
        if (!userRepository.existsById(id)) {
            throw new AppException(ErrorCode.USER_NOT_FOUND);
        }
        userRepository.deleteById(id);
    }
    
    @PreAuthorize("#id == authentication.token.claims['userId'] or hasRole('ADMIN')")
    public UserResponse updateInfoUser(String id, UpdatedUserRequest request) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        userMapper.updateUserFromRequest(request, user);
        
        // Lấy danh sách roles từ repository theo id roles được truyền vào request
        var roles = roleRepository.findAllById(request.getRoles());
        user.setRoles(new HashSet<>(roles));
        
        userRepository.save(user);
        return userMapper.toUserResponse(user);
    }
    
    
}
