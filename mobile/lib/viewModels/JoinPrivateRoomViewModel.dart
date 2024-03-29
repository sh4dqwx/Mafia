import 'package:flutter/material.dart';
import 'package:mobile/services/WebSocketClient.dart';
import 'package:mobile/services/network/RoomService.dart';
import 'package:mobile/models/Room.dart';

class JoinPrivateRoomViewModel extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final RoomService _roomService = RoomService();
  final WebSocketClient _webSocketClient = WebSocketClient();

  String inputCodeError = "";
  String messageError = "";

  Future<void> joinRoom(String accessCode, void Function(Room room) onSuccess, void Function() onError) async {
    _setLoading(true);
    inputCodeError = "";
    messageError = "";

    if (accessCode.isNotEmpty) {
      try {
        Room room = await _roomService.joinRoomByAccessCode(accessCode);
        await _webSocketClient.connect(room.id);
        onSuccess.call(room);
      }
      catch (e) {
        messageError = "Wrong code";
        notifyListeners();
        onError.call();
      }
    }
    else {
      inputCodeError = "Code is empty.";
      notifyListeners();
      onError.call();
    }
  }
}

