import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatefulWidget {
  @override
  RoomPageState createState() => RoomPageState();
}

class RoomPageState extends State<RoomPage> {
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
      body: Consumer //<RoomViewModel>
        (
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //'Number of Players:  ${viewModel.numberOfPlayers}',
                      'Number of Players: 1',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        //viewModel.startGame;
                      },
                      child: const Text('Start the game'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                        textStyle: const TextStyle(fontSize: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // if (viewModel.isHost)
                    ElevatedButton(
                      onPressed: () {
                        //viewModel.openGameSettings;
                      },
                      //onPressed: viewModel.openGameSettings,
                      child: const Text('Game Settings'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        textStyle: const TextStyle(fontSize: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Text('Code: ${viewModel.roomCode}'),
                    Text('Code: XYZ'),
                    //  if (viewModel.isHost)
                    //  const Text('You are the host'),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    // Otwieranie chatu
                    print('Open chat');
                  },
                  child: const Icon(
                    Icons.chat,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}