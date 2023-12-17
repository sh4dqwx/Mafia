package pl.mafia.backend.controllers;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WSTestController {
    @MessageMapping("/message")
    @SendTo("/topic/message")
    public SendMessageResponse sendMessage(SendMessageRequest request) {
        System.out.println("Received message");
        return new SendMessageResponse("Message: (" + request.getMessage() + ") has been received");
    }

    @Data
    private static class SendMessageRequest {
        private String message;
    }

    @Data
    @AllArgsConstructor
    private static class SendMessageResponse {
        private String message;
    }
}
