package pl.mafia.backend.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "RoomSetting")
@Data
public class RoomSettings {
    private Room room;
    private boolean isPublic;
    private int numberOfPlayers;
}
