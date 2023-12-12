package pl.mafia.backend.controllers;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.repositories.AccountRepository;
import pl.mafia.backend.models.Account;
import org.springframework.web.bind.annotation.*;
import pl.mafia.backend.services.AccountService;
import pl.mafia.backend.utils.exceptions.CreateAccountException;
import pl.mafia.backend.utils.exceptions.DeleteAccountException;
import pl.mafia.backend.utils.exceptions.LoginToAccountException;
import pl.mafia.backend.utils.exceptions.UpdateAccountException;

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
        return accountService.getAccountById(id);
    }

    @DeleteMapping("/{id}")
    public void deleteAccountById(@PathVariable String id) {
        try {
            accountService.deleteAccountById(id);
        } catch(DeleteAccountException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        }
    }

    @PostMapping()
    public Account createAccount(@RequestBody String email, @RequestBody String login, @RequestBody String password) {
        try {
            return accountService.createAccount(email, login, password);
        } catch(CreateAccountException ex) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, ex.getMessage());
        }
    }

    @PutMapping("/{id}")
    public Account updateAccountById(@RequestBody Account account, @PathVariable String id) {
        try {
            return accountService.updateAccountById(account, id);
        } catch(UpdateAccountException ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
        }
    }

    @PostMapping("/login")
    public Account loginToAccount(@RequestBody String login, @RequestBody String password) {
        try {
            return accountService.loginToAccount(login, password);
        } catch(LoginToAccountException ex) {
            switch(ex.getType()) {
                case ACCOUNT_NOT_FOUND -> throw new ResponseStatusException(HttpStatus.NOT_FOUND, ex.getMessage());
                case WRONG_PASSWORD -> throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, ex.getMessage());
                default -> throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Unexpected error occured");
            }
        }
    }
}
