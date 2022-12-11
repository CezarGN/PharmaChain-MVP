package com.zeroideas.hackathon.DTO;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PharmacyDrugsDto{
    long pharmacyId;
        private String name;
        private String schedule;
        private float positionX;
        private float positionY;
        private String drugName;
        private int price;
}
