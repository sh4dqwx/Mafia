package pl.mafia.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "Round")
@Data
public class Round {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "id_game")
    private Game game;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "id_reward")
    private Reward reward;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_voting_city")
    private Voting votingCity;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_voting_mafia")
    private Voting votingMafia;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_voting_reward")
    private Voting votingReward;

    @ToString.Exclude
    @OneToMany(mappedBy = "round")
    private List<RoundMiniGame> roundMiniGames;
}
