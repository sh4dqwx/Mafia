import 'package:flutter/material.dart';

class JoinPrivateRoom extends StatelessWidget {
  TextEditingController lobbyCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Room'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: lobbyCodeController,
                decoration: InputDecoration(
                  hintText: 'Enter the Room Code',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String lobbyCode = lobbyCodeController.text;
                if (lobbyCode.isNotEmpty) {
                  //ekran poczekalni o danym kodzie
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter the Room Code'),
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

