package com.zeroideas.hackathon.DTO;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
//dto for the link up between a specific drug and a pharmacy. it is basically a one to one relationship,
//because a drug has a different price depending on the pharmacy
public class PharmacyDrugsDto{
    long pharmacyId;
        private String name;
        private String schedule;
        private float positionX;
        private float positionY;
        private String drugName;
        private int price;
}
