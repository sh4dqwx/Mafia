import 'Game.dart';
import 'Reward.dart';
import 'RoundMiniGame.dart';
import 'Voting.dart';

class Round {
  final int id;
  final Game game;
  final Reward reward;
  final Voting votingCity;
  final Voting votingMafia;
  final Voting votingReward;
  final List<RoundMiniGame> roundMiniGames;

  Round({
    required this.id,
    required this.game,
    required this.reward,
    required this.votingCity,
    required this.votingMafia,
    required this.votingReward,
    required this.roundMiniGames,
  });

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      id: json['id'],
      game: Game.fromJson(json['game'] ?? {}),
      reward: Reward.fromJson(json['reward'] ?? {}),
      votingCity: Voting.fromJson(json['votingCity'] ?? {}),
      votingMafia: Voting.fromJson(json['votingMafia'] ?? {}),
      votingReward: Voting.fromJson(json['votingReward'] ?? {}),
      roundMiniGames: List<RoundMiniGame>.from((json['roundMiniGames'] ?? []).map((miniGameJson) => RoundMiniGame.fromJson(miniGameJson))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game': game.toJson(),
      'reward': reward.toJson(),
      'votingCity': votingCity.toJson(),
      'votingMafia': votingMafia.toJson(),
      'votingReward': votingReward.toJson(),
      'roundMiniGames': List<dynamic>.from(roundMiniGames.map((miniGame) => miniGame.toJson())),
    };
  }
}

