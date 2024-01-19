package pl.mafia.backend.controllers;

import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.models.db.Account;
import org.springframework.web.bind.annotation.*;
import pl.mafia.backend.models.dto.AccountDetails;
import pl.mafia.backend.services.AccountService;

import java.util.List;

@RestController
@RequestMapping("/account")
public class AccountController {
    @Autowired
    private AccountService accountService;

    @GetMapping()
    public ResponseEntity<?> getAllAccounts() {
        try {
            return ResponseEntity.ok(accountService.getAllAccounts());
        } catch(Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getAccountById(@PathVariable String id) {
        try {
            return ResponseEntity.ok(accountService.getAccountById(id));
        } catch(IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        } catch(Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }


    @PostMapping("/register")
    public ResponseEntity<?> createAccount(@RequestBody AccountDetails registerRequest) {
        try {
            accountService.createAccount(registerRequest);
            return ResponseEntity.noContent().build();
        } catch(IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(ex.getMessage());
        } catch(Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> loginToAccount(@RequestBody AccountDetails loginRequest) {
        try {
            accountService.loginToAccount(loginRequest);
            return ResponseEntity.noContent().build();
        } catch(IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ex.getMessage());
        } catch(BadCredentialsException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(ex.getMessage());
        } catch(Exception ex) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }
}
