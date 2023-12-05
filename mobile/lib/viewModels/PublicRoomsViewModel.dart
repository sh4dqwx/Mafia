import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/Room.dart';
import 'package:mobile/services/network/RoomService.dart';

class PublicRoomsViewModel with ChangeNotifier {
  final RoomService _roomService = RoomService();
  List<Room> _publicRooms = [];

  List<Room> get publicRooms => _publicRooms;

  Future<void> fetchPublicRooms() async {
    try {
      List<Room> pokoje = await _roomService.getAllRooms();
      _publicRooms = pokoje;
      notifyListeners();
    } catch (e) {
      print('Error while fetching room list: $e');
    }
  }

  void pressed(BuildContext context, Room room) {
    /* Przekierowanie do pokoju
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Room(room: room),
      ),
    );*/
  }
}
