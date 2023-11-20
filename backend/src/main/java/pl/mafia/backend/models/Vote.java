package pl.mafia.backend.models;

public class Vote {
    int id;
    private Voting voting;
    private Account account; //idVoter
    private int idVoted;
}
