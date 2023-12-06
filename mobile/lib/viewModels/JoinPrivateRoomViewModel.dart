import 'package:flutter/material.dart';
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

  String inputCodeError = "";
  String messageError = "";

  Future<bool> joinRoom(String accessCode) async {
    _setLoading(true);
    inputCodeError = "";
    messageError = "";

    if (accessCode.isNotEmpty) {
      try {
        Room room = await roomService.getRoom(int.parse(accessCode));

        if (room != null) {
          notifyListeners();
          return true;
          }

        else {
          messageError = "Room not found.";
          notifyListeners();
          return false;
        }

      }
      catch (e) {
        messageError = "Wrong code";
        notifyListeners();
        return false;
      }
    }
    else {
      inputCodeError = "Code is empty.";
      return false;
    }
  }
}

