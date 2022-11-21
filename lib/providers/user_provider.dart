import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/models.dart';

class UserProvider extends ChangeNotifier {
  int _id = 0;
  String _nombre = "";
  String _apellido = "";
  String _email = "";
  String _phone = "";
  String _token = "";

  set id(id) {
    _id = id;
  }

  get id => _id;

  set nombre(nombre) {
    _nombre = nombre;
  }

  get nombre => _nombre;

  set apellido(apellido) {
    _apellido = apellido;
  }

  get apellido => _apellido;

  set email(email) {
    _email = email;
  }

  get email => _email;

  set phone(phone) {
    _phone = phone;
  }

  get phone => _phone;

  set token(token) {
    _token = token;
  }

  get token => _token;

  Future<void> DetailUser(User user) async {
    _nombre = user.nombre ?? "";
    _apellido = user.apellido ?? "";
    _phone = user.telefono ?? "";
    _email = user.email ?? "";
  }
}
