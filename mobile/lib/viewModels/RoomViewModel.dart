import 'package:flutter/material.dart';
import 'package:mobile/services/network/GameService.dart';

import '../models/Room.dart';
import '../models/RoomSettings.dart';
import '../services/WebSocketClient.dart';

class RoomViewModel extends ChangeNotifier{
  final WebSocketClient webSocketClient = WebSocketClient();
  Room? _room;
  bool _isHost = false;
  final GameService gameService = GameService();
  String messageError = "";

  Room? get room => _room;

  bool get isHost => _isHost;

  void setIsHost(bool value)
  {
    _isHost = value;
    notifyListeners();
  }

  void setRoom(Room value)
  {
    _room = value;
    setIsHost(value.hostUsername == webSocketClient.username);
    notifyListeners();
  }

  Future<void> startGame(void Function() onSuccess, void Function() onError) async {
    try {
      await gameService.startGame();
      onSuccess.call();
    }
    catch(e)
    {
      messageError = "Wrong starting procedure";
      notifyListeners();
      onError.call();
    }
  }

  void openGameSettings() {
    // Implement the logic for opening game settings
  }

  void connectWebSocket() {
    webSocketClient.roomUpdate.listen((room) { setRoom(room); });
    webSocketClient.gameStartUpdate.listen((gameStart) { print(gameStart.role); });
  }
}
