package pl.mafia.backend.Account.Controller;

import org.springframework.web.bind.annotation.*;

//@RestController
//public class AccountController {
//
//    @GetMapping("/accounts")
//    public List<Account> get(){
//        return db.values();
//    }
//    @GetMapping("/accounts/{id}")
//    public Account get(@PathVariable String id){
//        Account account = db.get(id);
//        if(account==null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
//        return account;
//    }
//
//    @DeleteMapping("/accounts/{id}")
//    public void delete(@PathVariable String id){
//        Account account = db.remove(id);
//        if(account==null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
//    }
//    @PostMapping("/acounts/")
//    public Account create(@RequestBody Account account){
//        account.setId(UUID.randomUUID().toString());
//        db.put(account.getId(),account);
//        return account;
//    }
//
//    @PutMapping("/accounts/{id}")
//    public Account put(@RequestBody Account account,@PathVariable String id)
//    {
//        db.put(account.getId(id),account);
//        return account;
//    }
//}
