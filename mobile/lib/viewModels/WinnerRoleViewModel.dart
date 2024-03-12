import 'package:flutter/material.dart';
import 'package:mobile/services/network/GameService.dart';

import 'package:mobile/models/Room.dart';
import 'package:mobile/services/WebSocketClient.dart';

class WinnerRoleViewModel extends ChangeNotifier{
  String _userRole = '';
  WebSocketClient webSocketClient = WebSocketClient();

  WinnerRoleViewModel() {
    if(webSocketClient.lastGameStartUpdate == null) return;
    _userRole = webSocketClient.lastGameStartUpdate!.role;
    notifyListeners();
  }

  String get userRole => _userRole;
}
