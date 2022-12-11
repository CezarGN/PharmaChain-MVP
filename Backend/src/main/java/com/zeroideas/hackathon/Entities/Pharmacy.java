package com.zeroideas.hackathon.Entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "pharmacy")
public class Pharmacy {
    @Id
    @Column(name = "id")
    long id;
    @Column(name = "name")
    private String name;
    @Column(name = "schedule")
    private String schedule;
    @Column(name = "address_x")
    private float positionX;
    @Column(name = "address_y")
    private float positionY;

}
