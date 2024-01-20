import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile/services/network/NetworkException.dart';
import 'package:mobile/models/Account.dart';
import 'package:mobile/utils/Constants.dart' as Constants;
import 'package:mobile/utils/NetworkUtils.dart';
class AccountService {

  final String baseUrl = "http://${Constants.baseUrl}";

  Future<Account> getAccount(String username) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/account/$username")
      );
      return handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException(e.message);
      } else {
        rethrow;
      }
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/account/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password
        }),
      );
      return handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException(e.message);
      } else {
        rethrow;
      }
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/account/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'email': email,
        }),
      );
      return handleResponse(response);
    } catch (e) {
       if (e is SocketException) {
         throw FetchDataException(e.message);
       } else {
         rethrow;
      }
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/account/logout")
      );
      return handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        throw FetchDataException(e.message);
      } else {
        rethrow;
      }
    }
  }
}