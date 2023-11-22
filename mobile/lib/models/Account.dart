import 'package:flutter/cupertino.dart';

class Account {
  int id;
  String login;
  String password;
  String email;
  String nickname;


  Account({
    required this.id,
    required this.login,
    required this.password,
    required this.email,
    required this.nickname
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        id: json['id'],
        login: json['login'],
        password: json['password'],
        email: json['email'],
        nickname: json['nickname']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'password': password,
      'email': email,
      'nickname': nickname
    };
  }
}
