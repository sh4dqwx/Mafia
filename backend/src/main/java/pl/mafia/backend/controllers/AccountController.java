package pl.mafia.backend.controllers;

import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.models.db.Account;
import org.springframework.web.bind.annotation.*;
import pl.mafia.backend.models.dto.AccountDTO;
import pl.mafia.backend.services.AccountService;

import java.util.List;
import java.util.Locale;

@RestController
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @GetMapping()
    public List<Account> getAllAccounts() {
        try {
            return accountService.getAllAccounts();
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @GetMapping("/{id}")
    public Account getAccountById(@PathVariable String id) {
        try {
            return accountService.getAccountById(id);
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }


    @PostMapping()
    public AccountDTO createAccount(@RequestBody RegisterRequest registerRequest) {
        try {
            return accountService.createAccount(
                    registerRequest.getEmail(),
                    registerRequest.getLogin(),
                    registerRequest.getPassword()
            );
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @PostMapping("/login")
    public AccountDTO loginToAccount(@RequestBody LoginRequest loginRequest) {
        try {
            return accountService.loginToAccount(
                    loginRequest.getLogin(),
                    loginRequest.getPassword()
            );
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(IllegalAccessException ex) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @PutMapping("/nickname")
    public AccountDTO changeNickname(@PathVariable Long accountId, @RequestBody String newNickname) {
        try {
            return accountService.changeNickname(
                    accountId,
                    newNickname
            );
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
        }
    }

    @PutMapping("/password")
    public AccountDTO changePassword(@PathVariable Long accountId, @RequestBody PasswordRequest passwordRequest) {
        try {
            return accountService.changePassword(
                    accountId,
                    passwordRequest.previousPassword,
                    passwordRequest.newPassword
            );
        } catch(IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        } catch(IllegalAccessException ex) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
        } catch(Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.getMessage());
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

    @Data
    static class PasswordRequest {
        private String previousPassword;
        private String newPassword;
    }
}
