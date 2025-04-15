package com.smartparking.smartbrain.controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.Role.RoleRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Role.RoleResponse;
import com.smartparking.smartbrain.service.RoleService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/myparkingapp/roles")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class RoleController {
    RoleService RoleService;

    @PostMapping
    public ApiResponse<RoleResponse> createRole(@RequestBody RoleRequest RoleRequest) {
        return ApiResponse.<RoleResponse>builder()
        .result(RoleService.createRole(RoleRequest))
        .build();
        
    }

    @GetMapping
    public ApiResponse<List<RoleResponse>>getAllRole() {
        return ApiResponse.<List<RoleResponse>>builder()
        .result(RoleService.getAllRoles())
        .build();
    }
    
    @DeleteMapping("/{RoleName}")
    public ApiResponse<Void> deleteRole(@PathVariable String RoleName) {
        RoleService.deleteRole(RoleName);
        return ApiResponse.<Void>builder()
        .build();
    }
    
}
