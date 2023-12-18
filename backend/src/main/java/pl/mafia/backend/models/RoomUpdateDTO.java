package pl.mafia.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class RoomUpdateDTO {
    private List<String> accounts;
    private Long hostId;
    private boolean isPublic;
}