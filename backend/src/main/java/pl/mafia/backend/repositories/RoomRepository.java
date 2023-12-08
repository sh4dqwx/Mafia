package pl.mafia.backend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.mafia.backend.models.Account;
import pl.mafia.backend.models.Room;

import java.util.List;
import java.util.Optional;

public interface RoomRepository extends JpaRepository<Room, Long> {

    Optional<Room> findByHost(Account host);
    Optional<Room> findByAccessCode(String accessCode);
    List<Room> findByAccessCodeNull();
}
