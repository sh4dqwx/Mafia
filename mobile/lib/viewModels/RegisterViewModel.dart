import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/network/AccountService.dart';

class RegisterViewModel extends ChangeNotifier {

  final AccountService _accountService = AccountService();

  bool _loading = false;
  bool get loading => _loading;
  void _setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<bool> register(String login, String email, String password) async {
    _setLoading(true);
    try {
      await _accountService.register(login, email, password);
      _setLoading(false);
      return true;
    } catch(e) {
      _setLoading(false);
      return false;
    }
  }

  void reset() {
    _loading = false;
  }
}
