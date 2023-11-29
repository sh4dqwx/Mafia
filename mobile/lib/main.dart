import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/loginViewModel.dart';
import '../views/Login.dart';
import '../viewmodels/registerViewModel.dart';
import '../views/Register.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => registerViewModel(),
      child: MaterialApp(
        title: 'Register App',
        home: Register(),
      ),
    ),
  );
}