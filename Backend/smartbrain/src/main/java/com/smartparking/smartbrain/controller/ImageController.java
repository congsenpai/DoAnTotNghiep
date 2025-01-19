package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.ApiRequest;
import com.smartparking.smartbrain.dto.request.ImageRequest;
import com.smartparking.smartbrain.model.Images;
import com.smartparking.smartbrain.service.ImageSevice;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/myparkingapp/images")
public class ImageController {
    @Autowired
    private ImageSevice imageSevice;

    @PostMapping
    ApiRequest<Images> createRequestImage(@RequestBody @Valid ImageRequest request){
        ApiRequest<Images> apiRequest = new ApiRequest<Images>();
        apiRequest.setCode(200);
        apiRequest.setMessage("parking spot created sucessfully");
        apiRequest.setResult(imageSevice.createImages(request));
        return apiRequest;
    }

    @GetMapping
    ApiRequest<List<Images>> getImage(){
        ApiRequest<List<Images>> apiRequest = new ApiRequest<List<Images>>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Image fetched successfully");
        apiRequest.setResult(imageSevice.getImage());
        return apiRequest;
    }

    @DeleteMapping
    ApiRequest<String> deleteImage(@PathVariable String id){
        ApiRequest<String> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        imageSevice.deleteImage(id);;
        apiRequest.setMessage("Image deleted successfully");
        return apiRequest;
    }

    @PatchMapping("/{id}/status")
    ApiRequest<Images> updateStateImage(@PathVariable String id, @RequestBody ImageRequest request){
        ApiRequest<Images> apiRequest = new ApiRequest<>();
        apiRequest.setCode(200);
        apiRequest.setMessage("Image Status update successfully");
        apiRequest.setResult(imageSevice.updatedStatusImageParkingSpot(id, request));
        return apiRequest;
    }



    
}
