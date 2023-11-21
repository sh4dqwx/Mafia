package pl.mafia.backend.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

@Entity
@Table(name = "Vote")
@Data
public class Vote {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ToString.Exclude
    @ManyToOne
    @Column(name = "id_voting")
    private Voting voting;

    @ToString.Exclude
    @ManyToOne
    @Column(name = "id_voter")
    private Account voter;

    @ToString.Exclude
    @ManyToOne
    @Column(name = "id_voted")
    private Account voted;
}
