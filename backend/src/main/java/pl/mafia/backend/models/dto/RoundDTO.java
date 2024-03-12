package pl.mafia.backend.models.dto;

import lombok.Data;
import lombok.NonNull;
import pl.mafia.backend.models.db.Round;

@Data
public class RoundDTO {
    @NonNull Long id;
    @NonNull Long votingCityId;

    public RoundDTO(Round round) {
        this.id = round.getId();
        this.votingCityId = round.getVotingCity().getId();
    }
}
