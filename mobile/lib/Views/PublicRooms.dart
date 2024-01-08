import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Room.dart';
import '../viewModels/PublicRoomsViewModel.dart';

class PublicRoomsPage extends StatefulWidget {
  const PublicRoomsPage({super.key});

  @override
  PublicRoomsPageState createState() => PublicRoomsPageState();
}

class PublicRoomsPageState extends State<PublicRoomsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PublicRoomsViewModel>().fetchPublicRooms();
  }

  @override
  Widget build(BuildContext context) {
    List<Room> publicRooms = context.watch<PublicRoomsViewModel>().publicRooms;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Public Rooms'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            const SizedBox(height: 25.0),
            const Text(
              'Choose a Public Room',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25.0),
            for (Room room in publicRooms)
              ElevatedButton(
                onPressed: () {
                  //context.read<PublicRoomsViewModel>().pressed(room);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  textStyle: const TextStyle(fontSize: 32.0),
                ),
                child: Text(room.id.toString()),
              ),
          ],
        ),
      ),
    );
  }
}
