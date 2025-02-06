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
import com.smartparking.smartbrain.dto.request.ImageSpot.CreatedImageRequest;
import com.smartparking.smartbrain.dto.request.ImageSpot.UpdateStatusImageRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.service.ImageSevice;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/myparkingapp/images")
public class ImageController {
    @Autowired
    private ImageSevice imageSevice;

    @PostMapping
    ApiResponse<Image> createRequestImage(@RequestBody @Valid CreatedImageRequest request){
        ApiResponse<Image> ApiResponse = new ApiResponse<Image>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("parking spot created sucessfully");
        ApiResponse.setResult(imageSevice.createImages(request));
        return ApiResponse;
    }

    @GetMapping
    ApiResponse<List<Image>> getImage(){
        ApiResponse<List<Image>> ApiResponse = new ApiResponse<List<Image>>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Image fetched successfully");
        ApiResponse.setResult(imageSevice.getImage());
        return ApiResponse;
    }

    @DeleteMapping("/{id}")
    ApiResponse<String> deleteImage(@PathVariable String id){
        ApiResponse<String> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        imageSevice.deleteImage(id);;
        ApiResponse.setMessage("Image deleted successfully");
        return ApiResponse;
    }

    @PatchMapping("/{id}/status")
    ApiResponse<Image> updateStateImage(@PathVariable String id, @RequestBody UpdateStatusImageRequest request){
        ApiResponse<Image> ApiResponse = new ApiResponse<>();
        ApiResponse.setCode(200);
        ApiResponse.setMessage("Image Status update successfully");
        ApiResponse.setResult(imageSevice.updatedStatusImageParkingSpot(id, request));
        return ApiResponse;
    }



    
}
