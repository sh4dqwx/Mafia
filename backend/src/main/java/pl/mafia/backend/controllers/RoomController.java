package pl.mafia.backend.controllers;

import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.server.ResponseStatusException;
//import pl.mafia.backend.models.db.RoomSettings;
import pl.mafia.backend.models.db.Room;  // Update import to Room
import org.springframework.web.bind.annotation.*;
import pl.mafia.backend.models.dto.RoomDTO;
import pl.mafia.backend.services.RoomService;

import java.util.List;

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
    public RoomDTO joinRoomByAccessCode(@PathVariable String accessCode, @RequestBody JoinRoomRequest joinRoomRequest) {
        try {
            String accountId = joinRoomRequest.getAccountId();
            RoomDTO roomDTO = roomService.joinRoomByAccessCode(accessCode, accountId);
            messagingTemplate.convertAndSend("/topic/room/" + roomDTO.getId(), roomDTO);
            return roomDTO;
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(IllegalAccessException ex) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @PostMapping("/{id}")
    public RoomDTO joinRoomById(@PathVariable String id, @RequestBody JoinRoomRequest joinRoomRequest) {
        try {
            String accountId = joinRoomRequest.getAccountId();
            RoomDTO roomDTO = roomService.joinRoomById(id, accountId);
            messagingTemplate.convertAndSend("/topic/room/" + id, roomDTO);
            return roomDTO;
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(IllegalAccessException ex) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
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

//    @PutMapping("/properties/{id}")
//    public void updateProperties(@RequestBody RoomSettings roomSettings, @PathVariable String id) {
//        try {
//            roomService.updateProperties(roomSettings, id);
//        } catch (IllegalArgumentException ex) {
//            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
//        } catch (Exception ex) {
//            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
//        }
//    }

    @Data
    static class JoinRoomRequest {
        private String accountId;
    }
}
