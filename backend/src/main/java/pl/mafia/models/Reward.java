package pl.mafia.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "Reward")
@Data
public class Reward {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String acquiring_method;

    @ToString.Exclude
    @OneToMany(mappedBy = "reward")
    private List<Round> rounds;
}
