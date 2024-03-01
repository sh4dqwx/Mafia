import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile/viewModels/WinnerRoleViewModel.dart';

class WinnerPage extends StatefulWidget {
  @override
  _WinnerPageState createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  String _winner = "Mafia";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Your role is: ${_winner}',
            // '${context.watch<WinnerRoleViewModel>().userRole}',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
