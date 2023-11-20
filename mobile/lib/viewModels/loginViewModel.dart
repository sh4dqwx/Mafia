import 'package:flutter/material.dart';

class loginViewModel {
  loginViewModel();

  String _username = "";
  String _password = "";

  String get username => _username;
  String get password => _password;

  void setUsername(String username){
    _username = username;
  }

  void setPassword(String password){
    _password = password;
  }

}