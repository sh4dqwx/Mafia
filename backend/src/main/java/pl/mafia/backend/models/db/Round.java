package pl.mafia.backend.models.db;

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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "round_sequence")
    @SequenceGenerator(name = "round_sequence", sequenceName = "ROUND_SEQ", allocationSize = 1)
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
    @JoinColumn(name = "id_voting_city", unique = true)
    private Voting votingCity;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_voting_mafia", unique = true)
    private Voting votingMafia;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_voting_reward", unique = true)
    private Voting votingReward;

    @ToString.Exclude
    @OneToMany(mappedBy = "round")
    private List<RoundMiniGame> roundMiniGames;
}
