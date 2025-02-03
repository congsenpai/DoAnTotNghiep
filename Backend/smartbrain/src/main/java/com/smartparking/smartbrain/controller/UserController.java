package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.ApiRequest;
import com.smartparking.smartbrain.dto.request.User.CreatedUserRequest;
import com.smartparking.smartbrain.dto.request.User.UpdatedRoleUserRequest;
import com.smartparking.smartbrain.dto.request.User.UpdatedStatusUserRequest;
import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.service.UserService;

import jakarta.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/myparkingapp/users")
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService userService;

    @PostMapping
    ApiRequest<User> createRequestUser(@RequestBody @Valid CreatedUserRequest request){
        @SuppressWarnings({ "rawtypes", "unchecked" })
        ApiRequest<User> apiRequest = new ApiRequest();
        apiRequest.setCode(200);
        apiRequest.setMessage("user created successfully");
        apiRequest.setResult(userService.createReqUser(request));
        return apiRequest;
    }

    @GetMapping
    ApiRequest<List<User>> getUser(){

        var authentication =  SecurityContextHolder.getContext().getAuthentication();
        log.info("Username: {}",authentication.getName());
        authentication.getAuthorities().forEach(grantedAuthority -> log.info(grantedAuthority.getAuthority()));
        @SuppressWarnings({ "rawtypes", "unchecked" })
        ApiRequest<List<User>> apiRequest = new ApiRequest();
        apiRequest.setCode(200);
        apiRequest.setMessage("User fetched successfully");
        apiRequest.setResult(userService.getUser());
        return apiRequest;
    }

    @GetMapping("/{id}")
    ApiRequest<User> getUserById(@PathVariable String id){
        ApiRequest<User> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setResult(userService.getUserById(id));
        apiRequest.setMessage("User fetched successfully");
        return apiRequest;
    }
    @DeleteMapping("/{id}")
    ApiRequest<String> deleteUser(@PathVariable String id) {
        ApiRequest<String> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        userService.deleteUser(id);
        apiRequest.setMessage("User deleted successfully");
        return apiRequest;
    }

    @PatchMapping("/{id}/status")
    ApiRequest<User> updateStatusUser(@PathVariable String id, @RequestBody UpdatedStatusUserRequest request){
        ApiRequest<User> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("User updated successfully");
        apiRequest.setResult(userService.updatedStatusUser(id, request));
        return apiRequest;
    }

    @PatchMapping("/{id}/role")
    ApiRequest<User> updateRoleUser(@PathVariable String id, @RequestBody UpdatedRoleUserRequest request){
        ApiRequest<User> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Role User updated successfully");
        apiRequest.setResult(userService.updatedRoleUser(id, request));
        return apiRequest;
    } 

    @PutMapping("/{id}")
    ApiRequest<User> updateUser(@PathVariable String id, @RequestBody UpdatedUserRequest request){
        ApiRequest<User> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("User updated successfully");
        apiRequest.setResult(userService.updateUser(id, request));
        return apiRequest;
    }
}
