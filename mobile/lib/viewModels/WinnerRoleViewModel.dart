import 'package:flutter/material.dart';
import 'package:mobile/services/network/GameService.dart';

import '../models/Room.dart';
import '../services/WebSocketClient.dart';

class WinnerRoleViewModel extends ChangeNotifier{
  final WebSocketClient webSocketClient = WebSocketClient();
  String role = "City";


  void connectWebSocket() {
    webSocketClient.roomUpdate.listen((room) {

    });
  }
}