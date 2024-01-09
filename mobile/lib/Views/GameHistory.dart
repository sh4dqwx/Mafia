import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/GameHistoryViewModel.dart';

class GameHistoryPage extends StatefulWidget {
  const GameHistoryPage({Key? key}) : super(key: key);

  @override
  _GameHistoryPageState createState() => _GameHistoryPageState();
}

class _GameHistoryPageState extends State<GameHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<GameHistoryViewModel>().fetchGameHistory();
  }

  @override
  Widget build(BuildContext context) {
    List<Game> gameHistory = context.watch<GameHistoryViewModel>().gameHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            const SizedBox(height: 25.0),
            const Text(
              'Game History',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25.0),
            for (Game game in gameHistory)
              ListTile(
                title: Text('Game - ${game.date.toString()}'),
                subtitle: Text(game.won ? 'Won' : 'Lost'),
              ),
          ],
        ),
      ),
    );
  }
}