import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  int _id = 0;
  String _email = "";
  String _phone = "";
  String _token = "";

  set id(id) {
    _id = id;
  }

  get id => _id;

  set email(email) {
    _email = email;
  }

  get email => _email;

  set phone(email) {
    _phone = phone;
  }

  get phone => _phone;

  set token(token) {
    _token = token;
  }

  get token => _token;
}
