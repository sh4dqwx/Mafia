import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/models/RoomSettings.dart';
import 'package:mobile/viewModels/RoomSettingsViewModel.dart';

class RoomSettingsPage extends StatefulWidget {
  @override
  _RoomSettingsPageState createState() => _RoomSettingsPageState();
}

class _RoomSettingsPageState extends State<RoomSettingsPage> {
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
              onPressed: () async {
                RoomSettings roomSettings = RoomSettings(
                  isPublic: _isPublic,
                  numberOfPlayers: _numberOfPlayers,
                );
                await context.read<RoomSettingsViewModel>().saveGameSettings(
                    roomSettings);
              },
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

