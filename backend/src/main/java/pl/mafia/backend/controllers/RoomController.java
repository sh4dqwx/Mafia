package pl.mafia.backend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.repositories.RoomRepository;  // Assuming you have a RoomRepository
import pl.mafia.backend.models.Room;  // Update import to Room
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
public class RoomController {

    @Autowired
    private RoomRepository roomRepository;

    @GetMapping("/room")
    public List<Room> get(){
        return (List<Room>) roomRepository.findAll();
    }

    @GetMapping("/room/{id}")
    public Room get(@PathVariable String id){
        long roomId = Long.parseLong(id);
        return roomRepository.findById(roomId).get();
    }

    @DeleteMapping("/room/{id}")
    public void delete(@PathVariable String id) {
        long roomId = Long.parseLong(id);
        Room room = roomRepository.findById(roomId).get();
        if (room == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        } else {
            roomRepository.delete(room);
        }
    }

    @PostMapping("/room/")
    public Room create(@RequestBody Room room) {
        return roomRepository.save(room);
    }

}
