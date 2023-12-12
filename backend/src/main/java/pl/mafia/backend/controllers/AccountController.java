package pl.mafia.backend.controllers;

import lombok.Data;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.repositories.AccountRepository;
import pl.mafia.backend.models.Account;
import org.springframework.web.bind.annotation.*;
import pl.mafia.backend.services.AccountService;

import java.util.List;

@RestController
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @GetMapping()
    public List<Account> getAllAccounts() {
        return accountService.getAllAccounts();
    }

    @GetMapping("/{id}")
    public Account getAccountById(@PathVariable String id) {
        try {
            return accountService.getAccountById(id);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public void deleteAccountById(@PathVariable String id) {
        try {
            accountService.deleteAccountById(id);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        }
    }

    @PostMapping()
    public Account createAccount(@RequestBody RegisterRequest registerRequest) {
        try {
            return accountService.createAccount(
                    registerRequest.getEmail(),
                    registerRequest.getLogin(),
                    registerRequest.getPassword()
            );
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, ex.getMessage());
        }
    }

    @PutMapping("/{id}")
    public Account updateAccountById(@RequestBody Account account, @PathVariable String id) {
        try {
            return accountService.updateAccountById(account, id);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        }
    }

    @PostMapping("/login")
    public Account loginToAccount(@RequestBody LoginRequest loginRequest) {
        try {
            return accountService.loginToAccount(
                    loginRequest.getLogin(),
                    loginRequest.getPassword()
            );
        } catch(IllegalArgumentException ex) {
            if(ex.getMessage().equals("Account does not exist."))
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
            if(ex.getMessage().equals("Wrong password."))
                throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Unexpected error occured");
        }
    }

    @Data
    static class LoginRequest {
        private String login;
        private String password;
    }

    @Data
    static class RegisterRequest {
        private String login;
        private String password;
        private String email;
    }
}
