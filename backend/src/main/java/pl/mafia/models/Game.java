package pl.mafia.models;

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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Timestamp createTimestamp;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_room")
    private Room room;

    @ToString.Exclude
    @ManyToMany(mappedBy = "games")
    private List<Account> accounts;

    @ToString.Exclude
    @OneToMany(mappedBy = "game")
    private List<Round> rounds;
}
