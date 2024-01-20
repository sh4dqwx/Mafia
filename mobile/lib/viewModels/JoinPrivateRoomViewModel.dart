import 'package:flutter/material.dart';
import 'package:mobile/services/WebSocketManager.dart';
import '../services/network/RoomService.dart';
import '../models/Room.dart';

class JoinPrivateRoomViewModel extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final RoomService roomService = RoomService();
  final WebSocketManager webSocketManager = WebSocketManager();

  String inputCodeError = "";
  String messageError = "";

  Future<bool> joinRoom(String accessCode) async {
    _setLoading(true);
    inputCodeError = "";
    messageError = "";

    if (accessCode.isNotEmpty) {
      try {
        //tutaj ma być metoda z servisu, to co poniżej to placeholder żeby nie pluło błędami
       // bool roomIsFound = getRoom(accesCode);
        Room room = await roomService.joinRoomByAccessCode(accessCode);
        webSocketManager.connect(room.id);
        return true;
        // if (roomIsFound == true)
        // if (room != null) {
        //   notifyListeners();
        //   return true;
        // }
        //
        // else {
        //   messageError = "Room not found.";
        //   notifyListeners();
        //   return false;
        // }

      }
      catch (e) {
        messageError = "Wrong code";
        notifyListeners();
        return false;
      }
    }
    else {
      inputCodeError = "Code is empty.";
      notifyListeners();
      return false;
    }
  }
}

