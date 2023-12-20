package pl.mafia.backend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.mafia.backend.models.db.Account;

import java.util.Optional;

public interface AccountRepository extends JpaRepository<Account, Long> {

    Optional<Account> findById(long id);
    Optional<Account> findByLogin(String login);
    Optional<Account> findByEmail(String email);
}