import 'package:flutter/material.dart';
import '../Views/RoomSettings.dart';
import '../models/RoomSettings.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  RoomPageState createState() => RoomPageState();
}

class RoomPageState extends State<RoomPage> {
  String hostNick = '';
  String accessCode = '';
  bool isPublic = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room'),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Ustawienia ogólne aplikacji
              },
              child: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ... existing code ...
          // Display the updated user count
          Text(
            'Players: 5',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // ... existing code ...
          // Display the user list in the Drawer
          Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Players in room',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text(hostNick),
                      const Text(
                        '👑', // Emotikona korony
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  onTap: () {
                    // Obsługa naciśnięcia na gospodarza
                  },
                ),
                // for (String uzytkownik in userList)
                //   ListTile(
                //     title: Text(uzytkownik),
                //     onTap: () {
                //       // Obsługa naciśnięcia na innych graczy
                //     },
                //   ),
              ],
            ),
          ),
          // ... existing code ...
        ],
      )
    );
  }
}
