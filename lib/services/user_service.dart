import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/providers/providers.dart';

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

  Future<void> loaded(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.existNull()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      ApiResponse response = await show(userId);
      if (response.error == null) {
        final user = response.data as User;
        userProvider.setUser(user.id, user.nombre, user.apellido, user.telefono,
            user.email, user.image, user.isDriver, user.token);
      } else {
        Navigator.popAndPushNamed(context, 'login');
      }
    }
  }

  Future<ApiResponse> sendRequest(BuildContext context, String userId) async {
    ApiResponse apiResponse = ApiResponse();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.get(
      Uri.parse('$solicitudEnvio/$userId'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    try {
      if (response.statusCode == 201) {
        apiResponse.data = RequestDriver.fromJson(json.decode(response.body));
      } else {
        apiResponse.error = 'No tiene una solicitud registrada';
      }
    } catch (e) {
      apiResponse.error = 'Ha occurrido un error';
    }

    return apiResponse;
  }
}
