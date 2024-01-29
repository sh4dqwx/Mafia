import 'package:flutter/material.dart';
class VotingViewModel extends ChangeNotifier {
  late List<Player> _players;
  late Map<int, String> _roles;
  late Map<int, int> _votesCount;

  VotingViewModel() {
    //pobieranie graczy, tymczasowo utworzono kilku
    _players = [
      Player(id: 1, nickname: 'Gracz 1', canVote: true),
      Player(id: 2, nickname: 'Gracz 2', canVote: true),
      Player(id: 3, nickname: 'Gracz 3', canVote: true),
    ];

    _roles = {
      1: 'miasto',
      2: 'mafia',
      3: 'miasto',
    };

    _votesCount = Map<int, int>.fromIterable(_players, key: (player) => player.id, value: (player) => 0);
  }

  List<Player> getPlayers() {
    return _players;
  }

  Map<int, String> getRoles() {
    return _roles;
  }

  Map<int, int> getVotesCount() {
    return _votesCount;
  }

  void vote(int playerId) {
    Player? player = _players.firstWhere((p) => p.id == playerId, orElse: () => Player(id: -1, nickname: '', canVote: false));

    if (player?.canVote ?? false) {
      print('Głos oddany na gracza o ID: $playerId');
      _votesCount[playerId] = (_votesCount[playerId] ?? 0) + 1;
      notifyListeners();
    } else {
      print('Nie można głosować na ${player?.nickname} (${player?.id})');
    }
  }

  int getVotesForPlayer(int playerId) {
    return _votesCount[playerId] ?? 0;
  }

  //tutaj metoda do wyniku glosowania
  Player? getPlayerWithMostVotes() {
    int maxVotes = 0;
    Player? playerWithMostVotes;

    for (Player player in _players) {
      int votes = _votesCount[player.id] ?? 0;
      if (votes > maxVotes) {
        maxVotes = votes;
        playerWithMostVotes = player;
      }
    }

    return playerWithMostVotes;
  }
}

class Player {
  final int id;
  final String nickname;
  final bool canVote;

  Player({required this.id, required this.nickname, required this.canVote});
}