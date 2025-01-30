package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.smartparking.smartbrain.dto.request.UserRequest;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.service.UserService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/myparkingapp/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping
    ApiRequest<User> createRequestUser(@RequestBody @Valid UserRequest request){
        @SuppressWarnings({ "rawtypes", "unchecked" })
        ApiRequest<User> apiRequest = new ApiRequest();
        apiRequest.setCode(200);
        apiRequest.setMessage("user created successfully");
        apiRequest.setResult(userService.createReqUser(request));
        return apiRequest;
    }

    @GetMapping
    ApiRequest<List<User>> getUser(){
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

    @PatchMapping("/{id}/state")
    ApiRequest<User> updateStateUser(@PathVariable String id, @RequestBody UserRequest request){
        ApiRequest<User> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("User updated successfully");
        apiRequest.setResult(userService.updatedStateUser(id, request));
        return apiRequest;
    }

    @PatchMapping("/{id}/role")
    ApiRequest<User> updateRoleUser(@PathVariable String id, @RequestBody UserRequest request){
        ApiRequest<User> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Role User updated successfully");
        apiRequest.setResult(userService.updatedRoleUser(id, request));
        return apiRequest;
    }

    @PutMapping("/{id}")
    ApiRequest<User> updateUser(@PathVariable String id, @RequestBody UserRequest request){
        ApiRequest<User> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("User updated successfully");
        apiRequest.setResult(userService.updateUser(id, request));
        return apiRequest;
    }
}
