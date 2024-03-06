import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/viewModels/VotingViewModel.dart';

import '../viewModels/VotingViewModel.dart';

class VotingResultsPage extends StatefulWidget {
  @override
  _VotingResultsPageState createState() => _VotingResultsPageState();
}

class _VotingResultsPageState extends State<VotingResultsPage> {

  @override
  void initState() {
    super.initState();
    context.read<VotingViewModel>().getVotesList();
  }

  @override
  Widget build(BuildContext context) {
    return VotingResultsBody();
  }
}

class VotingResultsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VotingViewModel>(
      builder: (context, viewModel, child) {
        List<Player> players = viewModel.getPlayers();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var voteInfo in context.watch<VotingViewModel>().votesList)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(voteInfo['nickname'] ?? 'puste'),
                    Text(
                      'Votes: ${voteInfo['votes'] ?? 0}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

}