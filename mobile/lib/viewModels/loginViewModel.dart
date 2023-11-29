import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/network/AccountService.dart';
import 'package:mobile/models/Account.dart';

class loginViewModel with ChangeNotifier {

  final _myRepo = AccountService();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loginAccount (String log, String pass, BuildContext context) async {

    setLoading(true);

    Account myAccount = Account(
      id: 1,
      login: log,
      password: pass,
      email: 'mail',
      nickname: log,
    );

    //tymczasowo createAccount, metoda bedzie zmieniona
    _myRepo.createAccount(myAccount).then((value){
      setLoading(false);
      //  nawigacja do ekranu głównego
      // Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode){
       // print(value.toString());
      }

    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}