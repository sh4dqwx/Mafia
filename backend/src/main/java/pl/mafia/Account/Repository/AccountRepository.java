package pl.mafia.Account.Repository;

import org.springframework.data.repository.CrudRepository;

public class AccountRepository extends CrudRepository<Account, Long>{

    Account findByEmail(String email);
}