import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _id = "";
  String _nombre = "";
  String _apellido = "";
  String _email = "";
  String _telefono = "";
  String _image = "";
  List<String> _role = [];
  String _token = "";
  bool _loading = false;

  final storage = const FlutterSecureStorage();

  set id(id) {
    _id = id.toString();
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

  Future<void> loadingUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('userId')!;
    _nombre = prefs.getString('userNombre')!;
    _apellido = prefs.getString('userApellido')!;
    _telefono = prefs.getString('userTelefono')!;
    _email = prefs.getString('userEmail')!;
    _image = prefs.getString('userImage')!;
    _role = prefs.getStringList('userRole')!;
  }
}
