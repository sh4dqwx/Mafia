import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier {
  String _nickname = "Testowy123";

  String get nickname => _nickname;

  void joinGame(BuildContext context) {
    notifyListeners();
  }

  void createGame(BuildContext context) {

    notifyListeners();
  }

  void gameHistory(BuildContext context) {
    // Przejście do widoku z historią gier
   /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameHistoryView()),
    );*/

    // Powiadomienie listenerów o zmianie stanu
    notifyListeners();
  }

  void settings(BuildContext context) {
    // Przejście do widoku ustawień
   /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsView()),
    );*/

    // Powiadomienie listenerów o zmianie stanu
    notifyListeners();
  }

  void logout() {
    // Tutaj logika do wylogowywania się

    // Powiadomienie listenerów o zmianie stanu
    notifyListeners();
  }
}
