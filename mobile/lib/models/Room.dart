import 'package:flutter/cupertino.dart';

import 'Account.dart';

class Room {
  int id;
  //Account host;
  //Game game;
  String accessCode;
  //bool isPublic;
  //List<Account> accounts;

  Room({
    required this.id,
    //required this.host,
    //required this.game,
    required this.accessCode,
    //required this.isPublic,
   // required this.accounts
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        id: json['id'],
        //host: json['host'],
        //game: json['game'],
        accessCode: json['accessCode'],
        //isPublic: json['isPublic']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      //'host': host,
      //'game': game,
      'accessCode': accessCode,
      //'isPublic': isPublic
    };
  }
}
