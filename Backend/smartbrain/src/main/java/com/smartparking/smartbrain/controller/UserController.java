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

import com.smartparking.smartbrain.dto.response.ApiResponse;
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
    ApiResponse<User> createRequestUser(@RequestBody @Valid UserRequest request){
        @SuppressWarnings({ "rawtypes", "unchecked" })
        ApiResponse<User> ApiResponse = new ApiResponse();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("user created successfully");
        ApiResponse.setResult(userService.createReqUser(request));
        return ApiResponse;
    }

    @GetMapping
    ApiResponse<List<User>> getUser(){
        @SuppressWarnings({ "rawtypes", "unchecked" })
        ApiResponse<List<User>> ApiResponse = new ApiResponse();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("User fetched successfully");
        ApiResponse.setResult(userService.getUser());
        return ApiResponse;
    }

    @GetMapping("/{id}")
    ApiResponse<User> getUserById(@PathVariable String id){
        ApiResponse<User> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setResult(userService.getUserById(id));
        ApiResponse.setMessage("User fetched successfully");
        return ApiResponse;
    }
    @DeleteMapping("/{id}")
    ApiResponse<String> deleteUser(@PathVariable String id) {
        ApiResponse<String> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        userService.deleteUser(id);
        ApiResponse.setMessage("User deleted successfully");
        return ApiResponse;
    }

    @PatchMapping("/{id}/state")
    ApiResponse<User> updateStateUser(@PathVariable String id, @RequestBody UserRequest request){
        ApiResponse<User> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("User updated successfully");
        ApiResponse.setResult(userService.updatedStateUser(id, request));
        return ApiResponse;
    }

    @PatchMapping("/{id}/role")
    ApiResponse<User> updateRoleUser(@PathVariable String id, @RequestBody UserRequest request){
        ApiResponse<User> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Role User updated successfully");
        ApiResponse.setResult(userService.updatedRoleUser(id, request));
        return ApiResponse;
    }

    @PutMapping("/{id}")
    ApiResponse<User> updateUser(@PathVariable String id, @RequestBody UserRequest request){
        ApiResponse<User> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("User updated successfully");
        ApiResponse.setResult(userService.updateUser(id, request));
        return ApiResponse;
    }
}
