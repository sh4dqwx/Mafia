import 'package:flutter/material.dart';
import 'package:mobile/Views/Login.dart';
import 'package:mobile/Views/PublicRooms.dart';
import 'package:mobile/viewModels/MenuViewModel.dart';
import 'package:provider/provider.dart';
import '../models/Room.dart';
import 'JoinPrivateRoom.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Menu')
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25.0),
            const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinPrivateRoomPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 25.0, 60),
                textStyle: const TextStyle(fontSize: 32.0),
              ),
              child: const Text('Enter room code'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context.read<MenuViewModel>().showPublicRoomsList(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PublicRoomsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 25.0, 60),
                textStyle: const TextStyle(fontSize: 32.0),
              ),
              child: const Text('Public rooms list'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 32.0),
              ),
              child: const Text('Create new room'),
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context.read<MenuViewModel>().gameHistory(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 32.0),
              ),
              child: const Text('Game history'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context.read<MenuViewModel>().settings(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 32.0),
              ),
              child: const Text('Settings'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 32.0),
              ),
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
