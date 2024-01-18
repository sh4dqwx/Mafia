package pl.mafia.backend.services;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pl.mafia.backend.models.db.Account;
import pl.mafia.backend.models.dto.AccountDetails;
import pl.mafia.backend.repositories.AccountRepository;

import java.util.List;
import java.util.Optional;

@Component
public class AccountService {
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private UserDetailsManager userDetailsManager;

    @Transactional(readOnly = true)
    public List<AccountDetails> getAllAccounts() {
        return accountRepository.findAll()
                .stream()
                .map(AccountDetails::new)
                .toList();
    }

    @Transactional(readOnly = true)
    public AccountDetails getAccountById(String id) {
        Optional<Account> account = accountRepository.findById(Long.parseLong(id));

        if(account.isEmpty())
            throw new IllegalArgumentException("Account does not exist.");

        return new AccountDetails(account.get());
    }

    public void loginToAccount(AccountDetails loginRequest) {
        Authentication authenticationRequest =
                UsernamePasswordAuthenticationToken.unauthenticated(loginRequest.getUsername(), loginRequest.getPassword());
        authenticationManager.authenticate(authenticationRequest);
    }

    public void createAccount(AccountDetails registerRequest) {
        userDetailsManager.createUser(registerRequest);
    }
}
