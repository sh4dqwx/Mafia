package pl.mafia.backend.controllers;

import lombok.Data;
import org.hibernate.mapping.Join;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.models.Account;
import pl.mafia.backend.models.RoomUpdateDTO;
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
    private SimpMessagingTemplate messagingTemplate;
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

    @PostMapping("/code/{accessCode}")
    public RoomUpdateDTO joinRoomByAccessCode(@PathVariable String accessCode, @RequestBody JoinRoomRequest joinRoomRequest) {
        try {
            String accountId = joinRoomRequest.getAccountId();
            Room room = roomService.joinRoomByAccessCode(accessCode, accountId);
            RoomUpdateDTO roomUpdateDTO = new RoomUpdateDTO(
                    room.getAccounts()
                            .stream()
                            .map(Account::getNickname)
                            .toList(),
                    room.getHost().getId(),
                    room.isPublic()
            );
            messagingTemplate.convertAndSend("/topic/room/" + room.getId(), roomUpdateDTO);
            return roomUpdateDTO;
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(IllegalAccessException ex) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @PostMapping("/{id}")
    public RoomUpdateDTO joinRoomById(@PathVariable String id, @RequestBody JoinRoomRequest joinRoomRequest) {
        try {
            String accountId = joinRoomRequest.getAccountId();
            Room room = roomService.joinRoomById(id, accountId);
            RoomUpdateDTO roomUpdateDTO = new RoomUpdateDTO(
                    room.getAccounts()
                            .stream()
                            .map(Account::getNickname)
                            .toList(),
                    room.getHost().getId(),
                    room.isPublic()
            );
            messagingTemplate.convertAndSend("/topic/room/" + id, roomUpdateDTO);
            return roomUpdateDTO;
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(IllegalAccessException ex) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
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

    @Data
    static class JoinRoomRequest {
        private String accountId;
    }
}
