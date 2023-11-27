package pl.mafia.backend.Repositories;

import org.springframework.data.repository.CrudRepository;
import pl.mafia.backend.models.Account;
import pl.mafia.backend.models.Room;

import java.util.List;

public interface RoomRepository extends CrudRepository<Room, Long> {

    List<Room> findByHost(Account host);
}
