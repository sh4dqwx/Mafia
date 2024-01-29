import 'package:flutter/material.dart';

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
        'Winner: $_winner',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
