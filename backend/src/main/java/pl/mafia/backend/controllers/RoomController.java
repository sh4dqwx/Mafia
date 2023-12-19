package pl.mafia.backend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.models.RoomSettings;
import pl.mafia.backend.repositories.RoomRepository;  // Assuming you have a RoomRepository
import pl.mafia.backend.models.Room;  // Update import to Room
import org.springframework.web.bind.annotation.*;
import pl.mafia.backend.services.RoomService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping("/public")
    public List<Room> getPublicRooms() {
        try {
            return roomService.getPublicRooms();
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @GetMapping("/code/{accessCode}")
    public Room getRoomByAccessCode(@PathVariable String accessCode) {
        try {
            return roomService.getRoomByAccessCode(accessCode);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @GetMapping("/{id}")
    public Room getRoomById(@PathVariable String id) {
        try {
            return roomService.getRoomById(id);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public void deleteRoomById(@PathVariable String id) {
        try {
            roomService.deleteRoomById(id);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @PostMapping()
    public Room createRoom(@RequestBody Room room) {
        try {
            return roomService.createRoom(room);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @PutMapping("/properties/{id}")
    public void updateProperties(@RequestBody RoomSettings roomSettings, @PathVariable String id) {
        try {
            roomService.updateProperties(roomSettings, id);
        } catch (IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }
}
