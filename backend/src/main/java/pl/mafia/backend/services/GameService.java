package pl.mafia.backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pl.mafia.backend.websockets.WebSocketListener;
import pl.mafia.backend.models.dto.GameStartDTO;

import java.util.Random;

@Component
public class GameService {
    @Autowired
    private WebSocketListener webSocketListener;
    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    private String getRandomRole() {
        String[] roles = new String[]{"citizen", "mafia"};
        return roles[new Random().nextInt(roles.length)];
    }

    @Transactional
    public void startGame(Long roomId) {
        String destination = "/topic/" + roomId + "/game";
        for(String user : webSocketListener.getSubscriptions(destination)) {
            GameStartDTO gameStartDTO = new GameStartDTO(getRandomRole());
            simpMessagingTemplate.convertAndSendToUser(user, destination, gameStartDTO);
        }
    }
}
