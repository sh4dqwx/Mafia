package pl.mafia.backend.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import pl.mafia.backend.Repository.AccountRepository;
import pl.mafia.backend.models.Account;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
public class AccountController {

    @Autowired
    private AccountRepository accountRepository;

    @GetMapping("/accounts")
    public List<Account> get(){
        return (List<Account>) accountRepository.findAll();
    }
    @GetMapping("/accounts/{id}")
    public Account get(@PathVariable String id){
        long accountId = Long.parseLong(id);
        return accountRepository.findById(accountId);
    }

    @DeleteMapping("/accounts/{id}")
    public void delete(@PathVariable String id) {
        long accountId = Long.parseLong(id);
        Account account = accountRepository.findById(accountId);
        if (account == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        } else {
            accountRepository.delete(account);
        }
    }
    @PostMapping("/acounts/")
    public Account create(@RequestBody Account account) {
//        String login = account.getLogin();
//        String email = account.getEmail();
//
//        Account existingLogin = accountRepository.findByLogin(login);
//        Account existingEmail = accountRepository.findByEmail(email);
//        if (existingLogin != null || existingEmail != null) {
//            throw new ResponseStatusException(HttpStatus.CONFLICT, "Account already exists.");
//        }
        return accountRepository.save(account);
    }

    @PutMapping("/accounts/{id}")
    public Account put(@RequestBody Account account, @PathVariable String id) {
        long accountId = Long.parseLong(id);
        Account existingAccount = accountRepository.findById(accountId);
        if (existingAccount == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        } else {
//            account.setId(accountId);
            return accountRepository.save(account);
        }
    }
}
