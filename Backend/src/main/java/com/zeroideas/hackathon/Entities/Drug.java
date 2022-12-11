package com.zeroideas.hackathon.Entities;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.stereotype.Component;

import java.util.List;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "medicines")
@Component
public class Drug {
    @Id
    long id;
    @Column(name = "name")
    private String name;

    @Column(name = "price")
    private int price;

    @Column(name = "id_pharmacy")
    private int id_pharmacy;
}
