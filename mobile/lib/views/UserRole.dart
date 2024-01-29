import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/WinnerRoleViewModel.dart';

class UserRolePage extends StatefulWidget {
  @override
  _UserRolePageState createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  // String _role = "City";


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Your role is: ${context.watch<WinnerRoleViewModel>().role}',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
