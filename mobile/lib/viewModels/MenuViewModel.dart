import 'package:flutter/material.dart';
import 'package:mobile/services/network/AppException.dart';
import '../services/network/RoomService.dart';
import '../models/Room.dart';

class MenuViewModel extends ChangeNotifier {
  String _nickname = "Testowy123";

  String get nickname => _nickname;

  String messageError = "";

  void joinGame(BuildContext context) {
    notifyListeners();
  }

  void showPublicRoomsList(BuildContext context) {
    notifyListeners();
  }

  Future <bool> createGame(Room room) async {
    // Tutaj logika tworzenia nowego pokoju
    try {
      await RoomService().createRoom(room);
      notifyListeners();
      return true; // Zwracaj true w przypadku sukcesu
    } on FetchDataException catch (e) {
      // Obsłuż błąd braku połączenia internetowego
      messageError = "No internet connection";
      return false; // Zwracaj false w przypadku błędu
    } catch (e) {
      // Obsługa innych błędów, jeśli wystąpią
      messageError = 'An error occurred: $e';
      return false; // Zwracaj false w przypadku innych błędów
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
