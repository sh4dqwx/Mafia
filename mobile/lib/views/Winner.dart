import 'package:flutter/material.dart';
import 'package:mobile/Views/Menu.dart';
import 'package:provider/provider.dart';

import 'package:mobile/viewModels/WinnerRoleViewModel.dart';

class WinnerPage extends StatefulWidget {
  @override
  _WinnerPageState createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<WinnerRoleViewModel>(
              builder: (context, winnerRoleViewModel, child) {
                return Text(
                  'Winner is: '
                  '${context.watch<WinnerRoleViewModel>().userRole}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuPage()));
                },
                child: Text("Powrót do menu")),
          ],
        ),
      ),
    );
  }
}
