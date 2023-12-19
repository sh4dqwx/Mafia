package pl.mafia.backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pl.mafia.backend.models.db.Account;
import pl.mafia.backend.models.db.Room;
import pl.mafia.backend.models.dto.AccountDTO;
import pl.mafia.backend.models.dto.RoomDTO;
import pl.mafia.backend.repositories.AccountRepository;
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
        return roomRepository.findByIsPublicTrue();
    }

    public RoomDTO joinRoomByAccessCode(String accessCode, String accountId) throws IllegalAccessException {
        Optional<Room> fetchedRoom = roomRepository.findByAccessCode(accessCode);
        if (fetchedRoom.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        Optional<Account> fetchedAccount = accountRepository.findById(Long.parseLong(accountId));
        if (fetchedAccount.isEmpty())
            throw new IllegalAccessException("Account does not exists.");

        Account updatedAccount = fetchedAccount.get();
        Room room = fetchedRoom.get();

        updatedAccount.setRoom(room);
        accountRepository.save(updatedAccount);

        return new RoomDTO(
                room.getId(),
                room.getAccounts()
                        .stream()
                        .map(account -> new AccountDTO(account.getId(), account.getNickname()))
                        .toList(),
                room.getHost().getId(),
                room.isPublic()
        );
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
        Room room = fetchedRoom.get();

        updatedAccount.setRoom(room);
        accountRepository.save(updatedAccount);

        return new RoomDTO(
                room.getId(),
                room.getAccounts()
                        .stream()
                        .map(account -> new AccountDTO(account.getId(), account.getNickname()))
                        .toList(),
                room.getHost().getId(),
                room.isPublic()
        );
    }

    @Transactional
    public void deleteRoomById(String id) {
        Optional<Room> room = roomRepository.findById(Long.parseLong(id));

        if (room.isEmpty())
            throw new IllegalArgumentException("Room does not exists.");

        roomRepository.delete(room.get());
    }

    @Transactional
    public Room createRoom(Room room) {
        Optional<Room> roomByHost = roomRepository.findByHost(room.getHost());

        if (roomByHost.isPresent())
            throw new IllegalArgumentException("Room already exists.");

        return roomRepository.save(room);
    }
}
