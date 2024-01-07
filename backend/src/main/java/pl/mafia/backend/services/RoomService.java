package pl.mafia.backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pl.mafia.backend.models.db.Account;
import pl.mafia.backend.models.db.Room;
import pl.mafia.backend.models.dto.RoomDTO;
import pl.mafia.backend.repositories.AccountRepository;
import pl.mafia.backend.models.db.RoomSettings;
import pl.mafia.backend.repositories.RoomRepository;

import java.util.List;
import java.util.Optional;

@Component
public class RoomService {
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private RoomRepository roomRepository;

    public List<Room> getPublicRooms() {
       List<Room> lista = roomRepository.findByIsPublicTrue();
       return lista;
    }

    @Transactional
    public RoomDTO joinRoomByAccessCode(String accessCode, String accountId) throws IllegalAccessException {
        Optional<Room> fetchedRoom = roomRepository.findByAccessCode(accessCode);
        if (fetchedRoom.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        Optional<Account> fetchedAccount = accountRepository.findById(Long.parseLong(accountId));
        if (fetchedAccount.isEmpty())
            throw new IllegalAccessException("Account does not exists.");

        Account updatedAccount = fetchedAccount.get();
        Room updatedRoom = fetchedRoom.get();

        updatedAccount.setRoom(updatedRoom);
        updatedRoom.getAccounts().add(updatedAccount);
        accountRepository.save(updatedAccount);
        updatedRoom = roomRepository.save(updatedRoom);

        return new RoomDTO(updatedRoom);
    }

    @Transactional
    public RoomDTO joinRoomById(String id, String accountId) throws IllegalAccessException {
        Optional<Room> fetchedRoom = roomRepository.findById(Long.parseLong(id));
        if (fetchedRoom.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        Optional<Account> fetchedAccount = accountRepository.findById(Long.parseLong(accountId));
        if (fetchedAccount.isEmpty())
            throw new IllegalAccessException("Account does not exists.");

        Account updatedAccount = fetchedAccount.get();
        Room updatedRoom = fetchedRoom.get();

        updatedAccount.setRoom(updatedRoom);
        updatedRoom.getAccounts().add(updatedAccount);
        accountRepository.save(updatedAccount);
        updatedRoom = roomRepository.save(updatedRoom);

        return new RoomDTO(updatedRoom);
    }

    @Transactional
    public Room createRoom(Room room) {
        Optional<Room> roomByHost = roomRepository.findByHost(room.getHost());

        if (roomByHost.isPresent())
            throw new IllegalArgumentException("Room already exists.");

        Room createRoom = roomRepository.save(room);

        int codeLength = 7;
        String base26String = Long.toString(createRoom.getId(), 26).toUpperCase();
        base26String = String.format("%" + codeLength + "s", base26String).replace(' ', '0');
        base26String = base26String.substring(Math.max(0, base26String.length() - codeLength));

        createRoom.setAccessCode(base26String);
        return roomRepository.save(createRoom);
    }

    @Transactional
    public void updateProperties(RoomSettings roomSettings, String roomId) {
        Optional<Room> room = roomRepository.findById(Long.parseLong(roomId));

        if (room.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        //Room.settings = roomSettings;
        //roomRepository.save(room.get());
    }
}
