package pl.mafia.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
public class JoinRoomResponse {
    private List<Account> accounts;
    private Long hostId;
    private boolean isPublic;
    private boolean error;
    private String errorMessage;

    public JoinRoomResponse(List<Account> accounts, Long hostId, boolean isPublic) {
        this.accounts = accounts;
        this.hostId = hostId;
        this.isPublic = isPublic;
        this.error = false;
    }

    public JoinRoomResponse(String errorMessage) {
        this.errorMessage = errorMessage;
        this.error = true;
    }
}