import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/network/RoomService.dart';

class RoomSettingsViewModelroomSettings with ChangeNotifier {
  final RoomService _roomService = RoomService();

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> saveRoomSettingsroomSettings(dynamic data,
      BuildContext context) async {
    setLoading(true);
  }

}