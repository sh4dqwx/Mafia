package pl.mafia.backend;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpAttributesContextHolder;
import org.springframework.messaging.simp.user.SimpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.util.ArrayList;
import java.util.List;

@Component
public class WebSocketListener {
    private List<String> activeConnections;

    public WebSocketListener() {
        activeConnections = new ArrayList<>();
    }

    @EventListener
    public void handleConnectEvent(SessionConnectEvent event) {
        System.out.println("New connection: " + event.getMessage().getHeaders().get("simpSessionId"));
    }

    @EventListener
    public void handleDisconnectEvent(SessionDisconnectEvent event) {
        System.out.println("Disconnected: " + event.getMessage().getHeaders().get("simpSessionId"));
    }
}
