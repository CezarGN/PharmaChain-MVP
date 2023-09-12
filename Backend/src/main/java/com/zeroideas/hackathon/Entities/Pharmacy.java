package com.zeroideas.hackathon.Entities;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "pharmacy")
public class Pharmacy {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name = "schedule")
    private String schedule;
    @Column(name = "address_x")
    private float positionX;
    @Column(name = "address_y")
    private float positionY;

}
