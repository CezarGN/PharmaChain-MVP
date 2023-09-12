package com.zeroideas.hackathon.Repos;

import com.zeroideas.hackathon.Entities.Drug;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DrugsRepository extends JpaRepository<Drug, Long> {
    List<Drug> findByName(String name);
}
