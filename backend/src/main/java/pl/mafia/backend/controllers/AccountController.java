package pl.mafia.backend.controllers;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.repositories.AccountRepository;
import pl.mafia.backend.models.Account;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private AccountRepository accountRepository;

    @GetMapping()
    public List<Account> getAllAccounts(){
        return accountRepository.findAll();
    }

    @GetMapping("/{id}")
    public Account getAccountById(@PathVariable String id){
        long accountId = Long.parseLong(id);
        return accountRepository.findById(accountId);
    }

    @DeleteMapping("/{id}")
    public void deleteAccountById(@PathVariable String id) {
        long accountId = Long.parseLong(id);
        Account account = accountRepository.findById(accountId);
        if (account == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Account does not exists.");
        } else {
            accountRepository.delete(account);
        }
    }
    @PostMapping()
    public Account createAccount(@RequestBody String email, @RequestBody String login, @RequestBody String password) {
        Account existingLogin = accountRepository.findByLogin(login);
        Account existingEmail = accountRepository.findByEmail(email);

        if (existingLogin != null || existingEmail != null) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Account already exists.");
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Account account = new Account();
        account.setEmail(email);
        account.setLogin(login);
        account.setPassword(hashedPassword);
        account.setNickname(login);

        return accountRepository.save(account);
    }

    @PutMapping("/{id}")
    public Account updateAccountById(@RequestBody Account account, @PathVariable String id) {
        long accountId = Long.parseLong(id);
        Account existingAccount = accountRepository.findById(accountId);
        if (existingAccount == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Account does not exists.");
        } else {
            return accountRepository.save(account);
        }
    }

    @PostMapping("/login")
    public Account loginToAccount(@RequestBody String login, @RequestBody String password) {
        Account existingAccount = accountRepository.findByLogin(login);

        if (existingAccount == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Account does not exists.");
        }

        if (!BCrypt.checkpw(password, existingAccount.getPassword())) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Wrong password.");
        }

        return existingAccount;
    }
}
