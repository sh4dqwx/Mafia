import 'package:flutter/material.dart';


class VotingViewModel extends ChangeNotifier {
  late List<Player> _players;
  late Map<String, String> _roles; // Change key type to String
  late Map<String, int> _votesCount; // Change key type to
  late List<Map<String, dynamic>> _votesList = [];

  List<Map<String, dynamic>> get votesList => _votesList;

  VotingViewModel() {
    //pobieranie graczy, tymczasowo utworzono kilku
    _players = [
      Player(nickname: 'Gracz 1', canVote: true),
      Player(nickname: 'Gracz 2', canVote: true),
      Player(nickname: 'Gracz 3', canVote: true),
    ];

    _roles = {
      'Gracz 1': 'miasto',
      'Gracz 2': 'mafia',
      'Gracz 3': 'miasto',
    };

    _votesCount = Map<String, int>.fromIterable(_players, key: (player) => player.nickname, value: (player) => 0);
  }

  List<Player> getPlayers() {
    return _players;
  }

  Map<String, String> getRoles() {
    return _roles;
  }

  Map<String, int> getVotesCount() {
    return _votesCount;
  }

  void vote(String playerNickname) {
    Player? player = _players.firstWhere((p) => p.nickname == playerNickname, orElse: () => Player(nickname: '', canVote: false));

    if (player?.canVote ?? false) {
      print('Głos oddany na gracza: $playerNickname');
      _votesCount[playerNickname] = (_votesCount[playerNickname] ?? 0) + 1;
      notifyListeners();
    } else {
      print('Nie można głosować na $playerNickname');
    }
  }

    void getVotesList() {
      try {
        List<Map<String, dynamic>> votesListData = [
          {'nickname': 'Gracz 1', 'votes': 5},
          {'nickname': 'Gracz 2', 'votes': 3},
          {'nickname': 'Gracz 3', 'votes': 7},
        ];
        _votesList = votesListData;
        notifyListeners();
      } catch (e) {
        print('Error fetching votes list: $e');
      }
    }

  int getVotesForPlayer(String playerNickname) {
    return _votesCount[playerNickname] ?? 0;
  }

  //tutaj metoda do wyniku glosowania
  Player? getPlayerWithMostVotes() {
    int maxVotes = 0;
    Player? playerWithMostVotes;

    for (Player player in _players) {
      int votes = _votesCount[player.nickname] ?? 0; // Change key to player.nickname
      if (votes > maxVotes) {
        maxVotes = votes;
        playerWithMostVotes = player;
      }
    }

    return playerWithMostVotes;
  }
}

class Player {
  final String nickname;
  final bool canVote;

  Player({required this.nickname, required this.canVote});
}