import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier{

  String _nickname = "Testowy123";

  String get nickname => _nickname;

  void joinGame(BuildContext context) {
    /* przejście do widoku dołączania do poczekalni
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => joinGameView());
     */

  }

  void createGame(BuildContext context) {
    /* przejście do widoku tworzenia poczekalni
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => createGameView());

    tymczasowo (?) przejście do widoku poczekalni
    zakomentowanie bo nie ma merga z widokiem poczekalni

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WaitingRoom());
    )

     */

  }

  void gameHistory(BuildContext context) {
    /* przejście do widoku z historią gier
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => gameHistoryView());
     */

  }

  void settings(BuildContext context) {
    /* przejście do widoku ustawień
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => creatingGameView());
     */

  }

  void logout() {
    /*

    tutaj logika do wylogowywania się

     */

  }

}