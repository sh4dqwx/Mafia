package pl.mafia.backend.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "Room")
@Data
public class Room {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ToString.Exclude
    @OneToMany
    @JoinColumn(name = "id_host")
    private Account host;

    @ToString.Exclude
    @OneToMany
    @JoinColumn(name = "id_game")
    private Game game;

    @Column(nullable = false)
    private String accessCode;

    @ManyToMany(mappedBy = "rooms")
    private List<Account> accounts;
}
