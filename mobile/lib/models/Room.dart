import 'Account.dart';
import 'Game.dart';

class Room {
  final int id;
  int idHost;
  final Game game;
  final String accessCode;
  final bool isPublic;
  final List<Account> accounts;

  Room({
    required this.id,
    required this.idHost,
    required this.game,
    required this.accessCode,
    required this.isPublic,
    required this.accounts,
  });


  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      idHost: json['idHost'],
      game: Game.fromJson(json['game']),
      accessCode: json['accessCode'],
      isPublic: json['isPublic'],
      accounts: (json['accounts'] as List).map((account) => Account.fromJson(account)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idHost': idHost,
      'game': game.toJson(),
      'accessCode': accessCode,
      'isPublic': isPublic,
      'accounts': accounts.map((account) => account.toJson()).toList(),
    };
  }
}
