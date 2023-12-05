package pl.mafia.backend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.mafia.backend.models.Account;

public interface AccountRepository extends JpaRepository<Account, Long> {

    Account findById(long id);
    Account findByLogin(String login);
    Account findByEmail(String email);
}