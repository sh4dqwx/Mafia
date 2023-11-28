import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier {
  String _nickname = "Testowy123";

  String get nickname => _nickname;

  void joinGame(BuildContext context) {
    // Przejście do widoku dołączania do poczekalni
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JoinGameView()),
    );*/

    // Powiadomienie listenerów o zmianie stanu
    notifyListeners();
  }

  void createGame(BuildContext context) {
    // Przejście do widoku tworzenia poczekalni
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateGameView()),
    );*/

    // Tymczasowo (?) przejście do widoku poczekalni
    // Zakomentowane, bo nie ma merga z widokiem poczekalni
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => WaitingRoom()),
    // );

    // Powiadomienie listenerów o zmianie stanu
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
