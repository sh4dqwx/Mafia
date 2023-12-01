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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "room_sequence")
    @SequenceGenerator(name = "room_sequence", sequenceName = "ROOM_SEQ", allocationSize = 1)
    private Long id;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_host")
    private Account host;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_game", unique = true)
    private Game game;

    @Column(name = "access_code", nullable = false)
    private String accessCode;

    @ToString.Exclude
    @OneToMany(mappedBy = "room")
    private List<Account> accounts;
}
