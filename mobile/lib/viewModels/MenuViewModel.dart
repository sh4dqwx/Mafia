import 'package:flutter/material.dart';
import 'package:mobile/services/WebSocketManager.dart';
import '../services/network/RoomService.dart';
import '../models/Room.dart';

class MenuViewModel extends ChangeNotifier {
  final RoomService _roomService = RoomService();
  final WebSocketManager _webSocketManager = WebSocketManager();
  String _nickname = "Testowy123";

  String get nickname => _nickname;

  String messageError = "";

  void joinRoom(BuildContext context) {
    notifyListeners();
  }

  void showPublicRoomsList(BuildContext context) {
    notifyListeners();
  }

  Future<void> createRoom(void Function() onSuccess, void Function() onError) async {
    try {
      _webSocketManager.connect(123);
      // Tutaj możesz wykonać odpowiednie akcje przed wysłaniem żądania, np. pokazać ładowanie
      //Room room = Room(id: 0, idHost: 41, idGame: 0, accessCode: "ABC123", isPublic: false);
      //await _roomService.createRoom(room);

      // Tutaj możesz wykonać odpowiednie akcje po udanym zapytaniu, np. ukryć ładowanie
      // lub zaktualizować stan ViewModel, jeśli to konieczne
      onSuccess.call(); // Wywołaj funkcję onSuccess, jeśli została dostarczona
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

  void logout() {

    notifyListeners();
  }
}
