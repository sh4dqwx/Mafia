import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/models/local/AppException.dart';
import 'package:mobile/models/remote/network/BaseApiService.dart';
import 'package:mobile/models/local/Account.dart';

class AccountService{

  final String baseUrl ="";

  Future<Account> getAccount(int accountId) async {
    try {
      final response = await http.get(
          Uri.parse("$baseUrl/accounts/$accountId"));
      return Account.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }


}