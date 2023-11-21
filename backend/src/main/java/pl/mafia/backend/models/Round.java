package pl.mafia.backend.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

@Entity
@Table(name = "Round")
@Data
public class Round {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_game")
    private Game game;

    @OneToMany
    @JoinColumn(name = "id_voting")
    private Voting voting;

    @OneToMany
    @JoinColumn(name = "id_reward")
    private Reward reward;
}
