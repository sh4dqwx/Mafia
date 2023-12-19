package pl.mafia.backend.models.db;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "Game")
@Data
public class Game {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "game_sequence")
    @SequenceGenerator(name = "game_sequence", sequenceName = "GAME_SEQ", allocationSize = 1)
    private Long id;

    @Column(nullable = false)
    private Timestamp createTimestamp;

    @ToString.Exclude
    @ManyToMany(mappedBy = "games")
    private List<Account> accounts;

    @ToString.Exclude
    @OneToMany(mappedBy = "game")
    private List<Round> rounds;
}
