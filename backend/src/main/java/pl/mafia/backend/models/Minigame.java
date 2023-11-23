package pl.mafia.backend.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "Minigame")
@Data
public class Minigame {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @ToString.Exclude
    @OneToMany(mappedBy = "minigame")
    private List<RoundMiniGame> roundMiniGames;
}
