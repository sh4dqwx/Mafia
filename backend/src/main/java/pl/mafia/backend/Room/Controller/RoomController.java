package pl.mafia.backend.Room.Controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.models.Room;

import java.util.List;
import java.util.UUID;

@RestController
public class RoomController {

    @GetMapping("/rooms")
    public List<Room> get(){
        return db.values();
    }

    @GetMapping("/rooms/{id}")
    public Room get(@PathVariable String id){
        Room room = db.get(id);
        if(room == null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return room;
    }

    @DeleteMapping("/rooms/{id}")
    public void delete(@PathVariable String id){
        Room room = db.remove(id);
        if(room == null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
    }

    @PostMapping("/rooms")
    public Room create(@RequestBody Room room){
        room.setId(UUID.randomUUID().toString());
        db.put(room.getId(), room);
        return room;
    }

    @PutMapping("/rooms/{id}")
    public Room put(@RequestBody Room room, @PathVariable String id){
        room.setId(id);
        db.put(id, room);
        return room;
    }
}
