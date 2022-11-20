import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taxi_ya/constant.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/models/user.dart';
import 'package:taxi_ya/providers/user_provider.dart';

class AuthService extends ChangeNotifier {
  static const headers = {
    'Accept': 'application/json',
  };

  final storage = FlutterSecureStorage();

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(loginUrl),
          headers: headers, body: {'email': email, 'password': password});
      if (response.statusCode == 201) {
        User user = User.fromJson(json.decode(response.body));
        storage.write(key: "token", value: user.token);
        storage.write(key: "userId", value: user.id.toString());
        apiResponse.data = user;
      } else {
        apiResponse.error = "Ha ocurrido un error";
      }
    } catch (e) {
      apiResponse.error = "Ha ocurrido un error";
      return apiResponse;
    }
    return apiResponse;
  }

  Future<ApiResponse> register(String nombre, String apellido, String telefono,
      String email, String password, String passwordConfirmation) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response =
          await http.post(Uri.parse(registerUrl), headers: headers, body: {
        'nombre': nombre,
        'apellido': apellido,
        'telefono': telefono,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      });
      if (response.statusCode == 201) {
        User user = User.fromJson(json.decode(response.body));
        storage.write(key: "token", value: user.token);
        storage.write(key: "userId", value: user.id.toString());
        apiResponse.data = user;
      } else {
        apiResponse.error = "Ha ocurrido un error";
      }
    } catch (e) {
      apiResponse.error = "Ha ocurrido un error";
      return apiResponse;
    }
    return apiResponse;
  }

  // Logout
  Future<void> logout() async {
    return await storage.deleteAll();
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
