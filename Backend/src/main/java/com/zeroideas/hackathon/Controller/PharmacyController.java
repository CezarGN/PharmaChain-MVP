package com.zeroideas.hackathon.Controller;

import com.zeroideas.hackathon.Services.PharmacyServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

//Controller for future use: good to have
@RestController
public class PharmacyController {

    private final PharmacyServices pharmacyServices;

    public PharmacyController(PharmacyServices pharmacyServices) {
        this.pharmacyServices = pharmacyServices;
    }
}
