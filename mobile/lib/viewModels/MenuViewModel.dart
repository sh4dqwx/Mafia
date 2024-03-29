import 'package:flutter/material.dart';
import 'package:mobile/services/WebSocketClient.dart';
import 'package:mobile/services/network/AccountService.dart';
import 'package:mobile/services/network/RoomService.dart';
import 'package:mobile/models/Room.dart';

class MenuViewModel extends ChangeNotifier {
  final AccountService _accountService = AccountService();
  final RoomService _roomService = RoomService();
  final WebSocketClient _webSocketClient = WebSocketClient();
  String _nickname = "Testowy123";

  String get nickname => _nickname;

  String messageError = "";

  void joinRoom(BuildContext context) {
    notifyListeners();
  }

  void showPublicRoomsList(BuildContext context) {
    notifyListeners();
  }

  Future<void> createRoom(void Function(Room room) onSuccess, void Function() onError) async {
    try {
      Room room = await _roomService.createRoom();
      await _webSocketClient.connect(room.id);
      // Tutaj możesz wykonać odpowiednie akcje po udanym zapytaniu, np. ukryć ładowanie
      // lub zaktualizować stan ViewModel, jeśli to konieczne
      onSuccess.call(room); // Wywołaj funkcję onSuccess, jeśli została dostarczona
    } catch (e) {
      // Tutaj możesz obsłużyć błędy, np. pokazać komunikat o błędzie użytkownikowi
      print("Error creating room: $e");
      onError.call(); // Wywołaj funkcję onError, jeśli została dostarczona
    }
  }



  void gameHistory(BuildContext context) {

    notifyListeners();
  }

  void settings(BuildContext context) {

    notifyListeners();
  }

  Future<void> logout(void Function() onSuccess, void Function(Exception e) onError) async {
    try {
      _accountService.logout();
      onSuccess.call();
    } on Exception catch (e) {
      onError.call(e);
    }
    notifyListeners();
  }
}
