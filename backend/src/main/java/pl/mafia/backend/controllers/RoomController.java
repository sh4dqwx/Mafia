package pl.mafia.backend.controllers;

import jdk.javadoc.doclet.Reporter;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.models.db.RoomSettings;
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
    public ResponseEntity<?> getPublicRooms() {
        try {
            return new ResponseEntity<>(roomService.getPublicRooms(), HttpStatus.OK);
        } catch(Exception ex) {
            return new ResponseEntity<>(ex.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/code/{accessCode}")
    public ResponseEntity<?> joinRoomByAccessCode(@PathVariable String accessCode, @RequestBody JoinRoomRequest joinRoomRequest) {
        try {
            String accountId = joinRoomRequest.getAccountId();
            RoomDTO roomDTO = roomService.joinRoomByAccessCode(accessCode, accountId);
            messagingTemplate.convertAndSend("/topic/room/" + roomDTO.getId(), roomDTO);
            return ResponseEntity.ok(roomDTO);
        } catch(IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        } catch(IllegalAccessException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ex.getMessage());
        } catch(Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @PostMapping("/{id}")
    public ResponseEntity<?> joinRoomById(@PathVariable String id, @RequestBody JoinRoomRequest joinRoomRequest) {
        try {
            String accountId = joinRoomRequest.getAccountId();
            RoomDTO roomDTO = roomService.joinRoomById(id, accountId);
            messagingTemplate.convertAndSend("/topic/room/" + id, roomDTO);
            return ResponseEntity.ok(roomDTO);
        } catch(IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        } catch(IllegalAccessException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ex.getMessage());
        } catch(Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @PostMapping()
    public ResponseEntity<?> createRoom(@RequestBody Room room) {
        try {
            return ResponseEntity.ok(roomService.createRoom(room));
        } catch(IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(ex.getMessage());
        } catch(Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @PutMapping("/properties/{id}")
    public ResponseEntity<?> updateProperties(@RequestBody RoomSettings roomSettings, @PathVariable String id) {
        try {
            roomService.updateProperties(roomSettings, id);
            return ResponseEntity.noContent().build();
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        } catch (Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @Data
    static class JoinRoomRequest {
        private String accountId;
    }
}
