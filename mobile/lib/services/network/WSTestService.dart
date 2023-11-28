import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WSTestService {
  late WebSocketChannel _channel;

  WSTestService();

  Future<void> connect() async {
    _channel = IOWebSocketChannel.connect("ws://175c-91-239-155-102.ngrok-free.app/ws-test");
    debugPrint("Connected");
    _channel.stream.listen((message) {
      debugPrint("Received: $message");
    });
  }

  void sendMessage() {
    try {
      _channel.sink.add(jsonEncode({ "action": "sendMessage", "message": "This is my message" }));
      debugPrint("Sent message");
    } catch(e) {
      debugPrint("error: $e");
    }
  }

  void close() {
    _channel.sink.close();
    debugPrint("Closed connection");
  }
}