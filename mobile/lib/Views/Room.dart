import 'package:flutter/material.dart';
import '../Views/RoomSettings.dart';
import '../viewModels/RoomViewModel.dart';

class RoomPage extends StatefulWidget {
  late final RoomViewModel roomViewModel;
  late final RoomSettings roomSettings;

  RoomPage({required this.roomViewModel});

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
    hostNick = widget.roomViewModel.hostNick;
    accessCode = widget.roomViewModel.accessCode;
    isPublic = widget.roomSettings.isPublic;
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
      body: StreamBuilder<List<String>>(
        stream: widget.roomViewModel.userListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> userList = snapshot.data!;

            return Column(
              children: [
                // ... existing code ...

                // Display the updated user count
                Text(
                  'Players: ${userList.length}',
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
                      for (String uzytkownik in userList)
                        ListTile(
                          title: Text(uzytkownik),
                          onTap: () {
                            // Obsługa naciśnięcia na innych graczy
                          },
                        ),
                    ],
                  ),
                ),

                // ... existing code ...
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator(); // Loading indicator
          }
        },
      ),
    );
  }
}
