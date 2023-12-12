package pl.mafia.backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.models.Room;
import pl.mafia.backend.repositories.RoomRepository;

import java.util.List;
import java.util.Optional;

@Component
public class RoomService {
    @Autowired
    private RoomRepository roomRepository;

    public List<Room> getPublicRooms() {
        return roomRepository.findByIsPublicTrue();
    }

    public Room getRoomByAccessCode(String accessCode) {
        Optional<Room> room = roomRepository.findByAccessCode(accessCode);

        if (room.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        return room.get();
    }

    public Room getRoomById(String id){
        Optional<Room> room = roomRepository.findById(Long.parseLong(id));

        if (room.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        return room.get();
    }

    @Transactional
    public void deleteRoomById(@PathVariable String id) {
        Optional<Room> room = roomRepository.findById(Long.parseLong(id));

        if (room.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        roomRepository.delete(room.get());
    }

    @Transactional
    public Room createRoom(@RequestBody Room room) {
        Optional<Room> roomByHost = roomRepository.findByHost(room.getHost());

        if (roomByHost.isPresent())
            throw new IllegalArgumentException("Room already exists.");

        return roomRepository.save(room);
    }
}
