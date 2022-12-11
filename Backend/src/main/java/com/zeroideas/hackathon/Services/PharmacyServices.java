package com.zeroideas.hackathon.Services;

import com.zeroideas.hackathon.Repos.PharmacyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//For future use: good to have this service class
@Service
public class PharmacyServices {
    @Autowired
   PharmacyRepository pharmacyRepository;
}
