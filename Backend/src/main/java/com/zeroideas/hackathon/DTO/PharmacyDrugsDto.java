package com.zeroideas.hackathon.DTO;

import lombok.*;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
//dto for the link between a pharmacy and a certain type of drug
public class PharmacyDrugsDto{
    long pharmacyId;
        private String name;
        private String schedule;
        private float positionX;
        private float positionY;
        private String drugName;
        private int price;
}
