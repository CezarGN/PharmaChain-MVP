package com.zeroideas.hackathon.Controller;

import com.zeroideas.hackathon.DTO.PharmacyDrugsDto;
import com.zeroideas.hackathon.Services.DrugServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/drugs")
public class DrugController {
    private final DrugServices drugServices;
    public DrugController(DrugServices drugServices) {
        this.drugServices = drugServices;
    }
    //API so we can get the necessary data for our client
    @GetMapping("{name}")
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



