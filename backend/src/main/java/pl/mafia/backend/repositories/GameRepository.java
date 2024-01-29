package pl.mafia.backend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.mafia.backend.models.db.Game;

public interface GameRepository extends JpaRepository<Game, Long> {
}
