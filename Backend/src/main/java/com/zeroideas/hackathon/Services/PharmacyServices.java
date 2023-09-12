package com.zeroideas.hackathon.Services;

import com.zeroideas.hackathon.Repos.PharmacyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//For future use: good to have this service class
@Service
public class PharmacyServices {
    private final PharmacyRepository pharmacyRepository;
    public PharmacyServices(PharmacyRepository pharmacyRepository) {
        this.pharmacyRepository = pharmacyRepository;
    }


}
