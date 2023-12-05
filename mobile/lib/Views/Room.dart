import 'package:flutter/material.dart';
import 'dart:math';

class Room extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaitingRoom(),
    );
  }
}

class WaitingRoom extends StatefulWidget {
  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  int numberOfPlayers = 0;
  String roomCode = generateRandomCode();
  bool isHost = false; // czy użytkownik jest hostem

  static String generateRandomCode() {
    final Random random = Random();
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(4, (index) => chars[random.nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room'),
        backgroundColor: Colors.blue,
        actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // ustawienia dla wszysktich
                  print('Open settings');
                },
                child: Icon(
                  Icons.settings,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Number of Players: $numberOfPlayers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print('Start the game');
                  },
                  child: Text('Start the game'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(fontSize: 18),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                SizedBox(height: 10),
                if (isHost)
                  ElevatedButton(
                    onPressed: () {
                      // ustawienia gry
                      print('Open game settings');
                    },
                    child: Text('Game Settings'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      textStyle: TextStyle(fontSize: 18),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                SizedBox(height: 20),
                Text('Code: $roomCode'),
                if (isHost)
                  Text('You are the host'),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // otwieranie chatu
                print('Open chat');
              },
              child: Icon(
                Icons.chat,
                size: 40,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}