package pl.mafia.backend.utils.exceptions;

public class LoginToAccountException extends Exception {
    private Type type;

    public LoginToAccountException(Type type, String message) {
        super(message);
        this.type = type;
    }

    public Type getType() {
        return type;
    }

    public enum Type {
        ACCOUNT_NOT_FOUND,
        WRONG_PASSWORD
    }
}
