package pl.mafia.backend.services;

import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import pl.mafia.backend.models.db.Account;
import pl.mafia.backend.models.db.Vote;
import pl.mafia.backend.models.db.Voting;
import pl.mafia.backend.repositories.AccountRepository;
import pl.mafia.backend.repositories.VoteRepository;
import pl.mafia.backend.repositories.VotingRepository;

import java.util.Optional;

@Component
public class VotingService {
    @Autowired
    private VotingRepository votingRepository;
    @Autowired
    private VoteRepository voteRepository;
    @Autowired
    private AccountRepository accountRepository;

    @Transactional
    public void saveVote(Long votingId, Long voterId, Long votedId) {
        Optional<Voting> fetchedVoting = votingRepository.findById(votingId);
        if (fetchedVoting.isEmpty())
            throw new IllegalArgumentException("Voting does not exists.");

        Optional<Account> fetchedVoter = accountRepository.findById(voterId);
        if (fetchedVoter.isEmpty())
            throw new IllegalArgumentException("Voter does not exist");

        Optional<Account> fetchedVoted = accountRepository.findById(votedId);
        if (fetchedVoted.isEmpty())
            throw new IllegalArgumentException("Voted does not exist");

        Voting voting = fetchedVoting.get();
        Account voter = fetchedVoter.get();
        Account voted = fetchedVoted.get();
        Vote vote = new Vote();
        vote.setVoting(voting);
        vote.setVoter(voter);
        vote.setVoted(voted);
        vote = voteRepository.save(vote);

        voting.getVotes().add(vote);
        votingRepository.save(voting);
    }
}
