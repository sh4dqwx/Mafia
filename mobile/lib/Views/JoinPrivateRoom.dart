import 'package:flutter/material.dart';

class JoinPrivateRoom extends StatefulWidget {
  TextEditingController lobbyCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: lobbyCodeController,
                decoration: const InputDecoration(
                  hintText: 'Enter the Room Code',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String accessCode = lobbyCodeController.text;
                if (//context.read<JoinPrivateRoomViewModel>().validateLobbyCode(accessCode)
                         ) {
                 // context.read.<JoinPrivareRoomViewModel>().join(accessCode);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter the correct Room Code'),
                    ),
                  );
                }
              },
              child: Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}

