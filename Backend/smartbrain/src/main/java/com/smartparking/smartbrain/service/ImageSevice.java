package com.smartparking.smartbrain.service;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;
import com.smartparking.smartbrain.dto.request.ImageSpot.CreatedImageRequest;
import com.smartparking.smartbrain.dto.request.ImageSpot.UpdateStatusImageRequest;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.model.ParkingSpot;
import com.smartparking.smartbrain.repository.ImagesRepository;
import com.smartparking.smartbrain.repository.ParkingSpotRepository;
@Service
public class ImageSevice {
    private ImagesRepository imagesRepository;
    private ParkingSpotRepository parkingSpotRepository;
    public Image createImages(CreatedImageRequest request){
        Image images = new Image();
        images.setNoteString(request.getNoteString());
        images.setStatus(request.isStatus());
        images.setCreatedDate(Timestamp.from(Instant.now()));
        images.setUpdatedDate(Timestamp.from(Instant.now()));
        images.setUrlString(request.getUrlString());
        Optional<ParkingSpot> parkingspot = parkingSpotRepository.findById(request.getParkingSpotID());
        if(parkingspot.isEmpty()){
            throw new AppException(ErrorCode.PARKINGSPOT_NOT_FOUND);
        }
        images.setParkingSpot(parkingspot.get());
        return imagesRepository.save(images);
    }

    public void deleteImage(String id){
        if(!imagesRepository.existsById(id)){
            throw new RuntimeException("Image found");
        }
        imagesRepository.deleteById(id);
    }

    public List<Image> getImage(){
        return imagesRepository.findAll();
    }

    public Image updatedStatusImageParkingSpot(String id, UpdateStatusImageRequest request){
        Image images = imagesRepository.findById(id).get();
        images.setStatus(request.isStatus());
        images.setUpdatedDate(Timestamp.from(Instant.now()));
        return imagesRepository.save(images);
    }; 
}
