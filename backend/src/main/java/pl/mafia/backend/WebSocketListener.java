package pl.mafia.backend;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpAttributesContextHolder;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.user.SimpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionSubscribeEvent;
import org.springframework.web.socket.messaging.SessionUnsubscribeEvent;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class WebSocketListener {
    private final Map<String, List<String>> activeSubscriptions;

    public WebSocketListener() {
        activeSubscriptions = new HashMap<>();
    }

    @EventListener
    public void handleConnectEvent(SessionConnectEvent event) {
        System.out.println("New connection: " + SimpAttributesContextHolder.currentAttributes().getSessionId());
    }

    @EventListener
    public void handleDisconnectEvent(SessionDisconnectEvent event) {
        System.out.println("Disconnected: " + SimpAttributesContextHolder.currentAttributes().getSessionId());
    }

    @EventListener
    public void handleSubscribeEvent(SessionSubscribeEvent event) {
        if(event.getUser() == null) return;

        String destination = (String)event.getMessage().getHeaders().get("simpDestination");
        if(!activeSubscriptions.containsKey(destination)) activeSubscriptions.put(destination, new ArrayList<>());
        activeSubscriptions.get(destination).add(event.getUser().getName());

        System.out.println("Subscribed: " + event.getMessage().getHeaders().get("simpDestination"));
    }

    @EventListener
    public void handleUnsubscribeEvent(SessionUnsubscribeEvent event) {
        if(event.getUser() == null) return;

        String destination = (String)event.getMessage().getHeaders().get("simpDestination");
        activeSubscriptions.get(destination).remove(event.getUser().getName());

        System.out.println("Unsubscribed: " + event.getMessage().getHeaders().get("simpDestination"));
    }

    public List<String> getSubscriptions(String destination) { return activeSubscriptions.get(destination); }
}
