import 'package:flutter/material.dart';
import 'package:mobile/viewModels/JoinPrivateRoomViewModel.dart';
import 'package:mobile/viewModels/MenuViewModel.dart';
import 'package:mobile/viewModels/RoomSettingsViewModel.dart';
import 'package:provider/provider.dart';
import '../viewModels/LoginViewModel.dart';
import '../viewModels/RegisterViewModel.dart';
import 'Views/Login.dart';
import '../viewModels/PublicRoomsViewModel.dart';
import 'Views/Register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => MenuViewModel()),
        ChangeNotifierProvider(create: (context) => JoinPrivateRoomViewModel()),
        ChangeNotifierProvider(create: (context) => PublicRoomsViewModel()),
        ChangeNotifierProvider(create: (context) => RoomSettingsViewModel())
      ],
      child: const MaterialApp(
        title: 'MAFIA+',
        home: LoginPage(),
      )
    );
  }
}