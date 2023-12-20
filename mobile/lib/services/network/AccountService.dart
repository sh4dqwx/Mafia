import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/services/network/AppException.dart';
import 'package:mobile/models/Account.dart';

class AccountService {

  final String baseUrl = "http://localhost:8080";

  Future<Account> getAccount(int accountId) async {
    try {
      final response = await http.get(
          Uri.parse("$baseUrl/account/$accountId"));
      return Account.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException('No Internet Connection');
      } else {
        throw e;
      }
    }
  }

  Future<dynamic> login(String login, String password) async {
    try {
      final http.Response response = await http.post(
        Uri.parse("$baseUrl/account/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'login': login,
          'password': password
        }),
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        return responseJson;
      } else {
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response
                .statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException('No Internet Connection');
      } else {
        throw e;
      }
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
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        return responseJson;
      } else {
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response
                .statusCode}');
      }
    } catch (e) {
       if (e is SocketException) {
         throw FetchDataException('No Internet Connection');
       } else {
         throw e;
      }
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
        throw UnauthorisedException('Invalid login credentials');
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