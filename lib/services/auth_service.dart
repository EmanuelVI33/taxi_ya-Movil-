import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/constant.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/models/user.dart';

class AuthService extends ChangeNotifier {
  static const headers = {
    'Accept': 'application/json',
  };

  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(Uri.parse(loginUrl),
          headers: headers, body: {'email': email, 'password': password});
      if (response.statusCode == 201) {
        User user = User.fromJson(json.decode(response.body));
        await prefs.setString('userId', user.id.toString());
        await prefs.setString('token', user.token ?? '');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response =
          await http.post(Uri.parse(registerUrl), headers: headers, body: {
        'nombre': nombre,
        'apellido': apellido,
        'telefono': telefono,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      if (response.statusCode == 201) {
        final user = User.fromJson(json.decode(response.body));
        await prefs.setString('userId', user.id.toString());
        await prefs.setString('token', user.token ?? '');
        // setUser(user);
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
  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> readId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? '';
  }
}
