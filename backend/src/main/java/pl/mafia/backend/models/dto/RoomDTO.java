package pl.mafia.backend.models.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NonNull;

import java.util.List;

@Data
public class RoomDTO {
    @NonNull private Long id;
    @NonNull private List<AccountDTO> accounts;
    @NonNull private Long hostId;
    @NonNull private Boolean isPublic;
}