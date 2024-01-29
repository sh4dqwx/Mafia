import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/VotingViewModel.dart';

class VotingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VotingViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Głosowanie'),
        ),
        body: VotingBody(),
      ),
    );
  }
}
class VotingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VotingViewModel>(
      builder: (context, viewModel, child) {
        List<Player> players = viewModel.getPlayers();
        Map<int, String> roles = viewModel.getRoles();
        Map<int, int> votesCount = viewModel.getVotesCount();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (Player player in players)
                PlayerButton(
                  player: player,
                  onPressed: () => vote(context, viewModel, player.id),
                  votesCount: votesCount[player.id] ?? 0,
                ),
            ],
          ),
        );
      },
    );
  }

  void vote(BuildContext context, VotingViewModel viewModel, int playerId) {
    viewModel.vote(playerId);
  }
}

class PlayerButton extends StatelessWidget {
  final Player player;
  final VoidCallback onPressed;
  final int votesCount;

  PlayerButton({
    required this.player,
    required this.onPressed,
    required this.votesCount,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: player.canVote ? onPressed : null,
      child: Column(
        children: [
          Text(player.nickname),
          Text('Głosy: $votesCount'),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
    );
  }
}