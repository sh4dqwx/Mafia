import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/services/network/AppException.dart';
import 'package:mobile/models/Account.dart';

class AccountService {

  final String baseUrl = "https://786c-91-239-155-102.ngrok-free.app";

  Future<Account> getAccount(int accountId) async {
    try {
      final response = await http.get(
          Uri.parse("$baseUrl/account/$accountId"));
      return Account.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<dynamic> register(String login, String email, String password) async {
    try {
      final http.Response response = await http.post(
        Uri.parse("$baseUrl/account"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'login': login,
          'email': email,
          'password': password
        }),
      );

      if(response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        print(responseJson);
        return responseJson;
      } else {
        throw FetchDataException('Error occured while communication with server with status code : ${response.statusCode}');
      }
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