package com.smartparking.smartbrain.controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.Permission.PermissionRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Permission.PermissionResponse;
import com.smartparking.smartbrain.service.PermissionService;

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
@RequestMapping("/myparkingapp/permissions")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PermissionController {
    final PermissionService permissionService;

    @PostMapping
    public ApiResponse<PermissionResponse> createPermission(@RequestBody PermissionRequest permissionRequest) {
        return ApiResponse.<PermissionResponse>builder()
        .result(permissionService.createPermission(permissionRequest))
        .build();
        
    }

    @GetMapping
    public ApiResponse<List<PermissionResponse>>getAllPermission() {
        return ApiResponse.<List<PermissionResponse>>builder()
        .result(permissionService.getAllPermissions())
        .build();
    }

    @DeleteMapping("/{permissionName}")
    public ApiResponse<Void> deletePermission(@PathVariable String permissionName) {
        permissionService.deletePermission(permissionName);
        return ApiResponse.<Void>builder()
        .build();
    }
    
}
