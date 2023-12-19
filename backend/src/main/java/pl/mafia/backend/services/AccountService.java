package pl.mafia.backend.services;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pl.mafia.backend.models.db.Account;
import pl.mafia.backend.repositories.AccountRepository;

import java.util.List;
import java.util.Optional;

@Component
public class AccountService {
    @Autowired
    private AccountRepository accountRepository;

    public List<Account> getAllAccounts() { return accountRepository.findAll(); }

    public Account getAccountById(String id) {
        Optional<Account> account = accountRepository.findById(Long.parseLong(id));

        if(account.isEmpty())
            throw new IllegalArgumentException("Account does not exist.");

        return account.get();
    }

    @Transactional
    public Account createAccount(String email, String login, String password) {
        Optional<Account> accountByLogin = accountRepository.findByLogin(login);
        Optional<Account> accountByEmail = accountRepository.findByEmail(email);

        if(accountByLogin.isPresent() || accountByEmail.isPresent()) {
            throw new IllegalArgumentException("Account already exists.");
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        Account account = new Account();
        account.setEmail(email);
        account.setLogin(login);
        account.setPassword(hashedPassword);
        account.setNickname(login);

        return accountRepository.save(account);
    }

    @Transactional
    public void deleteAccountById(String id) {
        Optional<Account> account = accountRepository.findById(Long.parseLong(id));

        if(account.isEmpty())
            throw new IllegalArgumentException("Account does not exist.");

        accountRepository.delete(account.get());
    }

    @Transactional
    public Account updateAccountById(Account newAccount, String id) {
        Optional<Account> account = accountRepository.findById(Long.parseLong(id));

        if(account.isEmpty())
            throw new IllegalArgumentException("Account does not exist.");

        return accountRepository.save(newAccount);
    }

    public Account loginToAccount(String login, String password) throws IllegalAccessException {
        Optional<Account> accountByLogin = accountRepository.findByLogin(login);

        if(accountByLogin.isEmpty())
            throw new IllegalArgumentException("Account does not exist.");

        if (!BCrypt.checkpw(password, accountByLogin.get().getPassword())) {
            throw new IllegalAccessException("Wrong password.");
        }

        return accountByLogin.get();
    }
}
