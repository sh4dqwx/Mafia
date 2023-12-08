import 'package:flutter/material.dart';

class RoomSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RoomSettingsPage(),
    );
  }
}

class RoomSettingsPage extends StatefulWidget {
  @override
  _RoomSettingsState createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettingsPage> {
  bool _isPublic = true; // Default to public room
  int _numberOfPlayers = 6; // Default number of players

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room Type:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                ),
                Text('Public'),
                Radio(
                  value: false,
                  groupValue: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                ),
                Text('Private'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Number of Players:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _numberOfPlayers.toDouble(),
              min: 4,
              max: 10,
              divisions: 6,
              label: _numberOfPlayers.toString(),
              onChanged: (value) {
                setState(() {
                  _numberOfPlayers = value.round();
                });
              },
            ),
            Text('$_numberOfPlayers Players'),
            SizedBox(height: 20.0),
            ElevatedButton(
              // komentarz bo niepołączone branche
              onPressed: () => {}, //_viewModel.createGame(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                textStyle: TextStyle(fontSize: 32.0),
              ),
              child: Text('Save'),
            ),
          ],

        ),
      ),
    );
  }
}
