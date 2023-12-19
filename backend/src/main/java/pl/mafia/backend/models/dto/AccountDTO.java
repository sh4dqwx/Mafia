package pl.mafia.backend.models.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NonNull;

@Data
public class AccountDTO {
    @NonNull private Long id;
    @NonNull private String nickname;
}
