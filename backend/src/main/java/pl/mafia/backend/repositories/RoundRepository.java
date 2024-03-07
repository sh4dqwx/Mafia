package pl.mafia.backend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.mafia.backend.models.db.Round;

public interface RoundRepository extends JpaRepository<Round, Long>{
}
