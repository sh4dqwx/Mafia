import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:mobile/utils/Constants.dart' as Constants;
import '../models/Room.dart';

class WebSocketManager {
  static WebSocketManager? _instance;
  late StompClient _stompClient;
  late int roomId;

  final String baseUrl = "ws://${Constants.baseUrl}";

  final _roomUpdate = StreamController<Room>.broadcast();
  Stream<Room> get roomUpdate => _roomUpdate.stream;

  WebSocketManager._internal();
  factory WebSocketManager() {
    _instance ??= WebSocketManager._internal();
    return _instance!;
  }

  void _onConnect(StompFrame frame) {
    _stompClient.subscribe(
      destination: "/topic/room/$roomId",
      callback: (frame) {
        Map<String, dynamic> roomJson = jsonDecode(frame.body!);
        _roomUpdate.add(Room.fromJson(roomJson));
      }
    );
  }

  Future<void> connect(int roomId) async {
    this.roomId = roomId;
    _stompClient = StompClient(config: StompConfig(
      url: "$baseUrl/ws",
      onConnect: _onConnect
    ));
    _stompClient.activate();
  }

  void dispose() {
    _roomUpdate.close();
    _stompClient.deactivate();
  }
}