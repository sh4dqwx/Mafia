import 'package:flutter/material.dart';
import '../models/Room.dart';
import '../services/WebSocketClient.dart';
import '../models/VotingSummary.dart';

class VotingViewModel extends ChangeNotifier {
  final WebSocketClient webSocketClient = WebSocketClient();
  VotingSummary? _votingSummary;
  VotingSummary? get votingSummary => _votingSummary;
  late Room _room;
  late List<Player> _players;
  late Map<String, String> _roles; // Change key type to String
  late Map<String, int> _votesCount; // Change key type to String

  VotingViewModel() {

    _votesCount = Map<String, int>.fromIterable(_players, key: (player) => player.nickname, value: (player) => 0);
  }

  List<Player> getPlayers() {
    List<Player> players = _room.accountUsernames
        .map((username) => Player(nickname: username, canVote: true))
        .toList();
    return players;
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
  void setVotingResults(VotingSummary value)
  {
    _votingSummary = value;
    notifyListeners();
  }
  void connectWebSocket() {
    webSocketClient.votingSummaryUpdate.listen((votingSummary) { setVotingResults(votingSummary); });
  }

}

class Player {
  final String nickname;
  final bool canVote;

  Player({required this.nickname, required this.canVote});
}