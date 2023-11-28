package pl.mafia.backend.controllers;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

class SendMessageRequest {
    private String message;
    public String getMessage() { return this.message; }
    public void setMessage(String message) { this.message = message; }
}

@Controller
public class WSTestController {
    @MessageMapping("/ws-test")
    public String sendMessage(SendMessageRequest request) {
        System.out.println("Received message");
        return "Message: (" + request.getMessage() + ") has been received";
    }
}
