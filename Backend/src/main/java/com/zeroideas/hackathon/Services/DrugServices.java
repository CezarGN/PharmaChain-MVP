package com.zeroideas.hackathon.Services;

import com.zeroideas.hackathon.Entities.Drug;
import com.zeroideas.hackathon.Entities.Pharmacy;
import com.zeroideas.hackathon.DTO.PharmacyDrugsDto;
import com.zeroideas.hackathon.Repos.DrugsRepository;
import com.zeroideas.hackathon.Repos.PharmacyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


//We use a builder design pattern to build our dto so that we can extract data about a drug or medicine from our database
@Service
public class DrugServices {

    private final DrugsRepository drugsRepository;
    private final PharmacyRepository pharmacyRepository;

    public DrugServices(DrugsRepository drugsRepository, PharmacyRepository pharmacyRepository) {
        this.drugsRepository = drugsRepository;
        this.pharmacyRepository = pharmacyRepository;
    }

    public List<PharmacyDrugsDto> getPharmacies(String name) {

        List<Drug> drug = drugsRepository.findByName(name);
        drug.sort(Comparator.comparingInt(Drug::getPrice));
        return buildPharmacyDrugsDto(drug, drug.get(0).getName());
    }

    private List<PharmacyDrugsDto> buildPharmacyDrugsDto(List<Drug> pharmacyDrugPrices, String name) {
        List<PharmacyDrugsDto> pharmacyDrugsDtos = new ArrayList<>();
        for (Drug p : pharmacyDrugPrices) {
            pharmacyDrugsDtos.add(getPharmacy(p, name));
        }
        return pharmacyDrugsDtos;
    }

    private PharmacyDrugsDto getPharmacy(Drug pharmacyDrugPrice, String name) {
        List<Pharmacy> pharmacy = pharmacyRepository.findById(pharmacyDrugPrice.getPharmacy_id());
        return PharmacyDrugsDto.builder().
                pharmacyId(pharmacy.get(0).getId()).
                name(pharmacy.get(0).getName()).
                schedule(pharmacy.get(0).getSchedule()).
                positionX(pharmacy.get(0).getPositionX()).
                positionY(pharmacy.get(0).getPositionY()).
                drugName(name).
                price(pharmacyDrugPrice.getPrice()).
                build();
    }
}
