import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class loginViewModel with ChangeNotifier {

  final _myRepo = AccountService();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> createAccount (dynamic data, BuildContext context) async {

    setLoading(true);

    _myRepo.registerApi(data).then((value){
      setLoading(false);
      //  nawigacja do ekranu głównego
      // Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode){
        print(value.toString());
      }

    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}