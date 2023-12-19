import 'package:flutter/material.dart';
//brak odpowiedniego viewmodela
//import '../viewModels/RoomViewModel.dart';

class RoomPage extends StatefulWidget {
  //final RoomViewModel roomViewModel; BRAK VIEWMODELA

 // RoomPage({required this.roomViewModel}); BRAK VIEWMODELA

  @override
  RoomPageState createState() => RoomPageState();
}

class RoomPageState extends State<RoomPage> {
  String hostNick = '';
  String accessCode = '';
  List<String> userList = [];
  bool isPrivate = false;

  @override
  void initState() {
    super.initState();
    // Brak viewmodela
    /*hostNick = widget.roomViewModel.getHostNick();
    accessCode = widget.roomViewModel.getAccessCode();
    userList = widget.roomViewModel.getUserList();
    isPrivate = widget.roomViewModel.getIsPrivate();*/
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Players: ${userList.length}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //viewModel.startGame;
                  },
                  child: const Text('Start game'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    //viewModel.openGameSettings;
                  },
                  child: const Text('Settings'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'AccesCode: $accessCode',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (isPrivate)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Room is PRIVATE 🔐',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                if (!isPrivate)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Room is PUBLIC 🔓',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Otwieranie chatu
                print('Otwórz czat');
              },
              child: const Icon(
                Icons.chat,
                size: 40,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
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
    );
  }
}
