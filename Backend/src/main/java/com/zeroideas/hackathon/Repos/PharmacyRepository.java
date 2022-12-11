package com.zeroideas.hackathon.Repos;

import com.zeroideas.hackathon.Entities.Pharmacy;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PharmacyRepository extends JpaRepository<Pharmacy,Long> {
  List<Pharmacy> findById(long Id);
}
