import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/WinnerRoleViewModel.dart';
import '../models/Room.dart';

class UserRolePage extends StatefulWidget {
  // final Room room;
  //
  // UserRolePage(this.room);

  @override
  _UserRolePageState createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  String _role = "City";

  // final WinnerRoleViewModel viewModel = context.read<WinnerRoleViewModel>();

  @override
  Widget build(BuildContext context) {

      return Container(
        alignment: Alignment.center,
        child: Text(
          'Your role is:${_role} ',
              // '${context
              // .watch<WinnerRoleViewModel>()
              // .userRole}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );

  }
}
