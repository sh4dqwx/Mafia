package pl.mafia.backend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.mafia.backend.models.Account;
import pl.mafia.backend.models.Room;

import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Long> {

    List<Room> findByHost(Account host);
}
