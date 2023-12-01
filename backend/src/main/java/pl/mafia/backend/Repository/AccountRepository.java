package pl.mafia.backend.Repository;

import org.springframework.data.repository.CrudRepository;
import pl.mafia.backend.models.Account;

import java.util.List;

public interface AccountRepository extends CrudRepository<Account, Long> {

    Account findById(long id);
    Account findByLogin(String login);
    Account findByEmail(String email);
}