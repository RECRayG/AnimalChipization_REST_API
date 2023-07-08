package ru.chipization.achip.controllers;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.chipization.achip.dto.request.LocationRequest;
import ru.chipization.achip.dto.response.LocationResponse;
import ru.chipization.achip.exception.AlreadyExistException;
import ru.chipization.achip.model.ChippingLocation;
import ru.chipization.achip.repository.ChippingLocationRepository;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/locations")
@AllArgsConstructor
public class LocationsController {
    @Autowired
    private ChippingLocationRepository chippingLocationRepository;

    @GetMapping("/{pointId}")
    public ResponseEntity<?> getLocationById(@PathVariable Long pointId) {
        // Проверка на 400 - валидность данных
        if(pointId == null || pointId <= 0) {
            return ResponseEntity.status(400).body("Id: " + pointId + " is not correct");
        }

        // Проверка на 404 - существование точки локации
        Optional<ChippingLocation> chippingLocationCheck = chippingLocationRepository.findById(pointId);
        if(chippingLocationCheck.isEmpty()) {
            return ResponseEntity.status(404).body("Point of location with id: " + pointId + " not found");
        }

        ChippingLocation location = chippingLocationCheck.get();

        return new ResponseEntity<LocationResponse>(LocationResponse.builder()
                                                    .id(location.getId())
                                                    .latitude(location.getLatitude())
                                                    .longitude(location.getLongitude())
                                                    .build(),
                                                    HttpStatus.OK);
    }

    @PostMapping()
    public ResponseEntity<?> addLocation(@RequestBody LocationRequest insertLocation) {
        // Проверка на 400 - валидность данных
        if(insertLocation.getLatitude() == null || insertLocation.getLatitude() < -90 || insertLocation.getLatitude() > 90 ||
            insertLocation.getLongitude() == null || insertLocation.getLongitude() < -180 || insertLocation.getLongitude() > 180) {

            return ResponseEntity.status(400).body("No valid data");
        }

        // Проверка на 409 - точка локации уже существует
        List<ChippingLocation> chippingLocationList = chippingLocationRepository.findAll();
        try {
            chippingLocationList.forEach(chl -> {
                if(chl.getLatitude().equals(insertLocation.getLatitude()) &&
                        chl.getLongitude().equals(insertLocation.getLongitude())) {
                    throw new AlreadyExistException("Location with (latitude;longitude): (" + insertLocation.getLatitude() + "; " + insertLocation.getLongitude() + ") already exist");
                }
            });
        } catch(AlreadyExistException eae) {
            return ResponseEntity.status(409).body(eae.getMessage());
        }

        var location = ChippingLocation.builder()
                .latitude(insertLocation.getLatitude())
                .longitude(insertLocation.getLongitude())
                .build();

        chippingLocationRepository.save(location);

        return ResponseEntity.status(201).body(LocationResponse.builder()
                                                .id(chippingLocationRepository.findChippingLocationByLongitudeAndLatitude(location.getLongitude(), location.getLatitude()).get().getId())
                                                .latitude(location.getLatitude())
                                                .longitude(location.getLongitude())
                                                .build());
    }

    @PutMapping("/{pointId}")
    public ResponseEntity<?> updatePointType(@PathVariable Long pointId, @RequestBody LocationRequest updateLocation) {
        // Проверка на 400 - валидность данных
        if(pointId == null || pointId <= 0 ||
            updateLocation.getLatitude() == null || updateLocation.getLatitude() < -90 || updateLocation.getLatitude() > 90 ||
            updateLocation.getLongitude() == null || updateLocation.getLongitude() < -180 || updateLocation.getLongitude() > 180) {

            return ResponseEntity.status(400).body("No valid data");
        }

        // Проверка на 404 - существование точки локации
        Optional<ChippingLocation> chippingLocationCheck = chippingLocationRepository.findById(pointId);
        if(chippingLocationCheck.isEmpty()) {
            return ResponseEntity.status(404).body("Point of location with id: " + pointId + " not found");
        }

        ChippingLocation location = chippingLocationCheck.get();

        // Проверка на 409 - точка локации уже существует
        List<ChippingLocation> chippingLocationList = chippingLocationRepository.findAll();
        try {
            chippingLocationList.forEach(chl -> {
                if(chl.getLatitude().equals(updateLocation.getLatitude()) &&
                        chl.getLongitude().equals(updateLocation.getLongitude())) {
                    throw new AlreadyExistException("Location with (latitude;longitude): (" + updateLocation.getLatitude() + "; " + updateLocation.getLongitude() + ") already exist");
                }
            });
        } catch(AlreadyExistException eae) {
            return ResponseEntity.status(409).body(eae.getMessage());
        }

        location.setLatitude(updateLocation.getLatitude());
        location.setLongitude(updateLocation.getLongitude());

        chippingLocationRepository.save(location);

        return ResponseEntity.status(200).body(LocationResponse.builder()
                                            .id(location.getId())
                                            .latitude(location.getLatitude())
                                            .longitude(location.getLongitude())
                                            .build());
    }

    @DeleteMapping("/{pointId}")
    public ResponseEntity<?> deleteLocation(@PathVariable Long pointId) {
        // Проверка на 400 - валидность данных
        if(pointId == null || pointId <= 0) {
            return ResponseEntity.status(400).body("Id: " + pointId + " is not correct");
        }

        // Проверка на 404 - существование точки локации
        Optional<ChippingLocation> chippingLocationCheck = chippingLocationRepository.findById(pointId);
        if(chippingLocationCheck.isEmpty()) {
            return ResponseEntity.status(404).body("Point of location with id: " + pointId + " not found");
        }

        ChippingLocation location = chippingLocationCheck.get();

        // Проверка на 400 - связь точки локации с животными
        if(!location.getAnimalCollection().isEmpty()) {
            return ResponseEntity.status(400).body("Location with (latitude;longitude): (" + location.getLatitude() + "; " + location.getLongitude() + ") associated with animals");
        } else {
            chippingLocationRepository.delete(location);
            return ResponseEntity.status(200).body("Successful removal");
        }
    }

    @GetMapping("/")
    public ResponseEntity<?> getLocationByIdEmpty() {
        return ResponseEntity.status(400).body("Id is null");
    }

    @PutMapping("/")
    public ResponseEntity<?> updateLocationEmpty() {
        return ResponseEntity.status(400).body("Id is null");
    }

    @DeleteMapping("/")
    public ResponseEntity<?> deleteLocationEmpty() {
        return ResponseEntity.status(400).body("Id is null");
    }
}
