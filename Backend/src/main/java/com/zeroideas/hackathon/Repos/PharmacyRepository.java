package com.zeroideas.hackathon.Repos;

import com.zeroideas.hackathon.Entities.Pharmacy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PharmacyRepository extends JpaRepository<Pharmacy, Long> {
    List<Pharmacy> findById(long Id);
}
