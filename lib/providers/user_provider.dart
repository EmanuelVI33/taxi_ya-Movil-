import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  int _id = 0;
  String _nombre = "";
  String _apellido = "";
  String _email = "";
  String _telefono = "";
  String _image = "";
  String _token = "";
  bool _loading = false;

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

  set telefono(telefono) {
    _telefono = telefono;
  }

  get telefono => _telefono;

  set token(token) {
    _token = token;
  }

  get token => _token;

  set loading(loading) {
    _loading = loading;
  }

  get image => _image;

  set image(image) {
    _image = image;
  }

  get loading => _loading;

  bool existNull() =>
      _nombre == '' || _apellido == '' || _telefono == '' || _email == '';
}
