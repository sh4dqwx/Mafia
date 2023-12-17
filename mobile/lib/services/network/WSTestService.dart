import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class WSTestService {
  late StompClient _stompClient;
  final Completer<void> _completer = Completer<void>();

  WSTestService();

  void _onConnect(StompFrame frame) {
    debugPrint("Connected");
    _stompClient.subscribe(destination: "/topic/message", callback: (frame) {
      dynamic result = jsonDecode(frame.body!);
    });
    _completer.complete();
  }


  Future<void> connect() async {
    _stompClient = StompClient(config: StompConfig(
      url: "ws://e971-91-239-155-102.ngrok-free.app/ws",
      onConnect: _onConnect,
      beforeConnect: () async {
        debugPrint("connecting...");
      }
    ));
    _stompClient.activate();
    await _completer.future;
  }

  void sendMessage() {
    _stompClient.send(
      destination: "/app/message",
      body: jsonEncode({ "message": "Very cool message" })
    );
  }
}