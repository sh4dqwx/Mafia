import 'package:flutter/material.dart';
import 'package:mobile/services/network/GameService.dart';

import 'package:mobile/models/Room.dart';
import 'package:mobile/services/WebSocketClient.dart';

class WinnerRoleViewModel extends ChangeNotifier{
  String _userRole = '';
  WebSocketClient webSocketClient = WebSocketClient();

  WinnerRoleViewModel() {
    webSocketClient.gameStartUpdate.listen((gameStart) {
      _userRole = gameStart.role;
      notifyListeners(); // Notify listeners when the role is updated
    });
  }

  String get userRole => _userRole;
}
