import 'package:flutter/cupertino.dart';

class Room {
  int id;
  int idHost;
  int idGame;
  String accessCode;
  boolean isPublic;

  Room({
    required this.id,
    required this.idHost,
    required this.idGame,
    required this.accessCode,
    required this.isPublic
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        id: json['id'],
        idHost: json['idHost'],
        idGame: json['idGame'],
        accessCode: json['accessCode'],
        isPublic: json['isPublic']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idHost': idHost,
      'idGame': idGame,
      'accessCode': accessCode,
      'isPublic': isPublic
    };
  }
}
