package pl.mafia.backend.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "Voting")
@Data
public class Voting {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ToString.Exclude
    @OneToOne
    @JoinColumn(name = "id_round")
    private Round round;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "id_account")
    private Account account;

    @ToString.Exclude
    @OneToMany(mappedBy = "voting")
    private List<Vote> votes;
}
