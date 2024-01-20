import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/services/network/NetworkException.dart';
import 'package:mobile/models/Room.dart';
import 'package:mobile/utils/Constants.dart' as Constants;
import 'package:mobile/utils/NetworkUtils.dart';
import '../../models/RoomSettings.dart';

class RoomService {

  final String baseUrl = "http://${Constants.baseUrl}";

  Future<List<Room>> getPublicRooms() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/room/public"));
      if (response.statusCode == 200) {
        List<dynamic> roomsJson = jsonDecode(response.body);
        List<Room> rooms = roomsJson
            .map((json) => Room.fromJson(json as Map<String, dynamic>))
            .toList();
        return rooms;
      } else {
        throw FetchDataException('Failed to load rooms');
      }
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException('No Internet Connection');
      } else {
        rethrow;
      }
    }
  }

  Future<Room> joinRoomById(int roomId) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/room/$roomId"));
      return handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException('No Internet Connection');
      } else {
        rethrow;
      }
    }
  }

  Future<Room> joinRoomByAccessCode(String accessCode) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/room/code/$accessCode"));
      return handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException('No Internet Connection');
      } else {
        rethrow;
      }
    }
  }

  Future<Room> createRoom() async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/room"));
      return handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException('No Internet Connection');
      } else {
        rethrow;
      }
    }
  }

  Future<void> modifyRoomProperties(RoomSettings roomSettings) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/room/properties"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(roomSettings.toJson()),
      );
      return handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException('No Internet Connection');
      } else {
        rethrow;
      }
    }
  }
}