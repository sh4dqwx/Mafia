package pl.mafia.backend.models.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NonNull;
import pl.mafia.backend.models.db.Room;

import java.util.List;

@Data
public class RoomDTO {
    @NonNull private Long id;
    @NonNull private List<AccountDTO> accounts;
    @NonNull private Long hostId;
    @NonNull private String accessCode;
    @NonNull private RoomSettingsDTO roomSettings;

    public RoomDTO(Room room) {
        this.id = room.getId();
        this.accounts = room.getAccounts()
                .stream()
                .map(AccountDTO::new)
                .toList();
        this.hostId = room.getHost().getId();
        this.accessCode = room.getAccessCode();
        this.roomSettings = new RoomSettingsDTO(room.getRoomSettings());
    }
}