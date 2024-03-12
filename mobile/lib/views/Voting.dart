import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/viewModels/VotingViewModel.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});
  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  late VotingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = VotingViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voting'),
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
        Map<String, int> votesCount = viewModel.getVotesCount();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (Player player in players)
                PlayerButton(
                  player: player,
                  onPressed: () => viewModel.vote(player.nickname) ,
                  votesCount: votesCount[player.nickname] ?? 0,
                ),
              SizedBox(height: 8.0),
            ],
          ),
        );
      },
    );
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: player.canVote ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                player.nickname,
                style: TextStyle(
                  fontSize: 18.0, // Powiększamy czcionkę
                  fontWeight: FontWeight.bold, // Opcjonalnie, dodajemy pogrubienie
                ),
              ),
              SizedBox(height: 8.0), // Dodajemy odstęp między nazwą gracza a liczbą głosów
              Text(
                'Głosy: $votesCount',
                style: TextStyle(
                  fontSize: 16.0, // Powiększamy czcionkę
                ),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(16.0), // Dodajemy wypełnienie dla przycisku
          ),
        ),
      ),
    );
  }
}