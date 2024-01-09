import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Game {
  final DateTime date;
  final bool won; // true - wygrana, false - przegrana

  Game({required this.date, required this.won});
}

class GameHistoryViewModel extends ChangeNotifier {
 // final GameService _gameService = GameService();
  List<Game> _gameHistory = [];

  List<Game> get gameHistory => _gameHistory;

  Future<void> fetchGameHistory() async {
    try{
      //zakomentowane bo serwsue ni ma
       // List <Game> games = await _gameHistory.getGames();
       // jakiea prkladowe nizej
      _gameHistory = [
        Game(date: DateTime(2024, 1, 1), won: true),
        Game(date: DateTime(2024, 1, 5), won: false),
      ];
        notifyListeners();
      } catch (e) {
        print('Error: $e');
      }
  }
}