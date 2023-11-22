import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/services/network/AppException.dart';
import 'package:mobile/models/Account.dart';

class AccountService {

  final String baseUrl = "";

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

  Future<void> createAccount(Account account) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/accounts"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(account.toJson()),
      );

      var responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}