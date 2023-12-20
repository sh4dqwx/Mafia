package pl.mafia.backend.models.db;

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
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "voting_sequence")
    @SequenceGenerator(name = "voting_sequence", sequenceName = "VOTING_SEQ", allocationSize = 1)
    private Long id;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "id_account")
    private Account account;

    @ToString.Exclude
    @OneToMany(mappedBy = "voting")
    private List<Vote> votes;
}
