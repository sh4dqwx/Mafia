package pl.mafia.Account.Controller;

import jdk.jshell.spi.ExecutionControl;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@RestController
public class AccountController {

    @GetMapping("/accounts")
    public List<Account> get(){
        return db.values();
        }
    @GetMapping("/accounts/{id}")
    public Account get(@PathVariable String id){
        Account account = db.get(id);
        if(account==null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return account;
    }

    @DeleteMapping("/accounts/{id}")
    public void delete(@PathVariable String id){
        Account account = db.remove(id);
        if(account==null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
    }
    @PostMapping("/acounts/")
    public Account create(@RequestBody Account account){
        account.setId(UUID.randomUUID().toString());
        db.put(account.getId(),account);
        return account;
    }

    @PutMapping("/accounts/{id}")
    public Account put(@RequestBody Account account,@PathVariable String id)
    {
        db.put(account.getId(id),account);
        return account;
    }
}
