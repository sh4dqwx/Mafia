import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/LoginViewModel.dart';
import '../viewModels/RegisterViewModel.dart';
import 'Views/Register.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel())
      ],
      child: const MaterialApp(
        title: 'MAFIA+',
        home: RegisterPage(),
      ),
    ),
  );
}