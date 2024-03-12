import 'package:flutter/material.dart';
import 'package:mobile/services/WebSocketClient.dart';
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
  final WebSocketClient webSocketClient = WebSocketClient();

  @override
  Widget build(BuildContext context) {
    return Consumer<VotingViewModel>(
      builder: (context, viewModel, child) {
        List<Player> players = viewModel.getPlayers();
        Map<String, int> votesCount = viewModel.getVotesCount();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: players.length - 1,
            itemBuilder: (context, index) {
              List<Widget> elements = [];
              for (Player player in players) {
                if(player.nickname == webSocketClient.username) continue;
                elements.add(
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: PlayerButton(
                      player: player,
                      onPressed: () => viewModel.vote(player.nickname),
                      votesCount: votesCount[player.nickname] ?? 0,
                    )
                  )
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: elements,
              );
            },
          )
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     for (Player player in players) {
          //       PlayerButton(
          //         player: player,
          //         onPressed: () => viewModel.vote(player.nickname),
          //         votesCount: votesCount[player.nickname] ?? 0,
          //       ),
          //       SizedBox(height: 8.0),
          //     }
          //   ],
          // ),
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
        onPressed: player.canVote && player.nickname != context.watch<VotingViewModel>().votedPlayer?.nickname ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                player.nickname,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0), //nie dziala
              Text(
                'Głosy: $votesCount',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }
}