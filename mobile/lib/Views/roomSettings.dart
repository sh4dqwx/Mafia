import 'package:flutter/material.dart';

class roomSettings extends StatefulWidget {
  @override
  _roomSettingsState createState() => _roomSettingsState();
}

class _roomSettingsState extends State<roomSettings> {
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
                Text('Public'),
                Radio(
                  value: true,
                  groupValue: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                ),
                Text('Private'),
                Radio(
                  value: false,
                  groupValue: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                ),
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
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
