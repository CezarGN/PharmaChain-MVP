package com.zeroideas.hackathon.Controller;

import com.zeroideas.hackathon.Entities.Drug;
import com.zeroideas.hackathon.Services.DrugServices;
import com.zeroideas.hackathon.DTO.PharmacyDrugsDto;
import com.zeroideas.hackathon.Repos.DrugsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class DrugController {

    @Autowired
    private DrugServices drugServices;
    @GetMapping("/medicines/{name}")
    public ResponseEntity<List<PharmacyDrugsDto>> getPharmacies(@PathVariable(value = "name") String name) {
        try{
            return new ResponseEntity<>(
                    drugServices.getPharmacies(name),
                    HttpStatus.OK
            );
        }catch(Exception e){
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }
        }
}



