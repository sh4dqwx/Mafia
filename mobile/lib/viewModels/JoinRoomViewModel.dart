import 'package:flutter/material.dart';
import '../services/network/RoomService.dart';
//import '../Views/Room.dart';

class JoinPrivateRoomViewModel {
  final TextEditingController lobbyCodeController = TextEditingController();
  final BuildContext context;
  final RoomService roomService;

  JoinPrivateRoomViewModel(this.context, this.roomService);

  Future<void> joinRoom() async {
    String lobbyCode = lobbyCodeController.text;
    if (lobbyCode.isNotEmpty) {
      /*  ZAKOMENTOWANA CAŁOŚĆ BO NIE MA MERGA Z BRANCHEM GDZIE JEST ROOM
      try {
        Room room = await roomService.getRoom(int.parse(lobbyCode));

        // Dodaj weryfikację zgodności kodu dołączenia
        if (room.isValidJoinCode(lobbyCode)) {
          // Kod dołączenia jest zgodny - możesz przejść dalej
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Room(room: room)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid Room Code'),
            ),
          );
        }
      } on FetchDataException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
          ),
        );
      } on FormatException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Room Code format'),
          ),
        );
      }*/
    } else {
      /*
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the Room Code'),
        ),
      );*/
    }
  }
}
