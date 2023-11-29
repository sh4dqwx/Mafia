import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/Account.dart';
import '../services/network/AccountService.dart';

class registerViewModel with ChangeNotifier {

  final _myRepo = AccountService();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool isRegistered=true; //tymczasowo aby sie view nie rozwalil, ale to chodzi o to aby zwracalo true jak zapisze w bazie

  Future<void> createAccount (String log, String mail, String pass, BuildContext context) async {
    setLoading(true);
    Account myAccount = Account(
      id: 1,
      login: log,
      password: pass,
      email: mail,
      nickname: log,
    );

    _myRepo.createAccount(myAccount).then((value){
      setLoading(false);
      //  nawigacja do ekranu głównego
      // Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode){
      //  print(value.toString());
      }

    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}