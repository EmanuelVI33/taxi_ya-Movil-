import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/constant.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/models/user.dart';

class AuthService extends ChangeNotifier {
  static const headers = {
    'Accept': 'application/json',
  };

  final storage = const FlutterSecureStorage();

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

  Future<void> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id.toString());
    await prefs.setString('userNombre', user.nombre ?? '');
    await prefs.setString('userApellido', user.apellido ?? '');
    await prefs.setString('userEmail', user.email ?? '');
    await prefs.setString('userTelefono', user.telefono ?? '');
    await prefs.setString('userImage', user.image ?? '');
    await prefs.setStringList('userRole', user.role ?? []);
    await prefs.setString('token', user.token ?? '');
  }

  Future<Map<String, dynamic>> getUser() async {
    Map<String, dynamic> datas = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    datas = {
      'id': prefs.getString('userId'),
      'nombre': prefs.getString('userNombre'),
      'apellido': prefs.getString('userApellido'),
      'email': prefs.getString('userEmail'),
      'telefono': prefs.getString('userTelefono'),
      'image': prefs.getString('userImage'),
      'roles': prefs.getStringList('userRoles'),
      'token': prefs.getString('token'),
    };

    return datas;
  }
}
