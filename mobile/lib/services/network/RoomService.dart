import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/services/network/AppException.dart';
import 'package:mobile/models/Room.dart';

class RoomService {

  final String baseUrl = "";

  Future<Room> getRoom(int roomId) async {
    try {
      final response = await http.get(
          Uri.parse("$baseUrl/room/$roomId"));
      return Room.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<List<Room>> getAllRooms() async {
    try {
      final response = await http.get(
          Uri.parse("$baseUrl/room"));
      if (response.statusCode == 200) {
        List<dynamic> roomsJson = jsonDecode(response.body);
        List<Room> rooms = roomsJson
            .map((json) => Room.fromJson(json as Map<String, dynamic>))
            .toList();
        return rooms;
      } else {
        throw FetchDataException('Failed to load rooms');
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<void> createRoom(Room room) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/room"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(room.toJson()),
      );

      var responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<void> modifyRoomProperties(Room room) async { //Logika zmiany ustawień jest jeszcze nie ustalona
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/room/properties"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(room.toJson()), //Może będzie trzeba stworzyć tabelę i obiekt ustawień
      );

      var responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}