import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:mobile/utils/CustomHttpClient.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:mobile/utils/Constants.dart' as Constants;
import '../models/GameStart.dart';
import '../models/Room.dart';

class WebSocketClient {
  static WebSocketClient? _instance;
  StompClient? _stompClient;
  late int roomId;
  late String username;
  late String password;

  final String baseUrl = "ws://${Constants.baseUrl}";

  final _roomUpdate = StreamController<Room>();
  Stream<Room> get roomUpdate => _roomUpdate.stream;

  final _gameStartUpdate = StreamController<GameStart>();
  Stream<GameStart> get gameStartUpdate => _gameStartUpdate.stream;

  WebSocketClient._internal();
  factory WebSocketClient() {
    _instance ??= WebSocketClient._internal();
    return _instance!;
  }

  void setCredentials(String username, String password) {
    this.username = username;
    this.password = password;
  }

  void _onConnect(StompFrame frame) {
    _stompClient?.subscribe(
      destination: "/topic/$roomId/room",
      callback: (frame) {
        Map<String, dynamic> roomJson = jsonDecode(frame.body!);
        _roomUpdate.add(Room.fromJson(roomJson));
      }
    );
    _stompClient?.subscribe(
        destination: "/user/queue/game-start",
        callback: (frame) {
          Map<String, dynamic> gameStartJson = jsonDecode(frame.body!);
          _gameStartUpdate.add(GameStart.fromJson(gameStartJson));
        }
    );
  }

  Future<void> connect(int roomId) async {
    if (_stompClient != null && _stompClient!.connected) {
      return;
    }

    this.roomId = roomId;
    Completer<void> connectionCompleter = Completer<void>();

    StompConfig config = StompConfig(
        url: "$baseUrl/ws",
        onConnect: (StompFrame frame) {
          _onConnect(frame);
          connectionCompleter.complete();
        },
        onDisconnect: (StompFrame frame) {
          print("disconnected");
        },
        stompConnectHeaders: {
          'login': username,
          'passcode': password
        }
    );
    _stompClient = StompClient(config: config);
    _stompClient?.activate();

    return connectionCompleter.future;
  }

  void dispose() {
    _roomUpdate.close();
    _stompClient?.deactivate();
  }
}