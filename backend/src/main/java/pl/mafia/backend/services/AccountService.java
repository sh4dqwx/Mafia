package pl.mafia.backend.services;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.mafia.backend.models.Account;
import pl.mafia.backend.repositories.AccountRepository;
import pl.mafia.backend.utils.exceptions.CreateAccountException;
import pl.mafia.backend.utils.exceptions.DeleteAccountException;
import pl.mafia.backend.utils.exceptions.LoginToAccountException;
import pl.mafia.backend.utils.exceptions.UpdateAccountException;

import java.util.List;

@Service
public class AccountService {
    @Autowired
    private AccountRepository accountRepository;

    @Transactional(readOnly = true)
    public List<Account> getAllAccounts() { return accountRepository.findAll(); }

    @Transactional(readOnly = true)
    public Account getAccountById(String id) {
        long accountId = Long.parseLong(id);
        return accountRepository.findById(accountId);
    }

    @Transactional
    public void deleteAccountById(String id) throws DeleteAccountException {
        Account account = getAccountById(id);
        if (account == null) {
            throw new DeleteAccountException("Account does not exists.");
        } else {
            accountRepository.delete(account);
        }
    }

    @Transactional
    public Account createAccount(String email, String login, String password) throws CreateAccountException {
        Account existingLogin = accountRepository.findByLogin(login);
        Account existingEmail = accountRepository.findByEmail(email);

        if (existingLogin != null || existingEmail != null) {
            throw new CreateAccountException("Account already exists");
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
    public Account updateAccountById(Account account, String id) throws UpdateAccountException {
        long accountId = Long.parseLong(id);
        Account existingAccount = accountRepository.findById(accountId);

        if (existingAccount == null) {
            throw new UpdateAccountException("Account does not exists.");
        }

        return accountRepository.save(account);
    }

    @Transactional
    public Account loginToAccount(String login, String password) throws LoginToAccountException {
        Account existingAccount = accountRepository.findByLogin(login);

        if (existingAccount == null) {
            throw new LoginToAccountException(
                    LoginToAccountException.Type.ACCOUNT_NOT_FOUND,
                    "Account does not exists."
            );
        }

        if (!BCrypt.checkpw(password, existingAccount.getPassword())) {
            throw new LoginToAccountException(
                    LoginToAccountException.Type.WRONG_PASSWORD,
                    "Wrong password"
            );
        }

        return existingAccount;
    }
}
