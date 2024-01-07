import 'package:flutter/material.dart';
import '../services/WebSocketManager.dart';
import '../Views/RoomSettings.dart';
import '../models/Room.dart';

class RoomViewModel extends ChangeNotifier {
  late Room _room;
  late int _currentUserId;
  late WebSocketManager _webSocketManager;

  RoomViewModel(Room room, int currentUserId, WebSocketManager webSocketManager) {
    _room = room;
    _currentUserId = currentUserId;
    _webSocketManager = webSocketManager;
    startListeningToWebSocket();
  }

  String get hostNick =>
      _room.accounts.firstWhere((account) => account.id == _room.idHost).nickname;
  String get accessCode => _room.accessCode;
  List<String> get userList =>
      _room.accounts.map((account) => account.nickname).toList();
  bool get isPrivate => !_room.isPublic;

  void startGame() {
    // Implement the logic to start the game
  }

  void openGameSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomSettingsPage(),
      ),
    );
  }

  bool get isHost => _currentUserId == _room.idHost;

  // Method to start listening to WebSocket updates
  void startListeningToWebSocket() {
    _webSocketManager.roomUpdate.listen((updatedRoom) {
      // Handle the updated room data
      updateRoom(updatedRoom);
    });
  }

  // Example method to update the room data
  void updateRoom(Room newRoom) {
    _room = newRoom;
    notifyListeners();
  }

  // Clean up resources when the ViewModel is no longer needed
  @override
  void dispose() {
    _webSocketManager.dispose();
    super.dispose();
  }
}
