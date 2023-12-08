import 'package:flutter/cupertino.dart';

class Room {
  int id;
  int idHost;
  int idGame;
  String accessCode;

  Room({
    required this.id,
    required this.idHost,
    required this.idGame,
    required this.accessCode
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        id: json['id'],
        idHost: json['idHost'],
        idGame: json['idGame'],
        accessCode: json['accessCode']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idHost': idHost,
      'idGame': idGame,
      'accessCode': accessCode
    };
  }
}
