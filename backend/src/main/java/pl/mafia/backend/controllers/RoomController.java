package pl.mafia.backend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.repositories.RoomRepository;  // Assuming you have a RoomRepository
import pl.mafia.backend.models.Room;  // Update import to Room
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomRepository roomRepository;

    @GetMapping("/public")
    public List<Room> getPublicRooms(){
        return roomRepository.findByAccessCodeNull();
    }

    @GetMapping("/private/{accessCode}")
    public Room getPrivateRoomByAccessCode(@PathVariable String accessCode) {
        Optional<Room> room = roomRepository.findByAccessCode(accessCode);
        if (room.isPresent())
            return room.get();
        else
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
    }

    @GetMapping("/{id}")
    public Room getRoomById(@PathVariable String id){
        long roomId = Long.parseLong(id);
        Optional<Room> room = roomRepository.findById(roomId);
        if (room.isPresent())
            return room.get();
        else
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/{id}")
    public void deleteRoomById(@PathVariable String id) {
        long roomId = Long.parseLong(id);
        Optional<Room> room = roomRepository.findById(roomId);
        if (room.isPresent())
            roomRepository.delete(room.get());
        else
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
    }

    @PostMapping()
    public Room createRoom(@RequestBody Room room) {
        Optional<Room> hostRoom = roomRepository.findByHost(room.getHost());
        if (hostRoom.isPresent())
            throw new ResponseStatusException(HttpStatus.CONFLICT);
        else
            return roomRepository.save(room);
    }
}
