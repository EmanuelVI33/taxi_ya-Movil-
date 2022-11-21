import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taxi_ya/constant.dart';
import 'package:taxi_ya/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_ya/models/models.dart';

class UserService extends ChangeNotifier {
  static const headers = {
    'Accept': 'application/json',
  };

  Future<ApiResponse> getDetailUser() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}/user'),
        headers: headers,
      );
      if (response.statusCode == 201) {
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
