import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/views/Menu.dart';
import 'package:provider/provider.dart';
import 'package:mobile/viewModels/VotingViewModel.dart';

import '../models/Room.dart';
import '../viewModels/VotingViewModel.dart';
import 'Room.dart';

class VotingResultsPage extends StatefulWidget {
  const VotingResultsPage({super.key});
  @override
  _VotingResultsPageState createState() => _VotingResultsPageState();
}

class _VotingResultsPageState extends State<VotingResultsPage> {
  late VotingViewModel viewModel;
  late Room room;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<VotingViewModel>(context, listen: false);
    viewModel.connectWebSocket();
    Timer(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return VotingResultsBody();
  }
}

class VotingResultsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VotingViewModel>(context, listen: false);

    return Container(
        color: Colors.white, // Kolor tła
        child: Padding(
        padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var voteInfo in viewModel.votingSummary?.results ?? [])
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  voteInfo.username,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Votes: ${voteInfo.voteCount}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
        ],
      ),
    )
    );
  }
}