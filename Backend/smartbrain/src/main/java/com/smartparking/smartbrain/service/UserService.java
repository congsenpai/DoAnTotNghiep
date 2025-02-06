package com.smartparking.smartbrain.service;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.sql.Timestamp;
import java.time.Instant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.User.CreatedUserRequest;
import com.smartparking.smartbrain.dto.request.User.UpdatedRoleUserRequest;
import com.smartparking.smartbrain.dto.request.User.UpdatedStatusUserRequest;
import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.enums.Roles;

import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.UserRepository;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    public User createReqUser(CreatedUserRequest request){
            User user = new User();
                if (userRepository.existsByUsername(request.getUsername())) {
                    throw new RuntimeException("ErrorCode.USER_ALREADY_EXISTS");
                }
            user.setUsername(request.getUsername());
            
            if (request.getPassword() == null || request.getPassword().length() < 6) {
                throw new IllegalArgumentException("ErrorCode.PASSWORD_NOT_VALID");
            }
            // Mã hóa mật khẩu
            user.setPassword(passwordEncoder.encode(request.getPassword()));
            user.setFirstName(request.getFirstName());
            user.setLastName(request.getLastName());
            user.setEmail(request.getEmail());
            user.setPhone(request.getPhone());
            user.setAddress(request.getAddress());

            HashSet<String> roles = new HashSet<>();
            roles.add(Roles.CUSTOMER.name());
            user.setRole(roles);
            user.setStatus(true);
            user.setAvatar(request.getAvatar());
            user.setCreatedDate(Timestamp.from(Instant.now()));
            user.setUpdatedDate(Timestamp.from(Instant.now()));

            return userRepository.save(user);
    }
    public List<User> getUser(){
        return userRepository.findAll();
    }
    public User getUserById(String id){
        return userRepository.findById(id).orElseThrow(
            () -> new RuntimeException("User not found"));
    }
    public User getUserByName(String name){
        return userRepository.findByUsername(name).orElseThrow(
            ()-> new RuntimeException("User not found"));
    }
    public void deleteUser(String id){
        if(!userRepository.existsById(id)){
            throw new RuntimeException("User not found");
        }
        userRepository.deleteById(id);   
    }
    public User updatedRoleUser(String id,UpdatedRoleUserRequest request){
        User user = userRepository.findById(id).get();
        Set<String> roles = user.getRole();
        switch (request.getRole()) {
            case 0 -> roles.add(Roles.ADMIN.name());
            case 1 -> roles.add(Roles.SPOT_OWNER.name());
        }
        user.setRole(roles);
        return userRepository.save(user);
    }
    public User updatedStatusUser(String id,UpdatedStatusUserRequest request){
        User user = userRepository.findById(id).get();
        if(user.getStatus()==true){
            user.setStatus(false
            );
        }
        else{
            user.setStatus(true);
        }
        return userRepository.save(user);
    }
    public User updateUser(String id, UpdatedUserRequest request){
        User user = userRepository.findById(id).get();
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new RuntimeException("ErrorCode.USER_ALREADY_EXISTS");
        }
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());
        user.setEmail(request.getEmail());
        user.setPhone(request.getPhone());
        user.setAddress(request.getAddress());
        user.setAvatar(request.getAvatar());
        user.setUpdatedDate(Timestamp.from(Instant.now()));
        return userRepository.save(user);
    }
}
