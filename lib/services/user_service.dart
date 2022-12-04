import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/constant.dart';

class UserService extends ChangeNotifier {
  // final storage = const FlutterSecureStorage();

  static const headers = {
    'Accept': 'application/json',
  };

  Future<ApiResponse> show(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiResponse apiResponse = ApiResponse();
    String token = prefs.getString('token') ?? '';
    try {
      final response = await http.get(
        Uri.parse('$userUrl/$userId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        User user = User.fromJson(json.decode(response.body));
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

  Future<ApiResponse> getDetailUser() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse(userDetailUrl),
        headers: headers,
      );
      if (response.statusCode == 200) {
        User user = User.fromJson(json.decode(response.body));
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
}
