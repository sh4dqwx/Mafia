package pl.mafia.backend.models.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NonNull;
import pl.mafia.backend.models.db.Account;

@Data
public class AccountDTO {
    @NonNull private Long id;
    @NonNull private String nickname;

    public AccountDTO(Account account) {
        this.id = account.getId();
        this.nickname = account.getNickname();
    }
}
